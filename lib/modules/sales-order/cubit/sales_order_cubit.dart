import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/sales-order/sales_order_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models.dart';

part 'sales_order_state.dart';

class SalesOrderCubit extends Cubit<SalesOrderState> {
  SalesOrderCubit() : super(SalesOrderInitial());
  var salesOrderService = sl<SalesOrderService>();

  void getAllSalesOrders({int limit = 0}) async {
    emit(SalesOrderLoading());
    try {
      var data = await salesOrderService.getAllSalesOrders(limit);
      emit(SalesOrderListLoaded(salesOrders: data));
    } catch (e) {
      emit(SalesOrderError(errorMsg: e.toString()));
    }
  }

  void getOrderDetails(int orderId, String orderType) async {
    emit(SalesOrderLoading());
    try {
      var data = await salesOrderService.getOrderDetails(orderId, orderType);
      emit(SalesOrderLoaded(salesOrder: data));
    } catch (e) {
      emit(SalesOrderError(errorMsg: e.toString()));
    }
  }

  void getSalesOrderById(int id) async {
    emit(SalesOrderLoading());
    try {
      var data = await salesOrderService.getSalesOrderById(id);
      emit(SalesOrderLoaded(salesOrder: data));
    } catch (e) {
      emit(SalesOrderError(errorMsg: e.toString()));
    }
  }

  void addNewSalesOrder(dynamic data) async {
    emit(SalesOrderLoading());
    try {
      await salesOrderService.addNewSalesOrder(data);
      emit(const SalesOrderSuccess(successMsg: "Sales Order Created"));
    } catch (e) {
      emit(SalesOrderError(errorMsg: e.toString()));
    }
  }

  void updateSalesOrder(int id, dynamic data) async {
    emit(SalesOrderLoading());
    try {
      await salesOrderService.updateSalesOrder(id, data);
      emit(const SalesOrderSuccess(successMsg: "Sales Order updated"));
    } catch (e) {
      emit(SalesOrderError(errorMsg: e.toString()));
    }
  }

  void markOrderAsComplete(int id) async {
    emit(SalesOrderLoading());
    try {
      await salesOrderService.markOrderAsComplete(id);
      emit(const SalesOrderSuccess(successMsg: "Successfully marked as complete"));
    } catch (e) {
      emit(SalesOrderError(errorMsg: e.toString()));
    }
  }

  void addProductToOrder(List<OrderProduct> orderProducts, dynamic product) {
    bool alreadyAdded = false;
    for (int i = 0; i < orderProducts.length; i++) {
      if (orderProducts[i].product['id'] == product['id']) {
        alreadyAdded = true;
        break;
      }
    }

    if (alreadyAdded) {
      emit(const SalesOrderError(errorMsg: "This product has already been added"));
    } else {
      emit(ProductAddedToOrder(product: product));
    }
  }

  void removeProductFromOrder(List<OrderProduct> orderProducts, OrderProduct product) {
    orderProducts.remove(product);
    emit(ProductRemovedFromOrder(product: product));
  }

  void addOfferToOrder(Order order, dynamic offer) {
    order.offer = offer;
    order.offerId = offer['id'];
    emit(const SalesOrderSuccess(successMsg: "Offer has been added"));
  }

  void refreshSalesOrderInfo() {
    emit(SalesOrderInfoRefreshed(dateTime: DateTime.now()));
  }
}
