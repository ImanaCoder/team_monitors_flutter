import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/co-seller/coseller_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'coseller_state.dart';

class CosellerCubit extends Cubit<CosellerState> {
  CosellerCubit() : super(CosellerInitial());
  var cosellerService = sl<CosellerService>();

  void getCosellersForCompany() async {
    emit(CosellerLoading());
    try {
      var data = await cosellerService.getCosellersForCompany();
      emit(CosellerListLoaded(cosellers: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void getCosellerDetails(int id) async {
    emit(CosellerProfileLoading());
    try {
      var data = await cosellerService.getCosellerDetails(id);
      emit(CosellerProfileLoaded(coseller: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void getDashboardInfo() async {
    emit(CosellerProfileLoading());
    try {
      var data = await cosellerService.getDashboardInfo();
      emit(CosellerProfileLoaded(coseller: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void getCommissionInfo() async {
    emit(CosellerProfileLoading());
    try {
      var data = await cosellerService.getCommissionDetails();
      emit(CosellerProfileLoaded(coseller: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void getCosellerProfile() async {
    emit(CosellerProfileLoading());
    try {
      var data = await cosellerService.getCosellerProfile();
      emit(CosellerProfileLoaded(coseller: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void updateCoseller(Map<String, dynamic> data) async {
    emit(CosellerLoading());
    try {
      await cosellerService.updateCoseller(data);
      emit(const CosellerSuccess(successMsg: "Profile update successful"));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  // ============ BANK DETAILS =======================

  void getAllBankDetailsForCoseller() async {
    emit(CosellerLoading());
    try {
      var data = await cosellerService.getAllBankDetailsForCoseller();
      emit(BankDetailsListLoaded(bankDetails: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void addBankDetails(Map<String, dynamic> data) async {
    emit(CosellerLoading());
    try {
      await cosellerService.addBankDetails(data);
      emit(const CosellerSuccess(successMsg: "New Bank Details Added"));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void getBankDetails(int id) async {
    emit(CosellerLoading());
    try {
      var data = await cosellerService.getBankDetailsById(id);
      emit(BankDetailsLoaded(bankDetails: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void updateBankDetails(Map<String, dynamic> data, int id) async {
    emit(CosellerLoading());
    try {
      await cosellerService.updateBankDetails(data, id);
      emit(const CosellerSuccess(successMsg: "Bank Details Updated"));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void deleteBankDetails(int id) async {
    emit(CosellerLoading());
    try {
      await cosellerService.deleteBankDetails(id);
      emit(const CosellerSuccess(successMsg: "Bank Details Removed"));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  // ============ DIGITAL WALLETS =======================

  void getAllDigitalWalletsForCoseller() async {
    emit(CosellerLoading());
    try {
      var data = await cosellerService.getAllDigitalWalletsForCoseller();
      emit(DigitalWalletListLoaded(digitalWallets: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void addDigitalWallet(Map<String, dynamic> data) async {
    emit(CosellerLoading());
    try {
      await cosellerService.addDigitalWallet(data);
      emit(const CosellerSuccess(successMsg: "New Digital Wallet Added"));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void getDigitalWallet(int id) async {
    emit(CosellerLoading());
    try {
      var data = await cosellerService.getDigitalWalletById(id);
      emit(DigitalWalletLoaded(digitalWallet: data));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void updateDigitalWallet(Map<String, dynamic> data, int id) async {
    emit(CosellerLoading());
    try {
      await cosellerService.updateDigitalWallet(data, id);
      emit(const CosellerSuccess(successMsg: "Digital Wallet Updated"));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }

  void deleteDigitalWallet(int id) async {
    emit(CosellerLoading());
    try {
      await cosellerService.deleteBankDetails(id);
      emit(const CosellerSuccess(successMsg: "Digital Wallet Removed"));
    } catch (e) {
      emit(CosellerError(errorMsg: e.toString()));
    }
  }
}
