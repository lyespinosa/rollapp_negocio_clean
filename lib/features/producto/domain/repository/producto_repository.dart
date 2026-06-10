import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_listado_entity.dart';

abstract class ProductoRepository {
  Future<Either<Failure, List<ProductoListadoEntity>>> verListaProductos();

  Future<Either<Failure, ProductoEntity>> verProductoPorId({
    required String id,
  });

  Future<Either<Failure, ProductoEntity>> crearProducto({
    required String nombre,
    required String descripcion,
    required double precio,
    required String imagenUrl,
  });

  Future<Either<Failure, ProductoEntity>> editarProducto({
    required String id,
    required String nombre,
    required String descripcion,
    required double precio,
    required String imagenUrl,
  });

  Future<Either<Failure, void>> eliminarProducto({required String id});
}
