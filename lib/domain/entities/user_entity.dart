import '../../core/models/base_entity.dart';

class UserEntity extends BaseEntity {
  final int id;
  final String? email;
  final String? phone;
  UserEntity({
    required this.id,
    this.email,
    this.phone,
  });
  @override
  List<Object?> get props => [id, email, phone];
}
