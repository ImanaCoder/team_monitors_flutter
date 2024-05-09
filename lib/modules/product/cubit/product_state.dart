part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductListLoaded extends ProductState {
  final List<dynamic> products;
  const ProductListLoaded({required this.products});

  @override
  List<Object> get props => super.props..addAll([products]);
}

final class ProductLoaded extends ProductState {
  final dynamic product;
  const ProductLoaded({required this.product});

  @override
  List<Object> get props => super.props..addAll([product]);
}

final class CommissionRateLoaded extends ProductState {
  final dynamic commissionRate;
  const CommissionRateLoaded({required this.commissionRate});

  @override
  List<Object> get props => super.props..addAll([commissionRate]);
}

final class ProductSuccess extends ProductState {
  final String successMsg;
  const ProductSuccess({required this.successMsg});

  @override
  List<Object> get props => super.props..addAll([successMsg]);
}

final class ProductError extends ProductState {
  final String errorMsg;
  const ProductError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}
