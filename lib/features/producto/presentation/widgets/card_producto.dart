import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/entity/producto_listado_entity.dart';

class CardProducto extends StatelessWidget {
  final ProductoListadoEntity producto;

  const CardProducto({super.key, required this.producto});

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
