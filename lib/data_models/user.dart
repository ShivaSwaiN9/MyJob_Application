import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.accessToken,
    this.user,
  });

  String? accessToken;
  UserData? user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        accessToken: json["accessToken"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "user": user?.toJson(),
      };
}

class UserData {
  UserData(
      {this.id,
      this.email,
      this.phone,
      this.gender,
      this.dob,
      this.maritalStatus,
      this.name,
      this.companyName,
      this.education = const [],
      this.primaryJobPreference,
      this.secondaryJobPreference,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.employment = const [],
      this.avatar,
      this.coverImage,
      this.address,
      this.referralCode,
      this.referralCount,
      this.referredBy,
      this.document,
      this.subscription,
      this.project = const [],
      this.bio});

  String? id;
  String? email;
  String? phone;
  int? gender;
  DateTime? dob;
  int? maritalStatus;
  String? name;
  String? companyName;
  List<Education> education;
  String? primaryJobPreference;
  String? secondaryJobPreference;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Employment> employment;
  String? avatar;
  String? coverImage;
  Address? address;
  String? referralCode;
  int? referralCount;
  String? referredBy;
  Document? document;
  Subscription? subscription;
  List<Project> project;
  String? bio;

  double progress() {
    double c = 0.4;
    if (document == null) {
      return c;
    }
    if (document?.msmeRegistrationCertification != null) c += 0.1;
    if (document?.shopAndEstablishmentCertificate != null) c += 0.1;
    if (document?.companyIncorporationCertificate != null) c += 0.1;
    if (document?.fssaiLicense != null) c += 0.1;
    if (document?.companyPanCard != null) c += 0.1;
    if (document?.companyGstCertificate != null) c += 0.1;
    return c;
  }

  double getPercentage() {
    double score = 0, totalScore = 10;
    if (name!.isNotEmpty) score += 1;
    if (avatar!.isNotEmpty) score += 1;
    if (email!.isNotEmpty) score += 1;
    if (gender != null) score += 1;
    if (dob != null) score += 1;
    if (maritalStatus != null) score += 1;
    if (address != null) score += 1;
    if (education != null) score += 1;
    if (employment != null) score += 1;
    if (secondaryJobPreference!.isNotEmpty) score += 1;
    return (score / totalScore) * 100.roundToDouble();
  }

  String genderString(BuildContext context) {
    if (gender == 1) {
      return "Male";
    } else if (gender == 2) {
      return "Female";
    } else if (gender == 3) {
      return "Others";
    } else {
      return "";
    }
  }

  String maritalStatusString(BuildContext context) {
    if (maritalStatus == 1) {
      return "Married";
    } else {
      return "Unmarried";
    }
  }

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["_id"] ?? '',
      email: json["email"] ?? '',
      phone: json["phone"] ?? '',
      gender: json["gender"] ?? 0,
      dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
      maritalStatus: json["maritalStatus"] ?? 0,
      name: json["name"] ?? '',
      companyName: json["companyName"] ?? '',
      education: json["education"] == null
          ? []
          : List<Education>.from(
              json["education"].map((x) => Education.fromJson(x))),
      primaryJobPreference: json["primaryJobPreference"] ?? '',
      secondaryJobPreference: json["secondaryJobPreference"] ?? '',
      role: json["role"] ?? 0,
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      employment: json["employment"] == null
          ? []
          : List<Employment>.from(
              json["employment"].map((x) => Employment.fromJson(x))),
      project: json["project"] == null
          ? []
          : List<Project>.from(json["project"].map((x) => Project.fromJson(x))),
      avatar: json["avatar"] ?? '',
      coverImage: json["coverImage"] ?? '',
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      referralCount: json["referralCount"] ?? 0,
      referralCode: json["referralCode"] ?? '',
      referredBy: json["referredBy"] ?? '',
      subscription: json["subscription"] == null
          ? null
          : Subscription.fromJson(json["subscription"]),
      document:
          json["document"] == null ? null : Document.fromJson(json["document"]),
      bio: json["bio"] ?? '');

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phone": phone,
        "gender": gender,
        "dob": dob?.toIso8601String(),
        "maritalStatus": maritalStatus,
        "name": name,
        "companyName": companyName,
        "education": List<dynamic>.from(education.map((x) => x.toJson())),
        "primaryJobPreference": primaryJobPreference,
        "secondaryJobPreference": secondaryJobPreference,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "employment": List<dynamic>.from(employment.map((x) => x.toJson())),
        "avatar": avatar,
        "coverImage": coverImage,
        "address": address,
        "referralCount": referralCount,
        "referralCode": referralCode,
        "referredBy": referredBy,
        "document": document?.toJson(),
        "subscription": subscription?.toJson(),
        "project": List<dynamic>.from(project.map((x) => x.toJson())),
        "bio": bio
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserData && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String getAddressString() {
    String addressStr = "";
    if (address != null) {
      if (address?.permanentAddress?.isNotEmpty ?? false) {
        addressStr += address!.permanentAddress!;
        if (address?.pin?.isNotEmpty ?? false) {
          addressStr += ", " + address!.pin!;
        }
      }
    }
    return addressStr;
  }
}

class Address {
  Address({
    this.permanentAddress,
    this.pin,
  });

  String? permanentAddress;
  String? pin;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        permanentAddress: json["permanentAddress"] ?? '',
        pin: (json["pin"] ?? '').toString(),
      );

  Map<String, dynamic> toJson() =>
      {"permanentAddress": permanentAddress, "pin": pin};
}

class Education {
  Education({
    this.highestEducation,
    this.course,
    this.university,
    this.yearOfPassing,
  });

  String? highestEducation;
  String? course;
  String? university;
  String? yearOfPassing;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        highestEducation: json["highestEducation"] ?? '',
        course: json["course"] ?? '',
        university: json["university"] ?? '',
        yearOfPassing: json["yearOfPassing"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "highestEducation": highestEducation,
        "course": course,
        "university": university,
        "yearOfPassing": yearOfPassing,
      };
}

class Employment {
  Employment({
    this.organisation,
    this.designation,
    this.startFrom,
    this.endFrom,
    this.responsibility,
  });

  String? organisation;
  String? designation;
  DateTime? startFrom;
  DateTime? endFrom;
  String? responsibility;

  factory Employment.fromJson(Map<String, dynamic> json) => Employment(
        organisation: json["organisation"] ?? '',
        designation: json["designation"] ?? '',
        startFrom: json["startFrom"] == null
            ? null
            : DateTime.parse(json["startFrom"]),
        endFrom:
            json["endFrom"] == null ? null : DateTime.parse(json["endFrom"]),
        responsibility: json["responsibility"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "organisation": organisation,
        "designation": designation,
        "startFrom": startFrom?.toIso8601String(),
        "endFrom": endFrom?.toIso8601String(),
        "responsibility": responsibility,
      };

  String durationString(BuildContext context) {
    String text = "";
    if (startFrom != null) {
      text += DateFormat("dd.MM.yyyy").format(startFrom!);

      if (endFrom != null) {
        text += " " + DateFormat("dd.MM.yyyy").format(endFrom!);
      } else {
        text += " Present";
      }
    }
    return text;
  }
}

class Document {
  Document({
    this.companyGstCertificate,
    this.companyPanCard,
    this.fssaiLicense,
    this.companyIncorporationCertificate,
    this.shopAndEstablishmentCertificate,
    this.msmeRegistrationCertification,
  });

  String? companyGstCertificate;
  String? companyPanCard;
  String? fssaiLicense;
  String? companyIncorporationCertificate;
  String? shopAndEstablishmentCertificate;
  String? msmeRegistrationCertification;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        companyGstCertificate: json["companyGSTCertificate"],
        companyPanCard: json["companyPanCard"],
        fssaiLicense: json["FSSAILicense"],
        companyIncorporationCertificate:
            json["companyIncorporationCertificate"],
        shopAndEstablishmentCertificate:
            json["shopAndEstablishmentCertificate"],
        msmeRegistrationCertification: json["msmeRegistrationCertification"],
      );

  Map<String, dynamic> toJson() => {
        "companyGSTCertificate": companyGstCertificate,
        "companyPanCard": companyPanCard,
        "FSSAILicense": fssaiLicense,
        "companyIncorporationCertificate": companyIncorporationCertificate,
        "shopAndEstablishmentCertificate": shopAndEstablishmentCertificate,
        "msmeRegistrationCertification": msmeRegistrationCertification
      };
}

class Subscription {
  Subscription(
      {this.subscriptionPlanId,
      this.razorpaySubscriptionId,
      this.status,
      this.validTill});

  String? subscriptionPlanId;
  String? razorpaySubscriptionId;
  int? status;
  DateTime? validTill;

  bool get isActive =>
      status == 1 &&
      validTill != null &&
      validTill!.difference(DateTime.now()).inDays > 1;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        subscriptionPlanId: json["subscriptionPlanId"] ?? '',
        razorpaySubscriptionId: json["razorpaySubscriptionId"] ?? '',
        status: json["status"] ?? 0,
        validTill: json["validTill"] == null
            ? null
            : DateTime.parse(json["validTill"]),
      );

  Map<String, dynamic> toJson() => {
        "subscriptionPlanId": subscriptionPlanId,
        "razorpaySubscriptionId": razorpaySubscriptionId,
        "status": status,
        "validTill": validTill?.toIso8601String(),
      };
}

class Project {
  Project({
    this.id,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.link,
  });

  String? id;
  String? name;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? link;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        link: json["link"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "link": link,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
