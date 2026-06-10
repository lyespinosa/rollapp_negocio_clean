import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_listado_entity.dart';
import 'package:rollapp_negocio_clean/features/producto/presentation/riverpod/producto_notifier.dart';

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

          // Filtro de categorías
          _FiltrosCategorias(),

          // Lista
          Expanded(
            child: productosAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$error'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(productoProvider.notifier).recargar(),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
              data: (productos) {
                if (productos.isEmpty) {
                  return const Center(child: Text('No hay productos'));
                }
                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(productoProvider.notifier).recargar(),
                  child: ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return _ProductoItem(producto: producto);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Filtro de categorías — se alimenta de los datos ya cargados
class _FiltrosCategorias extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(productoProvider);
    final filtroActual = ref.watch(filtroCategoriaProvider);

    // Extrae categorías únicas de los productos ya cargados
    final categorias = productosAsync.maybeWhen(
      data: (productos) {
        final nombres = productos.map((p) => p.categoria).toSet().toList();
        return ['Todos', ...nombres];
      },
      orElse: () => ['Todos'],
    );

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categorias.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          final seleccionado = filtroActual == categoria;

          return ChoiceChip(
            label: Text(categoria),
            selected: seleccionado,
            onSelected: (_) {
              ref.read(filtroCategoriaProvider.notifier).state = categoria;
            },
          );
        },
      ),
    );
  }
}

// Item individual
class _ProductoItem extends StatelessWidget {
  final ProductoListadoEntity producto;

  const _ProductoItem({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 16,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.network(
                producto.imagen,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          producto.nombre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${producto.categoria} • ${producto.subcategoria}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'VISIBLE',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '\$${producto.precio}',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 224, 224),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_note_outlined),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
