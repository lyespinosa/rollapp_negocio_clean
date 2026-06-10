import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/repository/producto_repository.dart';

class EditarProductoUseCase
    implements UseCase<ProductoEntity, EditarProductoParams> {
  final ProductoRepository repository;

  EditarProductoUseCase({required this.repository});

  @override
  Future<Either<Failure, ProductoEntity>> call(
    EditarProductoParams params,
  ) async {
    return await repository.editarProducto(
      id: params.id,
      nombre: params.nombre,
      descripcion: params.descripcion,
      precio: params.precio,
      imagenUrl: params.imagenUrl,
    );
  }
}

class EditarProductoParams {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagenUrl;

  EditarProductoParams({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenUrl,
  });
}
