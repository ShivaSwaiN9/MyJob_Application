import 'dart:convert';

JobResponse jobResponseFromJson(String str) =>
    JobResponse.fromJson(json.decode(str));

String jobResponseToJson(JobResponse data) => json.encode(data.toJson());

class JobResponse {
  JobResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<JobDatum>? data;

  factory JobResponse.fromJson(Map<String, dynamic> json) => JobResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data:
            List<JobDatum>.from(json["data"].map((x) => JobDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class JobDatum {
  JobDatum({
    this.id,
    this.name,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? avatar;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory JobDatum.fromJson(Map<String, dynamic> json) => JobDatum(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        avatar: json["avatar"] ?? '',
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
        "name": name,
        "avatar": avatar,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
