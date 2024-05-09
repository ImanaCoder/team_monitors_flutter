class Order {
  int? companyId;
  int? customerId;
  int? offerId;
  dynamic offer;
  String? type;
  List<OrderProduct> orderProducts = [];
  num discountPercent = 0;
  num discountFlat = 0;
  String discountType = "Percent";
  num deliveryCharge = 0;

  num get subTotal {
    num sum = 0;
    for (var op in orderProducts) {
      sum += op.product['mrp'] * op.quantity;
    }
    return sum;
  }

  num get subTotalForOffer {
    return offer != null ? offer['amount'] : 0;
  }

  num get totalDiscount {
    return (discountPercent / 100 * subTotal) + discountFlat;
  }

  num get grandTotal {
    return subTotal - totalDiscount + deliveryCharge;
  }

  num get grandTotalForOffer {
    return subTotalForOffer + deliveryCharge;
  }

  void switchDiscountType() {
    discountType = discountType == "Percent" ? "Flat" : "Percent";
  }

  void changeOrderType(String val) {
    type = val;
    if (val == "Offer") {
      orderProducts.clear();
    } else {
      offerId = null;
      offer = null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "companyId": companyId,
      "customerId": customerId,
      "type": type,
      "offerId": offerId,
      "subTotalAmount": type == "Product" ? subTotal : subTotalForOffer,
      "percentDiscount": discountPercent,
      "flatDiscount": discountFlat,
      "totalDiscountAmount": totalDiscount,
      "deliveryCharge": deliveryCharge,
      "totalAmount": type == "Product" ? grandTotal : grandTotalForOffer,
      "status": 1,
      "orderProducts": orderProducts.isEmpty
          ? null
          : orderProducts
              .map((op) => {
                    "productId": op.product['id'],
                    "productQuantity": op.quantity,
                  })
              .toList(),
    };
  }
}

class OrderProduct {
  dynamic product;
  int quantity = 1;
  OrderProduct({required this.product});
}
