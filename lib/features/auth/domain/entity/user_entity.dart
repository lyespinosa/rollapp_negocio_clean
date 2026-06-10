import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String nombre;
  final String paterno;
  final String correo;

  const UserEntity({
    required this.id,
    required this.nombre,
    required this.paterno,
    required this.correo,
  });

  @override
  List<Object?> get props => [id, nombre, paterno, correo];
}
