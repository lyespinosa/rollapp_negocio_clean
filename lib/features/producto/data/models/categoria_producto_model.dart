import 'package:rollapp_negocio_clean/features/producto/domain/entity/categoria_producto_entity.dart';

class CategoriaProductoModel extends CategoriaProductoEntity {
  const CategoriaProductoModel({
    required super.id,
    required super.nombre,
    required super.activo,
  });

  factory CategoriaProductoModel.fromJson(Map<String, dynamic> json) {
    return CategoriaProductoModel(
      id: json['id'],
      nombre: json['categoria'],
      activo: json['activo'],
    );
  }
}
