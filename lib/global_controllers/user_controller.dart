import 'dart:developer' as d;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/document_chooser.dart';
import 'package:my_job_flutter/widgets/photo_chooser.dart';

///
/// Created by Kumar Sunil from Boiler plate
///

class UserController extends GetxController with StateMixin<UserData> {

  bool uploadingDp = false;
  bool uploadingCover = false;
  bool uploadingFile1 = false;
  bool uploadingFile2 = false;
  bool uploadingFile3 = false;
  bool uploadingFile4 = false;
  bool uploadingFile5 = false;
  bool uploadingFile6 = false;
  @override
  void onInit() {
    super.onInit();

    final user = SharedPreferenceHelper.user?.user;
    change(user, status: user == null ? RxStatus.empty() : RxStatus.success());
  }

  updateUser(UserData? user) {
    final u = SharedPreferenceHelper.user;
    if (u != null) {
      u.user = user;
      SharedPreferenceHelper.storeUser(user: u);
    }
    change(null, status: RxStatus.loading());
    change(user, status: RxStatus.success());
  }

  logOutUser() {
    change(null, status: RxStatus.empty());
  }

  chooseProfilePicture() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const PhotoChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        uploadDp(value);
      }
    });
  }

  chooseCoverPicture() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(
            const PhotoChooser(cropRatio: [CropAspectRatioPreset.ratio16x9]),
            backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        uploadCover(value);
      }
    });
  }

  chooseFile1() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const DocumentChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        print("valuec $value");
        uploadCertificate1(value);
      }
    });
  }

  chooseFile2() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const DocumentChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        uploadCertificate2(value);
      }
    });
  }

  chooseFile3() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const DocumentChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        uploadCertificate3(value);
      }
    });
  }

  chooseFile4() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const DocumentChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        uploadCertificate4(value);
      }
    });
  }

  chooseFile5() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const DocumentChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        uploadCertificate5(value);
      }
    });
  }

  chooseFile6() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const DocumentChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        print("file6 ${value}");
        uploadCertificate6(value);
      }
    });
  }

  deleteCertificate(String key) async {
    try {
      final map = state?.document?.toJson();
      map?[key] = null;
      await AuthHelper.updateUser({"document": map});
      change(state, status: RxStatus.success());
    } catch (e, s) {
      d.log("deleteFile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    }
  }

  uploadCertificate1(File certFile) async {
    uploadingFile1 = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(certFile);
      print("file 1 ${url}");
      if (url != null) {
        final map = state?.document?.toJson() ?? {};
        map["companyGSTCertificate"] = url;
        print("file 1 ${map["companyGSTCertificate"]}");
        await AuthHelper.updateUser({"document": map});
      }
      change(state, status: RxStatus.success());
      SnackBarHelper.show("File uploaded successfully");
    } catch (e, s) {
      d.log("uploadFile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingFile1 = false;
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
    }
  }

  uploadCertificate2(File certFile) async {
    uploadingFile2 = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(certFile);
      if (url != null) {
        final map = state?.document?.toJson() ?? {};
        map["companyPanCard"] = url;
        await AuthHelper.updateUser({"document": map});
      }
      change(state, status: RxStatus.success());
      SnackBarHelper.show("File uploaded successfully");
    } catch (e, s) {
      d.log("uploadFile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingFile2 = false;
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
    }
  }

  uploadCertificate3(File certFile) async {
    uploadingFile3 = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(certFile);
      if (url != null) {
        final map = state?.document?.toJson() ?? {};
        map["FSSAILicense"] = url;
        await AuthHelper.updateUser({"document": map});
      }
      change(state, status: RxStatus.success());
      SnackBarHelper.show("File uploaded successfully");
    } catch (e, s) {
      d.log("uploadFile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingFile3 = true;
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
    }
  }

  uploadCertificate4(File certFile) async {
    uploadingFile4 = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(certFile);
      if (url != null) {
        final map = state?.document?.toJson() ?? {};
        map["companyIncorporationCertificate"] = url;
        await AuthHelper.updateUser({"document": map});
      }
      change(state, status: RxStatus.success());
      SnackBarHelper.show("File uploaded successfully");
    } catch (e, s) {
      d.log("uploadFile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingFile4 = false;
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
    }
  }

  uploadCertificate5(File certFile) async {
    uploadingFile5 = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(certFile);
      if (url != null) {
        final map = state?.document?.toJson() ?? {};
        map["shopAndEstablishmentCertificate"] = url;
        await AuthHelper.updateUser({"document": map});
      }
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
      SnackBarHelper.show("File uploaded successfully");
    } catch (e, s) {
      d.log("uploadFile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingFile5 = false;
      change(state, status: RxStatus.success());
    }
  }

  uploadCertificate6(File certFile) async {
    uploadingFile6 = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(certFile);
      print("file6 url ${url}");
      if (url != null) {
        final map = state?.document?.toJson() ?? {};
        map["msmeRegistrationCertification"] = url;
        print("file 6 $map");
        await AuthHelper.updateUser({"document": map});
      }
      change(state, status: RxStatus.success());
      SnackBarHelper.show("File uploaded successfully");
    } catch (e, s) {
      d.log("uploadFile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingFile6 = false;
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
    }
  }

  uploadDp(File image) async {
    uploadingDp = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(image);
      if (url != null) await AuthHelper.updateUser({"avatar": url});
      change(state, status: RxStatus.success());
    } catch (e, s) {
      d.log("profile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingDp = false;
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
    }
  }

  uploadCover(File image) async {
    uploadingCover = true;
    change(state, status: RxStatus.loading());
    change(state, status: RxStatus.success());
    try {
      String? url = await ApiCall.singleFileUpload(image);
      if (url != null) await AuthHelper.updateUser({"coverImage": url});
      change(state, status: RxStatus.success());
    } catch (e, s) {
      d.log("profile", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      uploadingCover = false;
      change(state, status: RxStatus.loading());
      change(state, status: RxStatus.success());
    }
  }

  Future refreshUser() async {
    if (SharedPreferenceHelper.user == null) return;
    try {
      change(null, status: RxStatus.loading());

      final result = await ApiCall.get(
        "v1/user",
        id: SharedPreferenceHelper.user!.user!.id!,
      );
      final updatedData = UserData.fromJson(result.data);
      change(updatedData, status: RxStatus.success());
    } catch (e, s) {
      SnackBarHelper.show(e.toString());
      d.log("refreshUser", error: e, stackTrace: s);
    }
  }

  updateSubscriptionStatus(int s) {
    final user = state;
    change(null, status: RxStatus.loading());
    user!.subscription = Subscription(status: s);
    change(user, status: RxStatus.success());
  }

  deleteEducation(Education education) async {
    try {
      final educationList = SharedPreferenceHelper.user?.user?.education;
      educationList?.removeWhere(
          (element) => element.highestEducation == education.highestEducation);
      final body = {
        "education": [
          ...List<dynamic>.from(educationList!.map((e) => e.toJson())),
        ]
      };
      await AuthHelper.updateUser(body);
    } catch (e, s) {
      d.log('Error $e', stackTrace: s);
      SnackBarHelper.show(e.toString());
    }
  }

  deleteEmployment(Employment employment) async {
    try {
      final employeeList = SharedPreferenceHelper.user?.user?.employment;
      employeeList?.removeWhere(
          (element) => element.organisation == employment.organisation);
      final body = {
        "employment": [
          ...List<dynamic>.from(employeeList!.map((e) => e.toJson())),
        ]
      };
      await AuthHelper.updateUser(body);
    } catch (e, s) {
      d.log('Error $e', stackTrace: s);
      SnackBarHelper.show(e.toString());
    }
  }

  deleteProject(Project project) async {
    try {
      final proList = SharedPreferenceHelper.user?.user?.project;
      proList?.removeWhere((element) => element.id == project.id);
      final body = {
        "project": [
          ...List<dynamic>.from(proList!.map((e) => e.toJson())),
        ]
      };
      await AuthHelper.updateUser(body);
    } catch (e, s) {
      d.log('Error $e', stackTrace: s);
      SnackBarHelper.show(e.toString());
    }
  }


}
