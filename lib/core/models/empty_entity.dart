import '../../../core/models/base_entity.dart';

class EmptyEntity extends BaseEntity {
  final dynamic data;

  EmptyEntity(this.data);

  @override
  List<Object?> get props => [data];
}
