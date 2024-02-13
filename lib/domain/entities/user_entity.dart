import '../../core/models/base_entity.dart';
import '../../data/enums/user_type.dart';

class UserEntity extends BaseEntity {
  final int id;
  final String? email;
  final String? phone;
  final UserType? type;
  UserEntity({
    required this.id,
    this.email,
    this.phone,
    this.type,
  });
  @override
  List<Object?> get props => [id, email, phone, type];
}
