import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/entity/sucursal_listada_entity.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/repository/sucursal_repository.dart';

class VerListaSucursalesUseCase
    implements UseCase<List<SucursalListadaEntity>, NoParams> {
  final SucursalRepository repository;

  VerListaSucursalesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SucursalListadaEntity>>> call(NoParams params) {
    return repository.verListaSucursales();
  }
}
