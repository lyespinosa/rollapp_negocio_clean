import 'package:equatable/equatable.dart';

class SucursalListadaEntity extends Equatable {
  final int id;
  final String calle;

  const SucursalListadaEntity({required this.id, required this.calle});

  @override
  List<Object?> get props => [id, calle];
}
