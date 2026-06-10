import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_listado_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/repository/producto_repository.dart';

class VerListaProductosUseCase
    implements UseCase<List<ProductoListadoEntity>, NoParams> {
  final ProductoRepository repository;

  VerListaProductosUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ProductoListadoEntity>>> call(NoParams params) {
    return repository.verListaProductos();
  }
}
