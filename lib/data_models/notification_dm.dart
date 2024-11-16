import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<NotificationDatum>? data;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<NotificationDatum>.from(
            json["data"].map((x) => NotificationDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationDatum {
  NotificationDatum({
    this.id,
    this.status,
    this.createdBy,
    this.title,
    this.description,
    this.entityId,
    this.entityType,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  int? status;
  String? createdBy;
  String? title;
  String? description;
  String? entityId;
  int? entityType;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        entityId: json["entityId"] ?? '',
        entityType: json["entityType"] ?? 0,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "createdBy": createdBy,
        "title": title,
        "description": description,
        "entityId": entityId,
        "entityType": entityType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
