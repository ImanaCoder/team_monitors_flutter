import 'package:codeal/utils/http.dart';

class CustomerService {
  Future<void> addCustomer(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/customers";
      await dio.post(path, data: data);
    });
  }

  Future<List<dynamic>> getAllCustomersByCoSeller() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/customers";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getCustomersById(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/customers/$id";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getCustomerDetails(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/customers/$id/details";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateCustomer(int id, Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/customers/$id";
      await dio.put(path, data: data);
    });
  }
}
