import 'dart:convert';

BlogResponse blogResponseFromJson(String str) =>
    BlogResponse.fromJson(json.decode(str));

String blogResponseToJson(BlogResponse data) => json.encode(data.toJson());

class BlogResponse {
  BlogResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<BlogDatum>? data;

  factory BlogResponse.fromJson(Map<String, dynamic> json) => BlogResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<BlogDatum>.from(
            json["data"].map((x) => BlogDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BlogDatum {
  BlogDatum({
    this.id,
    this.title,
    this.banner,
    this.description,
    this.link,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? title;
  String? banner;
  String? description;
  String? link;
  int? status;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory BlogDatum.fromJson(Map<String, dynamic> json) => BlogDatum(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        banner: json["banner"] ?? '',
        description: json["description"] ?? '',
        link: json["link"] ?? '',
        status: json["status"] ?? 0,
        createdBy: json["createdBy"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "banner": banner,
        "description": description,
        "link": link,
        "status": status,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
