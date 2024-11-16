import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/add_request_sheet/add_request_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class AddRequestSheet extends StatefulWidget {
  const AddRequestSheet({Key? key}) : super(key: key);

  @override
  State<AddRequestSheet> createState() => _AddRequestSheetState();
}

class _AddRequestSheetState extends State<AddRequestSheet> {
  late AddRequestController controller;
  @override
  void initState() {
    super.initState();
    controller = AddRequestController()..onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: const Color(0xffFFFFFF),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 30),
          child: Obx(
            () => Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidateMode.value,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Create Employee request',
                        style:
                            TextStyle(color: Color(0xff000000), fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.clear))
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffEAEAEA)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 13, 0, 16),
                      child: TextFormField(
                          initialValue: controller.title,
                          validator: (v) =>
                              AppFormValidators.validateEmpty(v, context),
                          onSaved: controller.onTitleSaved,
                          keyboardType: TextInputType.name,
                          // textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, height: 1.8),
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            labelText: 'Job title',
                            labelStyle: TextStyle(
                                color: Color(0xffBEBEBE),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffEAEAEA)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextFormField(
                          maxLines: 4,
                          initialValue: controller.desc,
                          validator: (v) =>
                              AppFormValidators.validateEmpty(v, context),
                          onSaved: controller.onDescSaved,
                          keyboardType: TextInputType.name,
                          // textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, height: 1.8),
                          decoration: const InputDecoration(
                            // isCollapsed: true,
                            // isDense: true,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            labelText: 'Job description',
                            labelStyle: TextStyle(
                                color: Color(0xffBEBEBE),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 13, 0, 16),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: controller.onVacancySaved,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: 'Vacancy',
                                  labelStyle: TextStyle(
                                      color: Color(0xffBEBEBE),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 13, 0, 16),
                            child: TextFormField(
                                initialValue: controller.experience,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                onSaved: controller.onExperienceSaved,
                                keyboardType: TextInputType.number,
                                // textCapitalization: TextCapitalization.words,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, height: 1.8),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: 'Experience',
                                  labelStyle: TextStyle(
                                      color: Color(0xffBEBEBE),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffEAEAEA)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: DropdownButtonFormField<int>(
                          onSaved: controller.onTypeSaved,
                          validator: (v) =>
                              AppFormValidators.validateEmpty(v, context),
                          items: AddRequestController.manPowerType
                              .map((int e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e == 1
                                      ? 'On pay roll'
                                      : e == 2
                                          ? 'Off pay roll'
                                          : e == 3
                                              ? 'Direct recruitment'
                                              : '')))
                              .toList(),
                          onChanged: controller.onTypeSaved,
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            labelText: 'Manpower type',
                            labelStyle: TextStyle(
                                color: Color(0xffBEBEBE),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffEAEAEA)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 13, 0, 16),
                      child: TextFormField(
                          initialValue: controller.location,
                          validator: (v) =>
                              AppFormValidators.validateEmpty(v, context),
                          onSaved: controller.onLocationSaved,
                          keyboardType: TextInputType.name,
                          // textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, height: 1.8),
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            labelText: 'Location',
                            labelStyle: TextStyle(
                                color: Color(0xffBEBEBE),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 13, 0, 16),
                            child: TextFormField(
                                initialValue: controller.minSalary,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                onSaved: controller.onMinSalarySaved,
                                keyboardType: TextInputType.number,
                                // textCapitalization: TextCapitalization.words,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, height: 1.8),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: 'Min. Salary',
                                  labelStyle: TextStyle(
                                      color: Color(0xffBEBEBE),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 13, 0, 16),
                            child: TextFormField(
                                initialValue: controller.maxSalary,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                onSaved: controller.onMaxSalarySaved,
                                keyboardType: TextInputType.number,
                                // textCapitalization: TextCapitalization.words,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, height: 1.8),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: 'Max. Salary',
                                  labelStyle: TextStyle(
                                      color: Color(0xffBEBEBE),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  AppPrimaryButton(
                      child: const Text('Create employee request',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: Environment.fontFamily,
                              fontWeight: FontWeight.w400)),
                      onPressed: controller.createRequest)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
