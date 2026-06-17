import 'package:dio/dio.dart';
import 'package:rollapp_negocio_clean/core/error/exceptios.dart';
import 'package:rollapp_negocio_clean/features/sucursal/data/models/sucursal_listada_model.dart';

abstract class SucursalRemoteDataSource {
  Future<List<SucursalListadaModel>> verListaSucursales();
}

class SucursalRemoteDataSourceImpl implements SucursalRemoteDataSource {
  final Dio dio;

  SucursalRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<SucursalListadaModel>> verListaSucursales() async {
    try {
      final response = await dio.get('añadir url');

      final List<dynamic> jsonList = response.data['data'];

      return jsonList
          .map(
            (json) =>
                SucursalListadaModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Error de comunicación con el servidor',
      );
    } on FormatException catch (e) {
      throw JsonParsingException('Error al parsear JSON: ${e.message}');
    } on TypeError catch (e) {
      throw ModelMappingException(
        'Error al convertir JSON a ProductoListadoModel: $e',
      );
    } catch (e) {
      throw ServerException('Error inesperado: $e');
    }
  }
}
