import 'dart:convert';

CouponResponse couponResponseFromJson(String str) =>
    CouponResponse.fromJson(json.decode(str));

String couponResponseToJson(CouponResponse data) => json.encode(data.toJson());

class CouponResponse {
  CouponResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<CouponDatum>? data;

  factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<CouponDatum>.from(
            json["data"].map((x) => CouponDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CouponDatum {
  CouponDatum({
    required this.id,
    this.code,
    this.title,
    this.role,
    this.type,
    this.discount,
    this.minPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String? code;
  String? title;
  int? role;

  ///1 : Percentage
  ///2 : Amount
  int? type;
  double? discount;
  double? minPrice;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CouponDatum.fromJson(Map<String, dynamic> json) => CouponDatum(
        id: json["_id"] ?? '',
        code: json["code"] ?? '',
        title: json["title"] ?? '',
        role: json["role"] ?? 0,
        type: json["type"] ?? 0,
        discount: (json["discount"] ?? 0).toDouble(),
        minPrice: (json["minPrice"] ?? 0).toDouble(),
        status: json["status"] ?? 0,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "title": title,
        "role": role,
        "type": type,
        "discount": discount,
        "minPrice": minPrice,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
