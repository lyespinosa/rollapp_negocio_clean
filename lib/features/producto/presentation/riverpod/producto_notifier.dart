import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_listado_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/usecases/ver_lista_productos_usecase.dart';
import 'package:rollapp_negocio_clean/injection_container.dart' as di;

final productoProvider =
    AsyncNotifierProvider.autoDispose<
      ProductoNotifier,
      List<ProductoListadoEntity>
    >(ProductoNotifier.new);

class ProductoNotifier
    extends AutoDisposeAsyncNotifier<List<ProductoListadoEntity>> {
  @override
  Future<List<ProductoListadoEntity>> build() async {
    return _cargar();
  }

  Future<List<ProductoListadoEntity>> _cargar() async {
    final result = await di.sl<VerListaProductosUseCase>()(NoParams());
    return result.fold((failure) => throw failure, (productos) => productos);
  }

  Future<void> recargar() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_cargar);
  }

  Future<void> refresh() async {}
}

final filtroCategoriaProvider = StateProvider.autoDispose<String>(
  (ref) => 'Todos',
);

final busquedaProductoProvider = StateProvider.autoDispose<String>((ref) => '');

final productosFiltradosProvider =
    Provider.autoDispose<AsyncValue<List<ProductoListadoEntity>>>((ref) {
      final productosAsync = ref.watch(productoProvider);
      final filtro = ref.watch(filtroCategoriaProvider);
      final busqueda = ref.watch(busquedaProductoProvider);

      return productosAsync.whenData((productos) {
        return productos.where((p) {
          final coincideCategoria = filtro == 'Todos' || p.categoria == filtro;

          final coincideBusqueda =
              busqueda.isEmpty ||
              p.nombre.toLowerCase().contains(busqueda.toLowerCase());
          return coincideCategoria && coincideBusqueda;
        }).toList();
      });
    });
