import 'package:rollapp_negocio_clean/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.nombre,
    required super.paterno,
    required super.correo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      paterno: json['paterno'],
      correo: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre, 'paterno': paterno, 'email': correo};
  }
}
