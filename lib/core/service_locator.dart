import 'package:team_monitor/core/token_info.dart';
import 'package:team_monitor/modules/co-seller/coseller_service.dart';
import 'package:team_monitor/modules/company/company_service.dart';
import 'package:team_monitor/modules/customer/customer_service.dart';
import 'package:team_monitor/modules/product-offer/offer_service.dart';
import 'package:team_monitor/modules/product/product_service.dart';
import 'package:team_monitor/modules/sales-order/sales_order_service.dart';
import 'package:team_monitor/modules/unit/unit_service.dart';
import 'package:team_monitor/modules/user/service/user_service.dart';
import 'package:team_monitor/shared/services/address_service.dart';
import 'package:team_monitor/shared/services/sms_service.dart';
import 'package:team_monitor/shared/services/validation_service.dart';
import 'package:team_monitor/utils/constants.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:get_it/get_it.dart';

import 'navigation_service.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // core services
  sl.registerSingleton(NavigationService());
  sl.registerSingleton(TokenInfo());
  sl.registerSingleton(AppConstants());
  sl.registerLazySingleton(() => AppToast());
  sl.registerLazySingleton(() => MyFormValidator());
  sl.registerLazySingleton(() => SmsService());

  // api services
  sl.registerLazySingleton(() => AddressService());
  sl.registerLazySingleton(() => UserService());
  sl.registerLazySingleton(() => CompanyService());
  sl.registerLazySingleton(() => CustomerService());
  sl.registerLazySingleton(() => CosellerService());
  sl.registerLazySingleton(() => OfferService());
  sl.registerLazySingleton(() => SalesOrderService());
  sl.registerLazySingleton(() => UnitService());
  sl.registerLazySingleton(() => ProductService());
}
