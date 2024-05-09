part of 'unit_cubit.dart';

sealed class UnitState extends Equatable {
  const UnitState();

  @override
  List<Object> get props => [];
}

final class UnitInitial extends UnitState {}

final class UnitLoading extends UnitState {}

final class UnitListLoaded extends UnitState {
  final List<dynamic> units;
  const UnitListLoaded({required this.units});

  @override
  List<Object> get props => super.props..addAll([units]);
}

final class UnitLoaded extends UnitState {
  final dynamic unit;
  const UnitLoaded({required this.unit});

  @override
  List<Object> get props => super.props..addAll([unit]);
}

final class UnitSuccess extends UnitState {
  final String successMsg;
  const UnitSuccess({required this.successMsg});

  @override
  List<Object> get props => super.props..addAll([successMsg]);
}

final class UnitError extends UnitState {
  final String errorMsg;
  const UnitError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}
