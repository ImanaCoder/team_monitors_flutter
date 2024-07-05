import 'package:team_monitor/utils/http.dart';

class CosellerService {
  Future<List<dynamic>> getCosellersForCompany() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/companies/cosellers";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getCosellerProfile() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/my-profile";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getDashboardInfo() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/dashboard-info";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getCosellerDetails(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/$id/details";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getCommissionDetails() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/commission-details";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateCoseller(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers";
      await dio.put(path, data: data);
    });
  }

  // ================ BANK DETAILS ===============
  Future<List<dynamic>> getAllBankDetailsForCoseller() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/bank-details";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> addBankDetails(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/bank-details";
      await dio.post(path, data: data);
    });
  }

  Future<dynamic> getBankDetailsById(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/bank-details/$id";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateBankDetails(Map<String, dynamic> data, int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/bank-details/$id";
      await dio.put(path, data: data);
    });
  }

  Future<void> deleteBankDetails(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/bank-details/$id";
      await dio.delete(path);
    });
  }

  // =============== DIGITAL WALLET =====================
  Future<List<dynamic>> getAllDigitalWalletsForCoseller() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/digital-wallets";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> addDigitalWallet(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/digital-wallets";
      await dio.post(path, data: data);
    });
  }

  Future<dynamic> getDigitalWalletById(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/digital-wallets/$id";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateDigitalWallet(Map<String, dynamic> data, int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/digital-wallets/$id";
      await dio.put(path, data: data);
    });
  }

  Future<void> deleteDigitalWallet(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/digital-wallets/$id";
      await dio.delete(path);
    });
  }
}
