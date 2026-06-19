import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/models/id_name/id_name.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameCon = TextEditingController();
  final TextEditingController phoneNumberCon = TextEditingController();
  final TextEditingController locationCon = TextEditingController();
  final TextEditingController bankCon = TextEditingController();
  final TextEditingController accountNameCon = TextEditingController();
  final TextEditingController accountNumberCon = TextEditingController();
  final TextEditingController productCategoryCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final TextEditingController confirmCon = TextEditingController();

  @override
  void onClose() {
    nameCon.dispose();
    phoneNumberCon.dispose();
    locationCon.dispose();
    bankCon.dispose();
    accountNameCon.dispose();
    accountNumberCon.dispose();
    productCategoryCon.dispose();
    passCon.dispose();
    confirmCon.dispose();
  }

  final List<IdNameModel> banks = [
    IdNameModel(id: 1, name: 'ABA'),
    IdNameModel(id: 2, name: 'AMK'),
    IdNameModel(id: 3, name: 'Acleda'),
    IdNameModel(id: 4, name: 'Wing'),
  ];
}
