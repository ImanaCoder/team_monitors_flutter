part of 'product_offer_cubit.dart';

sealed class ProductOfferState extends Equatable {
  const ProductOfferState();

  @override
  List<Object> get props => [];
}

final class ProductOfferInitial extends ProductOfferState {}

final class ProductOfferLoading extends ProductOfferState {}

final class CommissionRateLoaded extends ProductOfferState {
  final dynamic commissionRate;
  const CommissionRateLoaded({required this.commissionRate});

  @override
  List<Object> get props => super.props..addAll([commissionRate]);
}

final class CommissionRateUpdated extends ProductOfferState {}

final class ProductOfferSuccess extends ProductOfferState {
  final String successMsg;
  const ProductOfferSuccess({required this.successMsg});

  @override
  List<Object> get props => super.props..addAll([successMsg]);
}

final class ProductOfferListLoaded extends ProductOfferState {
  final List<dynamic> offers;
  const ProductOfferListLoaded({required this.offers});

  @override
  List<Object> get props => super.props..addAll([offers]);
}

final class ProductOfferLoaded extends ProductOfferState {
  final dynamic offer;
  const ProductOfferLoaded({required this.offer});

  @override
  List<Object> get props => super.props..addAll([offer]);
}

final class ProductOfferError extends ProductOfferState {
  final String errorMsg;
  const ProductOfferError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}

final class ProductAddedToOffer extends ProductOfferState {
  final dynamic product;
  const ProductAddedToOffer({required this.product});

  @override
  List<Object> get props => super.props..addAll([product]);
}

final class ProductRemovedFromOffer extends ProductOfferState {
  final dynamic product;
  const ProductRemovedFromOffer({required this.product});

  @override
  List<Object> get props => super.props..addAll([product]);
}

final class ProductOfferInfoRefreshed extends ProductOfferState {
  final DateTime datetime;
  const ProductOfferInfoRefreshed({required this.datetime});

  @override
  List<Object> get props => super.props..addAll([datetime]);
}
