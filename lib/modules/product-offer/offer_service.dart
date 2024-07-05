import 'package:team_monitor/utils/http.dart';

class OfferService {
  Future<List<dynamic>> getAllOffersByCompany() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/offers";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<List<dynamic>> getCompanyOffersForPublic(int companyId) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/offers/list?companyId=$companyId";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> addNewOffer(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/offers";
      await dio.post(path, data: data);
    });
  }

  Future<dynamic> getOfferById(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/offers/$id";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateOffer(int id, dynamic data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/offers/$id";
      await dio.put(path, data: data);
    });
  }

  Future<void> addCommissionRateToOffer(int offerId, dynamic commissionRateData) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/offers/$offerId/commission-rate/update";
      await dio.post(path, data: commissionRateData);
    });
  }

  Future<dynamic> getCommissionRate(int offerId) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/offers/$offerId/commission-rate";
      var response = await dio.get(path);
      return response.data;
    });
  }
}
