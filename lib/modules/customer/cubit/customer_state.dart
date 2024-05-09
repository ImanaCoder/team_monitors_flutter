part of 'customer_cubit.dart';

sealed class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

final class CustomerInitial extends CustomerState {}

final class CustomerLoading extends CustomerState {}

final class CustomerCreated extends CustomerState {}

final class CustomerUpdated extends CustomerState {}

final class CustomerTypeToggled extends CustomerState {
  final String newValue;
  const CustomerTypeToggled({required this.newValue});

  @override
  List<Object> get props => super.props..addAll([newValue]);
}

final class CustomerListLoaded extends CustomerState {
  final List<dynamic> customers;
  const CustomerListLoaded({required this.customers});

  @override
  List<Object> get props => super.props..addAll([customers]);
}

final class CustomerLoaded extends CustomerState {
  final dynamic customer;
  const CustomerLoaded({required this.customer});

  @override
  List<Object> get props => super.props..addAll([customer]);
}

final class CustomerError extends CustomerState {
  final String errorMsg;
  const CustomerError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}
