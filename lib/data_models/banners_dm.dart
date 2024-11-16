import 'dart:convert';

List<BannersDatum> bannersDatumFromJson(String str) => List<BannersDatum>.from(
    json.decode(str).map((x) => BannersDatum.fromJson(x)));

String bannersDatumToJson(List<BannersDatum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannersDatum {
  BannersDatum({
    this.id,
    this.image,
    this.entityType,
    this.entityId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? image;
  int? entityType;
  String? entityId;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BannersDatum.fromJson(Map<String, dynamic> json) => BannersDatum(
        id: json["_id"] ?? '',
        image: json["image"] ?? '',
        entityType: json["entityType"] ?? 0,
        entityId: json["entityId"] ?? '',
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "entityType": entityType,
        "entityId": entityId,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannersDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
