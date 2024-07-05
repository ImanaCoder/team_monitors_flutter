import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/customer/customer_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());
  var customerService = sl<CustomerService>();

  void toggleCustomerType(String currentValue) {
    currentValue = currentValue == "1" ? "2" : "1";
    emit(CustomerTypeToggled(newValue: currentValue));
  }

  void addCustomer(Map<String, dynamic> data) async {
    emit(CustomerLoading());
    try {
      await customerService.addCustomer(data);
      emit(CustomerCreated());
    } catch (e) {
      emit(CustomerError(errorMsg: e.toString()));
    }
  }

  void getAllCustomersByCoSeller() async {
    emit(CustomerLoading());
    try {
      var data = await customerService.getAllCustomersByCoSeller();
      emit(CustomerListLoaded(customers: data));
    } catch (e) {
      emit(CustomerError(errorMsg: e.toString()));
    }
  }

  void getCustomerById(int id) async {
    emit(CustomerLoading());
    try {
      var data = await customerService.getCustomersById(id);
      emit(CustomerLoaded(customer: data));
    } catch (e) {
      emit(CustomerError(errorMsg: e.toString()));
    }
  }

  void getCustomerDetails(int id) async {
    emit(CustomerLoading());
    try {
      var data = await customerService.getCustomerDetails(id);
      emit(CustomerLoaded(customer: data));
    } catch (e) {
      emit(CustomerError(errorMsg: e.toString()));
    }
  }

  void updateCustomer(int id, Map<String, dynamic> data) async {
    emit(CustomerLoading());
    try {
      await customerService.updateCustomer(id, data);
      emit(CustomerUpdated());
    } catch (e) {
      emit(CustomerError(errorMsg: e.toString()));
    }
  }
}
