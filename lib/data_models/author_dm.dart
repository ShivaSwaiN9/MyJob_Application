import 'dart:convert';

List<AuthorDatum> authorDatumFromJson(String str) => List<AuthorDatum>.from(
    json.decode(str).map((x) => AuthorDatum.fromJson(x)));

String authorDatumToJson(List<AuthorDatum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorDatum {
  AuthorDatum({
    this.id,
    this.image,
    this.entityType,
    this.entityId,
    this.quote,
    this.author,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? image;
  int? entityType;
  String? entityId;
  String? quote;
  String? author;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AuthorDatum.fromJson(Map<String, dynamic> json) => AuthorDatum(
        id: json["_id"] ?? 0,
        image: json["image"] ?? '',
        entityType: json["entityType"] ?? 0,
        entityId: json["entityId"] ?? '',
        quote: json["quote"] ?? '',
        author: json["author"] ?? '',
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
        "quote": quote,
        "author": author,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
