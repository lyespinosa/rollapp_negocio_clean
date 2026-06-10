import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_entity.dart';

class ProductoModel extends ProductoEntity {
  const ProductoModel({
    required super.id,
    required super.nombre,
    required super.description,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      nombre: json['producto'],
      description: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'producto': nombre, 'descripcion': description};
  }
}
