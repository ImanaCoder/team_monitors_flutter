import 'package:team_monitor/utils/http.dart';

class UnitService {
  Future<List<dynamic>> getAllUnits() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/units";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<List<dynamic>> getActiveUnits() async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/units/active";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<dynamic> getUnitById(int id) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/units/$id";
      var response = await dio.get(path);
      return response.data;
    });
  }

  Future<void> addUnit(dynamic data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/units";
      await dio.post(path, data: data);
    });
  }

  Future<void> updateUnit(int unitId, dynamic data) async {
    return await handleAsync(() async {
      var path = "$baseUrl/api/units/$unitId";
      await dio.put(path, data: data);
    });
  }
}
