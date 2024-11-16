import 'dart:convert';

EmployeeRequestResponse employeeRequestFromJson(String str) =>
    EmployeeRequestResponse.fromJson(json.decode(str));

String employeeRequestToJson(EmployeeRequestResponse data) =>
    json.encode(data.toJson());

class EmployeeRequestResponse {
  EmployeeRequestResponse({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int? total;
  int? limit;
  int? skip;
  List<EmployeeRequestDatum>? data;

  factory EmployeeRequestResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeRequestResponse(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<EmployeeRequestDatum>.from(
            json["data"].map((x) => EmployeeRequestDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EmployeeRequestDatum {
  EmployeeRequestDatum(
      {this.id,
      this.status,
      this.title,
      this.noOfEmployees,
      this.description,
      this.salary,
      this.type,
      this.workLocation,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.applicationStatus,
      this.maxSalary,
      this.minSalary,
      this.experience,
      this.isFeatured});

  String? id;
  int? status;
  String? title;
  String? noOfEmployees;
  String? description;
  int? minSalary;
  int? maxSalary;
  int? experience;
  int? salary;
  int? type;
  String? workLocation;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? applicationStatus;
  bool? isFeatured;

  factory EmployeeRequestDatum.fromJson(Map<String, dynamic> json) =>
      EmployeeRequestDatum(
          id: json["_id"] ?? '',
          status: json["status"] ?? 0,
          applicationStatus: json["applicationStatus"] ?? 0,
          title: json["title"] ?? '',
          noOfEmployees: json["noOfEmployees"] ?? '',
          description: json["description"] ?? '',
          salary: json["salary"] ?? 0,
          type: json["type"] ?? 0,
          workLocation: json["workLocation"] ?? '',
          createdBy: json["createdBy"] ?? '',
          createdAt: json["createdAt"] == null
              ? null
              : DateTime.parse(json["createdAt"]),
          updatedAt: json["updatedAt"] == null
              ? null
              : DateTime.parse(json["updatedAt"]),
          v: json["__v"],
          experience: json["experience"] ?? 1,
          minSalary: json["minSalary"] ?? 0,
          maxSalary: json["maxSalary"] ?? 0,
          isFeatured: json["isFeatured"] ?? false);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "title": title,
        "noOfEmployees": noOfEmployees,
        "description": description,
        "salary": salary,
        "type": type,
        "workLocation": workLocation,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "applicationStatus": applicationStatus,
        "experience": experience,
        "minSalary": minSalary,
        "maxSalary": maxSalary,
        "isFeatured": isFeatured
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeRequestDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
