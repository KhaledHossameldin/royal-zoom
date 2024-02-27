import 'package:logger/logger.dart';

import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';
import '../../../../models/refund_request_response/refund_request_response.dart';
import '../../../../models/withdraw_request_response/with_draw_filter.dart';
import '../../../../models/withdraw_request_response/withdraw_request_response.dart';

class BalanceRemoteDataSource {
  Future<Result<List<RefundRequestResponse>>> getAllRefundRequests() async {
    return await RemoteDataSource.request(
      converterList: (list) => list!
          .map((request) => RefundRequestResponse.fromJson(request))
          .toList(),
      method: HttpMethod.GET,
      url: Network.refundRequests,
    );
  }

  Future<Result<List<WithdrawRequestResponse>>> getAllWithdrawRequests(
      {required WithDrawFilterRequest request}) async {
    return await RemoteDataSource.request(
      converterList: (list) {
        final result = list!.map((model) {
          final conv = WithdrawRequestResponse.fromJson(model);
          return conv;
        }).toList();

        return result;
      },
      method: HttpMethod.GET,
      url: Network.withdrawRequests,
      queryParameters: request.toJson(),
    );
  }
}
