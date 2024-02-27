import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../core/data_source/base_remote_data_source.dart';
import '../../../../../core/network/endpoints/network.dart';
import '../../../../../core/network/http_method.dart';
import '../../../../../core/results/result.dart';

class MediaRemoteDataSource {
  Future<Result<String>> uploadImage(File image) async {
    return await RemoteDataSource.request(
      converter: (model) => model['path'],
      formData: FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      }),
      method: HttpMethod.POST,
      getAllResponse: true,
      url: Network.upload,
    );
  }
}
