import 'package:rollapp_negocio_clean/features/sucursal/domain/entity/sucursal_listada_entity.dart';

class SucursalListadaModel extends SucursalListadaEntity {
  const SucursalListadaModel({required super.id, required super.calle});

  factory SucursalListadaModel.fromJson(Map<String, dynamic> json) {
    return SucursalListadaModel(id: json['id'] as int, calle: json['calle']);
  }
}
