import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class LoanCalculatorController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberCtl = TextEditingController();
  final TextEditingController totalAmountCtl = TextEditingController();
  final TextEditingController destinationCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();
  final TextEditingController dateCtl = TextEditingController();
  final Rxn<XFile> uploadFile = Rxn<XFile>();
  ClientModel? clientSelected;

  List<StaffModel> StaffList = [];
  StaffModel? StaffSelected;

  List<ProductModel> ProductList = [];
  ProductModel? ProductSelected;
  @override
  void onInit() {
    super.onInit();
  }

  void onStaffChanged(StaffModel? selectedClient) {
    StaffSelected = selectedClient;
  }

  @override
  void onClose() {
    phoneNumberCtl.dispose();
    totalAmountCtl.dispose();
    destinationCtl.dispose();
    descriptionCtl.dispose();
    dateCtl.dispose();
    super.onClose();
  }

  DatePicker getDatePicker() {
    final DatePicker startPicker = DatePicker(
      controller: dateCtl,
      initialDate:
          dateCtl.text.isEmpty
              ? DateTime.parse(
                '${DateFormat("yyyy-MM-dd").format(DateTime.now())} 00:00:00',
              )
              : DateTime.parse(dateCtl.text),
      minDate: DateTime(DateTime.now().year),
      maxDate: DateTime(DateTime.now().year + 200),
      minYear: DateTime.now().year,
      maxYear: DateTime.now().year + 200,
    );
    return startPicker;
  }

  Future<void> submitBooking() async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        // This static because of feature removed
        'type_of_service': 1,
        'any_extra': 'no',
        'any_extra_type': 'other',
        'extra_amount': 0.00,
        'type_of_cod': 'COD',

        'date': dateCtl.text,
        'destination_phone': phoneNumberCtl.text.replaceAll(' ', ''),
        'destination_desc': descriptionCtl.text,
        'total_amount': double.parse(totalAmountCtl.text.replaceAll(',', '.')),
        'image':
            uploadFile.value != null
                ? await dio.MultipartFile.fromFile(
                  uploadFile.value!.path,
                  filename: uploadFile.value!.name,
                  contentType: MediaType('image', 'png'),
                )
                : null,
      });
      await Get.find<ApiService>().post(
        EndPoints.createBooking,
        formData,
        isShowLoading: true,
      );

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: LocaleKeys.youHavesuccessfullyCreatedTheBooking.tr,
        onPressed: () => Get.back(),
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    }
  }
}
