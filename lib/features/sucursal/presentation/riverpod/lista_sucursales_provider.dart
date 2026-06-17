import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/entity/sucursal_listada_entity.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/usecases/ver_lista_sucursales_usecase.dart';
import 'package:rollapp_negocio_clean/injection_container.dart' as di;

final listaSucursalesProvider =
    AsyncNotifierProvider.autoDispose<
      ListaSucursalesNotifier,
      List<SucursalListadaEntity>
    >(ListaSucursalesNotifier.new);

class ListaSucursalesNotifier
    extends AutoDisposeAsyncNotifier<List<SucursalListadaEntity>> {
  @override
  Future<List<SucursalListadaEntity>> build() async {
    return _cargar();
  }

  Future<List<SucursalListadaEntity>> _cargar() async {
    final result = await di.sl<VerListaSucursalesUseCase>()(NoParams());
    return result.fold((failure) => throw failure, (productos) => productos);
  }
}
