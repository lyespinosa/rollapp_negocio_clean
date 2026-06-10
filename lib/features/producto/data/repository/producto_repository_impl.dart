import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/exceptios.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/features/producto/data/datasource/producto_remote_datasource.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_listado_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/repository/producto_repository.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final ProductoRemoteDataSource remoteDataSource;

  ProductoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductoListadoEntity>>>
  verListaProductos() async {
    try {
      final productos = await remoteDataSource.verListaProductos();

      return Right(productos);
    } on JsonParsingException catch (e) {
      return Left(JsonParsingFailure(e.message));
    } on ModelMappingException catch (e) {
      return Left(ModelMappingFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProductoEntity>> crearProducto({
    required String nombre,
    required String descripcion,
    required double precio,
    required String imagenUrl,
  }) {
    // TODO: implement crearProducto
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductoEntity>> editarProducto({
    required String id,
    required String nombre,
    required String descripcion,
    required double precio,
    required String imagenUrl,
  }) {
    // TODO: implement editarProducto
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> eliminarProducto({required String id}) {
    // TODO: implement eliminarProducto
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductoEntity>> verProductoPorId({
    required String id,
  }) {
    // TODO: implement verProductoPorId
    throw UnimplementedError();
  }
}
