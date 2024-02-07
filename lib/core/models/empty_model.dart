import '../../../core/models/base_model.dart';
import '../../../core/models/empty_entity.dart';

class EmptyModel extends BaseModel {
  final dynamic data;
  const EmptyModel([this.data]);
  @override
  EmptyEntity toEntity() {
    return EmptyEntity(data);
  }
}
