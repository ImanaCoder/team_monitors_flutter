import 'package:team_monitor/utils/http.dart';

class SalesOrderService {
  Future<List<dynamic>> getAllSalesOrders(int limit) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/orders?limit=$limit";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> addNewSalesOrder(dynamic data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/orders";
      await dio.post(path, data: data);
    });
  }

  Future<dynamic> getOrderDetails(int orderId, String orderType) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/orders/details?id=$orderId&orderType=$orderType";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getSalesOrderById(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/orders/$id";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateSalesOrder(int id, dynamic data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/orders/$id";
      await dio.put(path, data: data);
    });
  }

  Future<void> markOrderAsComplete(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/orders/$id/complete";
      await dio.get(path);
    });
  }
}
