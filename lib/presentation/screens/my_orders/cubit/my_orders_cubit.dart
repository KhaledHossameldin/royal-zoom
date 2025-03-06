import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../core/states/base_fail_state.dart';
import '../../../../core/states/base_success_state.dart';
import '../../../../core/states/base_wait_state.dart';
import '../../../../data/models/withdraw_request_response/with_draw_filter.dart';
import '../../../../domain/entities/withdraw_request_entity.dart';
import '../../../../domain/usecases/major_verification_request_usecase.dart';
import '../../../../domain/usecases/new_major_requests_usecase.dart';
import '../../../../domain/usecases/withdraw_request_usecase.dart';
import 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit(this._newMajor, this._majorVerification, this._withdrawUseCase)
      : super(MyOrdersState.initState());

  final INewMajorRequestsUseCase _newMajor;

  void showAllNewMajorRequests() {
    emit(state.copyWith(showNewMajorsState: const BaseLoadingState()));
    _newMajor().then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(showNewMajorsState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(showNewMajorsState: BaseFailState(result.error)));
      }
    });
  }

  final IMajorVerificationRequestsUseCase _majorVerification;
  void showAllMajorVerficationRequests() {
    emit(state.copyWith(showMajorVerificationState: const BaseLoadingState()));
    _majorVerification().then((result) {
      if (result.hasDataOnly) {
        emit(state.copyWith(
            showMajorVerificationState: BaseSuccessState(result.data)));
      } else {
        emit(state.copyWith(
            showMajorVerificationState: BaseFailState(result.error)));
      }
    });
  }

  final IWithdrawRequestUseCase _withdrawUseCase;
  final PagingController<int, WithdrawRequesEntity> pagingController =
      PagingController(firstPageKey: 1);
  void showWithdrawRequests(int page) {
    _withdrawUseCase(request: _withdrawFilters).then((result) {
      if (result.hasDataOnly) {
        var meta = result.meta!;
        bool isLastPage =
            (meta.total! / meta.perPage!).ceil() == _withdrawFilters.page;
        if (isLastPage) {
          pagingController.appendLastPage(result.data!);
        } else {
          pagingController.appendPage(result.data!, _withdrawFilters.page! + 1);
        }
      } else {
        pagingController.appendLastPage([]);
        Logger().d(result.error!.message);
      }
    });
  }

  WithDrawFilterRequest _withdrawFilters = WithDrawFilterRequest(page: 1);
  void applyWithdrawFilters({
    String? sort,
    String? startDate,
    String? endDate,
    bool forceNull = false,
  }) {
    _withdrawFilters = _withdrawFilters.copyWith(
        sortType: sort,
        startDate: startDate,
        endDate: endDate,
        page: 1,
        forceNull: forceNull);
    Logger().d(_withdrawFilters.toJson());
    pagingController.refresh();
  }
}
