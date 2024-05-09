part of 'sales_order_cubit.dart';

sealed class SalesOrderState extends Equatable {
  const SalesOrderState();

  @override
  List<Object> get props => [];
}

final class SalesOrderInitial extends SalesOrderState {}

final class SalesOrderLoading extends SalesOrderState {}

final class SalesOrderListLoaded extends SalesOrderState {
  final List<dynamic> salesOrders;
  const SalesOrderListLoaded({required this.salesOrders});

  @override
  List<Object> get props => super.props..addAll([salesOrders]);
}

final class SalesOrderLoaded extends SalesOrderState {
  final dynamic salesOrder;
  const SalesOrderLoaded({required this.salesOrder});

  @override
  List<Object> get props => super.props..addAll([salesOrder]);
}

final class SalesOrderSuccess extends SalesOrderState {
  final String successMsg;
  const SalesOrderSuccess({required this.successMsg});

  @override
  List<Object> get props => super.props..addAll([successMsg]);
}

final class SalesOrderError extends SalesOrderState {
  final String errorMsg;
  const SalesOrderError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}

final class ProductAddedToOrder extends SalesOrderState {
  final dynamic product;
  const ProductAddedToOrder({required this.product});

  @override
  List<Object> get props => super.props..addAll([product]);
}

final class ProductRemovedFromOrder extends SalesOrderState {
  final dynamic product;
  const ProductRemovedFromOrder({required this.product});

  @override
  List<Object> get props => super.props..addAll([product]);
}

final class SalesOrderInfoRefreshed extends SalesOrderState {
  final DateTime dateTime;
  const SalesOrderInfoRefreshed({required this.dateTime});

  @override
  List<Object> get props => super.props..addAll([dateTime]);
}
