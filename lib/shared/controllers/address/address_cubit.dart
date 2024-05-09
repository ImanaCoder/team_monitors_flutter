import 'package:codeal/core/service_locator.dart';
import 'package:codeal/shared/services/address_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());
  var addressService = sl<AddressService>();

  List<dynamic> provinces = [];
  dynamic selectedProvince;
  List<dynamic> districts = [];
  dynamic selectedDistrict;
  List<dynamic> palikas = [];
  dynamic selectedPalika;

  void getProvinces() async {
    emit(ProvinceLoading());
    try {
      provinces = await addressService.getProvinces();
      selectedProvince = provinces[0];
      emit(ProvinceListLoaded());
    } catch (e) {
      emit(AddressError(errorMsg: e.toString()));
    }
  }

  void changeProvince(dynamic province) {
    districts = [];
    palikas = [];
    selectedProvince = province;
    selectedDistrict = null;
    selectedPalika = null;
    emit(ProvinceChanged(province: province));
  }

  void getDistricts(int provinceCode) async {
    emit(DistrictLoading());
    try {
      districts = await addressService.getDistricts(provinceCode);
      selectedDistrict = districts[0];
      emit(DistrictListLoaded());
    } catch (e) {
      emit(AddressError(errorMsg: e.toString()));
    }
  }

  void changeDistrict(dynamic district) {
    palikas = [];
    selectedPalika = null;
    selectedDistrict = district;
    emit(DistrictChanged(district: district));
  }

  void getPalikas(int districtCode) async {
    emit(PalikaLoading());
    try {
      palikas = await addressService.getPalikas(districtCode);
      selectedPalika = palikas[0];
      emit(PalikaListLoaded());
    } catch (e) {
      emit(AddressError(errorMsg: e.toString()));
    }
  }

  void changePalika(dynamic palika) {
    selectedPalika = palika;
    emit(PalikaChanged(palika: palika));
  }
}
