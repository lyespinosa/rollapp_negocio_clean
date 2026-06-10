import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/repository/producto_repository.dart';

class CrearProductoUsecase
    implements UseCase<ProductoEntity, NuevoProductoParams> {
  final ProductoRepository repository;

  CrearProductoUsecase({required this.repository});

  @override
  Future<Either<Failure, ProductoEntity>> call(
    NuevoProductoParams params,
  ) async {
    return await repository.crearProducto(
      nombre: params.nombre,
      descripcion: params.descripcion,
      precio: params.precio,
      imagenUrl: params.imagenUrl,
    );
  }
}

class NuevoProductoParams {
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagenUrl;

  NuevoProductoParams({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenUrl,
  });
}
