import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/unit/unit_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit() : super(UnitInitial());
  final unitService = sl<UnitService>();

  void getAllUnits() async {
    emit(UnitLoading());
    try {
      var data = await unitService.getAllUnits();
      emit(UnitListLoaded(units: data));
    } catch (e) {
      emit(UnitError(errorMsg: e.toString()));
    }
  }

  void getActiveUnits() async {
    emit(UnitLoading());
    try {
      var data = await unitService.getActiveUnits();
      emit(UnitListLoaded(units: data));
    } catch (e) {
      emit(UnitError(errorMsg: e.toString()));
    }
  }

  void getUnitById(int id) async {
    emit(UnitLoading());
    try {
      var data = await unitService.getUnitById(id);
      emit(UnitLoaded(unit: data));
    } catch (e) {
      emit(UnitError(errorMsg: e.toString()));
    }
  }

  void addNewUnit(dynamic data) async {
    emit(UnitLoading());
    try {
      await unitService.addUnit(data);
      emit(const UnitSuccess(successMsg: "New Unit Added"));
    } catch (e) {
      emit(UnitError(errorMsg: e.toString()));
    }
  }

  void updateUnit(int id, dynamic data) async {
    emit(UnitLoading());
    try {
      await unitService.updateUnit(id, data);
      emit(const UnitSuccess(successMsg: "Unit updated"));
    } catch (e) {
      emit(UnitError(errorMsg: e.toString()));
    }
  }
}
