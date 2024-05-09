import '../../utils/http.dart';

class AddressService {
  Future<List<dynamic>> getProvinces() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/federal/provinces";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<List<dynamic>> getDistricts(int provinceCode) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/federal/provinces/$provinceCode/districts";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<List<dynamic>> getPalikas(int districtCode) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/federal/districts/$districtCode/palikas";
      var response = await dio.get(path);
      return response.data;
    });
  }
}
