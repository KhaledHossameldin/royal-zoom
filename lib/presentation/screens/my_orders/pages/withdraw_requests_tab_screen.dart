import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../domain/entities/withdraw_request_entity.dart';
import '../../../../utilities/extensions.dart';
import '../cubit/my_orders_cubit.dart';
import '../widgets/withdraw_filter_widget.dart';
import '../widgets/withdraw_item_widget.dart';

class WithdrawRequestsTabScreen extends StatefulWidget {
  const WithdrawRequestsTabScreen({super.key});

  @override
  State<WithdrawRequestsTabScreen> createState() =>
      _WithdrawRequestsTabScreenState();
}

class _WithdrawRequestsTabScreenState extends State<WithdrawRequestsTabScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          DIManager.findDep<MyOrdersCubit>().pagingController.refresh(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.width),
        child: Column(
          children: [
            const WithdrawFilterWidget(),
            PagedListView.separated(
              shrinkWrap: true,
              pagingController:
                  DIManager.findDep<MyOrdersCubit>().pagingController,
              builderDelegate: PagedChildBuilderDelegate<WithdrawRequesEntity>(
                itemBuilder: (context, item, index) {
                  return WithDrawItemWidget(item: item);
                },
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (DIManager.findDep<MyOrdersCubit>().pagingController.itemList == null) {
      DIManager.findDep<MyOrdersCubit>()
          .pagingController
          .addPageRequestListener((pageKey) {
        DIManager.findDep<MyOrdersCubit>().showWithdrawRequests(pageKey);
      });
    }
  }
}
