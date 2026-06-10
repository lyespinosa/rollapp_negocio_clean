import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class ProductoListadoEntity extends Equatable {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagen;
  final Decimal precio;
  final int? tiempo;
  final String categoria;
  final String subcategoria;
  final bool activo;

  const ProductoListadoEntity({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.precio,
    required this.tiempo,
    required this.categoria,
    required this.subcategoria,
    required this.activo,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, nombre, descripcion, categoria];
}
