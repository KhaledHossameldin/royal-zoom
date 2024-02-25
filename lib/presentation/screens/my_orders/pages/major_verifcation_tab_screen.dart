import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../domain/entities/new_major_entity.dart';
import '../../../../utilities/extensions.dart';
import '../cubit/my_orders_cubit.dart';
import '../cubit/my_orders_state.dart';
import '../widgets/major_item_widget.dart';

class MajorVerificationTabScreen extends StatefulWidget {
  const MajorVerificationTabScreen({super.key});

  @override
  State<MajorVerificationTabScreen> createState() =>
      _MajorVerificationTabScreenState();
}

class _MajorVerificationTabScreenState
    extends State<MajorVerificationTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.width),
      child: BlocConsumer<MyOrdersCubit, MyOrdersState>(
        bloc: DIManager.findDep<MyOrdersCubit>(),
        listener: (context, state) {},
        builder: (context, state) {
          final majorsState = state.showMajorVerificationState;
          if (majorsState is BaseLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (majorsState is BaseSuccessState) {
            final data = majorsState.data as List<NewMajorEntity>;
            return ListView.separated(
              itemBuilder: (context, index) {
                final item = data[index];
                return MajorItemWidget(
                  id: item.id!,
                  status: item.status!,
                  parentMajor: item.parentMajor!,
                  subMajor: item.neededMajor ?? '',
                  createdAt: item.createdAt!,
                  isMajorsTab: false,
                  chatId: item.chat!.id!.toInt(),
                );
              },
              separatorBuilder: (context, index) => 8.emptyHeight,
              itemCount: data.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DIManager.findDep<MyOrdersCubit>().showAllMajorVerficationRequests();
  }
}
