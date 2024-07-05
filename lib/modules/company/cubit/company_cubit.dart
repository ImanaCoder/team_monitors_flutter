import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/company/company_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitial());
  var companyService = sl<CompanyService>();

  void addCompany(Map<String, dynamic> data) async {
    emit(CompanyLoading());
    try {
      await companyService.addCompany(data);
      emit(const CompanySuccess(successMsg: "New Company Registered"));
    } catch (e) {
      emit(CompanyError(errorMsg: e.toString()));
    }
  }

  void getDashboardInfo() async {
    emit(CompanyLoading());
    try {
      var data = await companyService.getDashboardInfo();
      emit(CompanyDashboardInfoLoaded(info: data));
    } catch (e) {
      emit(CompanyError(errorMsg: e.toString()));
    }
  }

  void getAllCompanies() async {
    emit(CompanyLoading());
    try {
      var data = await companyService.getAllCompanies();
      emit(CompanyListLoaded(companies: data));
    } catch (e) {
      emit(CompanyError(errorMsg: e.toString()));
    }
  }

  void getCompaniesForCoseller() async {
    emit(CompanyLoading());
    try {
      var data = await companyService.getCompaniesForCoseller();
      emit(CompanyListLoaded(companies: data));
    } catch (e) {
      emit(CompanyError(errorMsg: e.toString()));
    }
  }

  void getCompanyProfile() async {
    emit(CompanyProfileLoading());
    try {
      var data = await companyService.getMyCompanyProfile();
      emit(CompanyProfileLoaded(company: data));
    } catch (e) {
      emit(CompanyError(errorMsg: e.toString()));
    }
  }

  void updateCompany(Map<String, dynamic> data) async {
    emit(CompanyLoading());
    try {
      await companyService.updateCompany(data);
      emit(const CompanySuccess(successMsg: "Company Profile Updated"));
    } catch (e) {
      emit(CompanyError(errorMsg: e.toString()));
    }
  }
}
