import 'package:equatable/equatable.dart';

class ProductoEntity extends Equatable {
  final int id;
  final String nombre;
  final String description;

  const ProductoEntity({
    required this.id,
    required this.nombre,
    required this.description,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, nombre, description];
}
