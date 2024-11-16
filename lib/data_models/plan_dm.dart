///
/// Created by Sisira Sahoo
/// On 09/05/22 2:10 PM
///

import 'dart:convert';

PlanResponse planResponseFromJson(String str) =>
    PlanResponse.fromJson(json.decode(str));

String planResponseToJson(PlanResponse data) => json.encode(data.toJson());

class PlanResponse {
  PlanResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<PlanDatum>? data;

  factory PlanResponse.fromJson(Map<String, dynamic> json) => PlanResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<PlanDatum>.from(
            json["data"].map((x) => PlanDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PlanDatum {
  PlanDatum({
    this.id,
    this.points,
    this.status,
    this.name,
    this.description,
    this.price,
    this.basePrice,
    this.monthCount,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.razorpayPlanId,
  });

  String? id;
  List<String>? points;
  int? status;
  String? name;
  String? description;
  double? price;
  double? basePrice;
  int? monthCount;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? razorpayPlanId;

  factory PlanDatum.fromJson(Map<String, dynamic> json) => PlanDatum(
        id: json["_id"] ?? '',
        points: json["points"] == null
            ? null
            : List<String>.from(json["points"].map((x) => x)),
        status: json["status"] ?? 0,
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        price: (json["price"] ?? 0).toDouble(),
        basePrice: (json["basePrice"] ?? 0).toDouble(),
        monthCount: json["monthCount"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        razorpayPlanId: json["razorpayPlanId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "points": List<dynamic>.from(points!.map((x) => x)),
        "status": status,
        "name": name,
        "description": description,
        "price": price,
        "basePrice": basePrice,
        "monthCount": monthCount,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "razorpayPlanId": razorpayPlanId,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
