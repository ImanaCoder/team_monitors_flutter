class Offer {
  String? name, description, fromDate, toDate;
  List<OfferProduct> offerProducts = [];
  num discountPercent = 0;
  num discountFlat = 0;
  String discountType = "Percent";
  num packageCount = 0;

  // num get subTotal {
  //   num sum = 0;
  //   for (var op in orderProducts) {
  //     sum += op.product['mrp'] * op.quantity;
  //   }
  //   return sum;
  // }

  // num get totalDiscount {
  //   return (discountPercent / 100 * subTotal) + discountFlat;
  // }

  // num get grandTotal {
  //   return subTotal - totalDiscount + deliveryCharge;
  // }

  void switchDiscountType() {
    discountType = discountType == "Percent" ? "Flat" : "Percent";
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "fromDate": fromDate,
      "toDate": toDate,
      "percentDiscount": discountPercent,
      "flatDiscount": discountFlat,
      "packageCount": packageCount,
      "status": 1,
      "offerProducts": offerProducts
          .map((op) => {"productId": op.product['id'], "productQuantity": op.quantity, "type": op.type})
          .toList(),
    };
  }
}

class OfferProduct {
  dynamic product;
  int quantity = 1;
  String type = "Main";
  OfferProduct({required this.product});

  void switchProductType() {
    type = type == "Main" ? "Surplus" : "Main";
  }
}
