import 'package:equatable/equatable.dart';

class CategoriaProductoEntity extends Equatable {
  final int id;
  final String nombre;
  final int? activo;

  const CategoriaProductoEntity({
    required this.id,
    required this.nombre,
    required this.activo,
  });

  @override
  List<Object?> get props => [id, nombre, activo];
}
