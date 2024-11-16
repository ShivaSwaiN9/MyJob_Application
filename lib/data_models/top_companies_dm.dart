import 'dart:convert';

import 'package:my_job_flutter/data_models/user.dart';

TopCompaniesResponse topCompaniesResponseFromJson(String str) =>
    TopCompaniesResponse.fromJson(json.decode(str));

String topCompaniesResponseToJson(TopCompaniesResponse data) =>
    json.encode(data.toJson());

class TopCompaniesResponse {
  TopCompaniesResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<TopCompaniesDatum>? data;

  factory TopCompaniesResponse.fromJson(Map<String, dynamic> json) =>
      TopCompaniesResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: json["data"] == null
            ? null
            : List<TopCompaniesDatum>.from(
                json["data"].map((x) => TopCompaniesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TopCompaniesDatum {
  TopCompaniesDatum({
    this.id,
    this.referralCount,
    this.email,
    this.phone,
    this.role,
    this.gender,
    this.dob,
    this.maritalStatus,
    this.name,
    this.referredBy,
    this.createdAt,
    this.updatedAt,
    this.referralCode,
    this.status,
    this.companyName,
    this.document,
    this.avatar,
  });

  String? id;
  int? referralCount;
  String? email;
  String? phone;
  int? role;
  int? gender;
  DateTime? dob;
  int? maritalStatus;
  String? name;
  String? referredBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? referralCode;
  int? status;
  String? companyName;
  Document? document;
  String? avatar;

  factory TopCompaniesDatum.fromJson(Map<String, dynamic> json) =>
      TopCompaniesDatum(
        id: json["_id"] ?? '',
        referralCount: json["referralCount"] ?? 0,
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        role: json["role"] ?? 0,
        gender: json["gender"] ?? 0,
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        maritalStatus: json["maritalStatus"] ?? 0,
        name: json["name"],
        referredBy: json["referredBy"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        referralCode: json["referralCode"] ?? '',
        status: json["status"] ?? 0,
        companyName: json["companyName"] ?? '',
        document: json["document"] == null
            ? null
            : Document.fromJson(json["document"]),
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "referralCount": referralCount,
        "email": email,
        "phone": phone,
        "role": role,
        "gender": gender,
        "dob": dob?.toIso8601String(),
        "maritalStatus": maritalStatus,
        "name": name,
        "referredBy": referredBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "referralCode": referralCode,
        "status": status,
        "companyName": companyName,
        "document": document?.toJson(),
        "avatar": avatar,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopCompaniesDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
