class CommissionRate {
  num cosellerRate = 0;
  int status = 1;

  Map<String, dynamic> toJson() {
    return {
      'coSellerRate': cosellerRate,
      'status': status,
    };
  }
}
