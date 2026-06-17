import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/entity/sucursal_listada_entity.dart';

abstract class SucursalRepository {
  Future<Either<Failure, List<SucursalListadaEntity>>> verListaSucursales();
}
