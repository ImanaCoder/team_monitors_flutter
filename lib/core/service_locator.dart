import 'package:codeal/core/token_info.dart';
import 'package:codeal/modules/co-seller/coseller_service.dart';
import 'package:codeal/modules/company/company_service.dart';
import 'package:codeal/modules/customer/customer_service.dart';
import 'package:codeal/modules/product-offer/offer_service.dart';
import 'package:codeal/modules/product/product_service.dart';
import 'package:codeal/modules/sales-order/sales_order_service.dart';
import 'package:codeal/modules/unit/unit_service.dart';
import 'package:codeal/modules/user/service/user_service.dart';
import 'package:codeal/shared/services/address_service.dart';
import 'package:codeal/shared/services/sms_service.dart';
import 'package:codeal/shared/services/validation_service.dart';
import 'package:codeal/utils/constants.dart';
import 'package:codeal/utils/display_toast.dart';
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
