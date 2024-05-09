import 'package:codeal/utils/http.dart';

class CompanyService {
  Future<void> addCompany(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/auth/register/company";
      await dio.post(path, data: data);
    });
  }

  Future<dynamic> getDashboardInfo() async {
    return handleAsync(() async {
      var path = "$baseUrl/api/companies/dashboard-info";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<List<dynamic>> getAllCompanies() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/companies";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<List<dynamic>> getCompaniesForCoseller() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/co-sellers/companies";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getMyCompanyProfile() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/companies/my-profile";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> updateCompany(Map<String, dynamic> data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/companies";
      await dio.put(path, data: data);
    });
  }
}
