import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/repository/producto_repository.dart';

class EliminarProductoUseCase implements UseCase<void, EliminarProductoParams> {
  final ProductoRepository repository;

  EliminarProductoUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(EliminarProductoParams params) async {
    return await repository.eliminarProducto(id: params.id);
  }
}

class EliminarProductoParams {
  final String id;

  EliminarProductoParams({required this.id});
}
