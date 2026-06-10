import 'package:decimal/decimal.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_listado_entity.dart';

class ProductoListadoModel extends ProductoListadoEntity {
  const ProductoListadoModel({
    required super.id,
    required super.nombre,
    required super.descripcion,
    required super.imagen,
    required super.precio,
    required super.tiempo,
    required super.categoria,
    required super.subcategoria,
    required super.activo,
  });

  factory ProductoListadoModel.fromJson(Map<String, dynamic> json) {
    return ProductoListadoModel(
      id: json['id'] as int,
      nombre: json['producto'] as String,
      descripcion: json['descripcion'] as String,
      imagen: json['imagen'] as String,

      precio: Decimal.parse(json['precio'].toString()),
      tiempo: (json['tiempo'] as num?)?.toInt(),

      categoria: json['categoria']['categoria'] as String,
      subcategoria: json['subcategoria']['subcategoria'] as String,

      activo: switch (json['activo']) {
        1 => true,
        0 => false,
        _ => throw FormatException(
          'El campo activo es obligatorio y recibió: ${json['activo']}',
        ),
      },
    );
  }
}
