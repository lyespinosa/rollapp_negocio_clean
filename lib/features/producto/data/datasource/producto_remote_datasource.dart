import 'package:dio/dio.dart';
import 'package:rollapp_negocio_clean/core/error/exceptios.dart';
import 'package:rollapp_negocio_clean/features/producto/data/models/producto_listado_model.dart';
import 'package:rollapp_negocio_clean/features/producto/data/models/producto_model.dart';

abstract class ProductoRemoteDataSource {
  Future<ProductoModel> crearProducto(
    String nombre,
    String descripcion,
    double precio,
    String imagenUrl,
  );

  Future<ProductoModel> editarProducto(
    String id,
    String nombre,
    String descripcion,
    double precio,
    String imagenUrl,
  );

  Future<void> eliminarProducto(String id);

  Future<List<ProductoListadoModel>> verListaProductos();

  Future<ProductoModel> verProductoPorId(String id);
}

class ProductoRemoteDataSourceImpl implements ProductoRemoteDataSource {
  final Dio dio;

  ProductoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductoListadoModel>> verListaProductos() async {
    try {
      final response = await dio.get('/negocio/productos/todos');

      final List<dynamic> jsonList = response.data['data'];

      return jsonList
          .map(
            (json) =>
                ProductoListadoModel.fromJson(json as Map<String, dynamic>),
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

  @override
  Future<ProductoModel> crearProducto(
    String nombre,
    String descripcion,
    double precio,
    String imagenUrl,
  ) {
    // TODO: implement crearProducto
    throw UnimplementedError();
  }

  @override
  Future<ProductoModel> editarProducto(
    String id,
    String nombre,
    String descripcion,
    double precio,
    String imagenUrl,
  ) {
    // TODO: implement editarProducto
    throw UnimplementedError();
  }

  @override
  Future<void> eliminarProducto(String id) {
    // TODO: implement eliminarProducto
    throw UnimplementedError();
  }

  @override
  Future<ProductoModel> verProductoPorId(String id) {
    // TODO: implement verProductoPorId
    throw UnimplementedError();
  }
}
