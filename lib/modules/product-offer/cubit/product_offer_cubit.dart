import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/product-offer/models.dart';
import 'package:team_monitor/modules/product-offer/offer_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_offer_state.dart';

class ProductOfferCubit extends Cubit<ProductOfferState> {
  ProductOfferCubit() : super(ProductOfferInitial());
  var offerService = sl<OfferService>();

  void getAllOffersByCompany() async {
    emit(ProductOfferLoading());
    try {
      var data = await offerService.getAllOffersByCompany();
      emit(ProductOfferListLoaded(offers: data));
    } catch (e) {
      emit(ProductOfferError(errorMsg: e.toString()));
    }
  }

  void getCompanyOffersForPublic(int companyId) async {
    emit(ProductOfferLoading());
    try {
      var data = await offerService.getCompanyOffersForPublic(companyId);
      emit(ProductOfferListLoaded(offers: data));
    } catch (e) {
      emit(ProductOfferError(errorMsg: e.toString()));
    }
  }

  void getOfferById(int id) async {
    emit(ProductOfferLoading());
    try {
      var data = await offerService.getOfferById(id);
      emit(ProductOfferListLoaded(offers: data));
    } catch (e) {
      emit(ProductOfferError(errorMsg: e.toString()));
    }
  }

  void addNewOffer(dynamic data) async {
    emit(ProductOfferLoading());
    try {
      await offerService.addNewOffer(data);
      emit(const ProductOfferSuccess(successMsg: "New Offer Created"));
    } catch (e) {
      emit(ProductOfferError(errorMsg: e.toString()));
    }
  }

  void updateOffer(int id, dynamic data) async {
    emit(ProductOfferLoading());
    try {
      await offerService.updateOffer(id, data);
      emit(const ProductOfferSuccess(successMsg: "Offer Updated"));
    } catch (e) {
      emit(ProductOfferError(errorMsg: e.toString()));
    }
  }

  void getCommissionRate(int offerId) async {
    emit(ProductOfferLoading());
    try {
      var data = await offerService.getCommissionRate(offerId);
      emit(CommissionRateLoaded(commissionRate: data));
    } catch (e) {
      emit(ProductOfferError(errorMsg: e.toString()));
    }
  }

  void addCommissionRateToOffer(int offerId, dynamic commissionRateData) async {
    emit(ProductOfferLoading());
    try {
      await offerService.addCommissionRateToOffer(offerId, commissionRateData);
      emit(CommissionRateUpdated());
    } catch (e) {
      emit(ProductOfferError(errorMsg: e.toString()));
    }
  }

  void addProductToOffer(List<OfferProduct> orderProducts, dynamic product) {
    bool alreadyAdded = false;
    for (int i = 0; i < orderProducts.length; i++) {
      if (orderProducts[i].product['id'] == product['id']) {
        alreadyAdded = true;
        break;
      }
    }

    if (alreadyAdded) {
      emit(const ProductOfferError(errorMsg: "This product has already been added"));
    } else {
      emit(ProductAddedToOffer(product: product));
    }
  }

  void removeProductFromOffer(List<OfferProduct> orderProducts, OfferProduct product) {
    orderProducts.remove(product);
    emit(ProductRemovedFromOffer(product: product));
  }

  void refreshProductOfferInfo() {
    emit(ProductOfferInfoRefreshed(datetime: DateTime.now()));
  }
}
