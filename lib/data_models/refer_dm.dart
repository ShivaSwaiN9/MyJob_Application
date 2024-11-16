import 'dart:convert';

ReferralResponse referralResponseFromJson(String str) =>
    ReferralResponse.fromJson(json.decode(str));

String referralResponseToJson(ReferralResponse data) =>
    json.encode(data.toJson());

class ReferralResponse {
  ReferralResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<ReferDatum>? data;

  factory ReferralResponse.fromJson(Map<String, dynamic> json) =>
      ReferralResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<ReferDatum>.from(
            json["data"].map((x) => ReferDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReferDatum {
  ReferDatum({
    this.id,
    this.referralCount,
    this.email,
    this.phone,
    this.gender,
    this.dob,
    this.maritalStatus,
    this.name,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.referralCode,
  });

  String? id;
  int? referralCount;
  String? email;
  String? phone;
  int? gender;
  DateTime? dob;
  int? maritalStatus;
  String? name;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? referralCode;

  factory ReferDatum.fromJson(Map<String, dynamic> json) => ReferDatum(
        id: json["_id"] ?? '',
        referralCount: json["referralCount"] ?? 0,
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        gender: json["gender"] ?? 0,
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        maritalStatus: json["maritalStatus"] ?? 0,
        name: json["name"] ?? '',
        role: json["role"] ?? 0,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        referralCode: json["referralCode"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "referralCount": referralCount,
        "email": email,
        "phone": phone,
        "gender": gender,
        "dob": dob?.toIso8601String(),
        "maritalStatus": maritalStatus,
        "name": name,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "referralCode": referralCode,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReferDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
