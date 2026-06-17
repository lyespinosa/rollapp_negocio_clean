import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/core/widgets/async/async_list.dart';
import 'package:rollapp_negocio_clean/features/producto/presentation/riverpod/producto_notifier.dart';
import 'package:rollapp_negocio_clean/features/producto/presentation/widgets/card_producto.dart';
import 'package:rollapp_negocio_clean/features/producto/presentation/widgets/lista_filtros.dart';

class ListaProductosScreen extends ConsumerWidget {
  const ListaProductosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(productosFiltradosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // navegar a form crear
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar producto...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(busquedaProductoProvider.notifier).state = value;
              },
            ),
          ),

          ListaFiltros(),

          Expanded(
            child: AsyncList(
              asyncValue: productosAsync,
              body: (item, index) => CardProducto(producto: item),
              onErrorRetry: () =>
                  ref.read(productoProvider.notifier).recargar(),
              onRefresh: ref.read(productoProvider.notifier).recargar,
            ),
          ),

          // Lista
        ],
      ),
    );
  }
}
