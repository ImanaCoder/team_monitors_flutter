import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/product/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  final productService = sl<ProductService>();

  void getAllProductsByCompany() async {
    emit(ProductLoading());
    try {
      var data = await productService.getAllProductsByCompany();
      emit(ProductListLoaded(products: data));
    } catch (e) {
      emit(ProductError(errorMsg: e.toString()));
    }
  }

  void getCompanyProductsForPublic(int companyId) async {
    emit(ProductLoading());
    try {
      var data = await productService.getCompanyProductsForPublic(companyId);
      emit(ProductListLoaded(products: data));
    } catch (e) {
      emit(ProductError(errorMsg: e.toString()));
    }
  }

  void getProductById(int id) async {
    emit(ProductLoading());
    try {
      var data = await productService.getProductById(id);
      emit(ProductLoaded(product: data));
    } catch (e) {
      emit(ProductError(errorMsg: e.toString()));
    }
  }

  void addNewProduct(dynamic data) async {
    emit(ProductLoading());
    try {
      await productService.addNewProduct(data);
      emit(const ProductSuccess(successMsg: "New Product Added"));
    } catch (e) {
      emit(ProductError(errorMsg: e.toString()));
    }
  }

  void updateProduct(int id, dynamic data) async {
    emit(ProductLoading());
    try {
      await productService.updateProduct(id, data);
      emit(const ProductSuccess(successMsg: "Product Updated"));
    } catch (e) {
      emit(ProductError(errorMsg: e.toString()));
    }
  }

  void getCommissionRate(int productId) async {
    emit(ProductLoading());
    try {
      var data = await productService.getCommissionRate(productId);
      emit(CommissionRateLoaded(commissionRate: data));
    } catch (e) {
      emit(ProductError(errorMsg: e.toString()));
    }
  }

  void addCommissionRateToProduct(int productId, dynamic commissionRateData) async {
    emit(ProductLoading());
    try {
      await productService.addCommissionRateToProduct(productId, commissionRateData);
      emit(const ProductSuccess(successMsg: "Commission Rate Updated"));
    } catch (e) {
      emit(ProductError(errorMsg: e.toString()));
    }
  }
}
