import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncList<T> extends ConsumerWidget {
  final AsyncValue<List<T>> asyncValue;
  final Widget Function(T item, int index) body;
  final VoidCallback onErrorRetry;
  final Future<void> Function() onRefresh;

  const AsyncList({
    super.key,
    required this.asyncValue,
    required this.body,
    required this.onErrorRetry,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error', textAlign: TextAlign.center),

              ...[
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: onErrorRetry,
                  child: const Text('Reintentar'),
                ),
              ],
            ],
          ),
        );
      },
      data: (items) {
        return RefreshIndicator(
          onRefresh: onRefresh!,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => body(items[index], index),
          ),
        );
      },
    );
  }
}
