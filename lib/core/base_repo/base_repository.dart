import 'dart:developer';

import '../../../../core/results/result.dart';
import '../models/base_entity.dart';
import '../models/base_model.dart';

abstract class BaseRepository {
  const BaseRepository();
  Future<Result<ENTITY>>
      mapModelToEntity<ENTITY extends BaseEntity, MODEL extends BaseModel>(
    Result<MODEL?> data,
  ) async {
    try {
      if (data.hasDataOnly) {
        return Result(data: data.data!.toEntity() as ENTITY);
      } else {
        return Result(error: data.error);
      }
    } catch (e) {
      log('err $e');
      return Result(error: data.error);
    }
  }

  /// it returns [List] of [ENTITY] wrapped inside [Result] data
  Future<Result<List<ENTITY>>>
      mapModelsToEntities<ENTITY extends BaseEntity, MODEL extends BaseModel>(
    Result<List<MODEL?>?> data,
  ) async {
    try {
      if (data.hasDataOnly) {
        return Result(
          data:
              data.data?.map<ENTITY>((e) => e?.toEntity() as ENTITY).toList() ??
                  [],
        );
      } else {
        return Result(error: data.error);
      }
    } catch (e, s) {
      log('mapModelListToEntityList error is  : $e |\n $s');
      return Result(error: data.error);
    }
  }
}
