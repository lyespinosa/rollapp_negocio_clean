import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/exceptios.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/features/sucursal/data/datasource/sucursal_remote_datasource.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/entity/sucursal_listada_entity.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/repository/sucursal_repository.dart';

class SucursalRepositoryImpl implements SucursalRepository {
  final SucursalRemoteDataSourceImpl remoteDataSource;

  SucursalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SucursalListadaEntity>>>
  verListaSucursales() async {
    try {
      final sucursales = await remoteDataSource.verListaSucursales();

      return Right(sucursales);
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
}
