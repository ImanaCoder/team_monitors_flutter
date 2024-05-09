class Address {
  int? id;
  int provinceCode = 0;
  int districtCode = 0;
  int palikaCode = 0;
  int ward = 0;
  String? city;
  String? streetAddress;

  Address({
    this.id,
    required this.provinceCode,
    required this.districtCode,
    required this.palikaCode,
    required this.ward,
    required this.city,
    required this.streetAddress,
  });

  Address.empty();

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      provinceCode: json['provinceCode'],
      districtCode: json['districtCode'],
      palikaCode: json['palikaCode'],
      ward: json['ward'],
      city: json['city'],
      streetAddress: json['streetAddress'],
    );
  }

  void fillDataFromJson(dynamic json) {
    id = json['id'];
    provinceCode = json['provinceCode'] ?? 0;
    districtCode = json['districtCode'] ?? 0;
    palikaCode = json['palikaCode'] ?? 0;
    ward = json['ward'] ?? 0;
    city = json['city'] ?? "";
    streetAddress = json['streetAddress'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ProvinceCode': provinceCode,
      'DistrictCode': districtCode,
      'PalikaCode': palikaCode,
      'Ward': ward,
      'City': city,
      'StreetAddress': streetAddress
    };
  }
}
