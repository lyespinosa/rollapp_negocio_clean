import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/features/producto/presentation/riverpod/producto_notifier.dart';

class ListaFiltros extends ConsumerWidget {
  const ListaFiltros({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(productoProvider);
    final filtroActual = ref.watch(filtroCategoriaProvider);

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
