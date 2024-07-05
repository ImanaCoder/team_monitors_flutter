import 'package:team_monitor/utils/http.dart';

class ProductService {
  Future<List<dynamic>> getAllProductsByCompany() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/products";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<List<dynamic>> getCompanyProductsForPublic(int companyId) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/products/list?companyId=$companyId";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> addNewProduct(dynamic data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/products";
      await dio.post(path, data: data);
    });
  }

  Future<dynamic> getProductById(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/products/$id";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateProduct(int id, dynamic data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/products/$id";
      await dio.put(path, data: data);
    });
  }

  Future<dynamic> getCommissionRate(int productId) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/products/$productId/commission-rate";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> addCommissionRateToProduct(int productId, dynamic commissionRateData) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/products/$productId/commission-rate/update";
      await dio.post(path, data: commissionRateData);
    });
  }
}
