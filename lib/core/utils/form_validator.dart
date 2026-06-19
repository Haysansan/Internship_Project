import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormValidator {
  static String? empty(String? text) {
    if ((text ?? '').isEmpty) {
      return LocaleKeys.cannotBeEmpty.tr;
    }
    return null;
  }

  static String? phoneNumber(String? text) {
    final String? emptyCheck = empty(text);
    if (emptyCheck != null) {
      return emptyCheck;
    }

    text = text!.replaceAll(' ', '');
    if (text.length < 8 || text.length > 12) {
      return LocaleKeys.invalidPhoneNumber.tr;
    }
    return null;
  }

  static String? email(String? text) {
    final String? emptyCheck = empty(text);
    if (emptyCheck != null) {
      return emptyCheck;
    }

    if (!_isEmail(text!)) {
      return LocaleKeys.invalidEmail.tr;
    }
    return null;
  }

  static String? equalValues({String? original, String? confirm}) {
    final String? emptyCheck = empty(confirm);
    if (emptyCheck != null) {
      return emptyCheck;
    }

    if ((original ?? '').trim() != confirm!.trim()) {
      return LocaleKeys.passwordDoNotMatch.tr;
    }
    return null;
  }

  static MaskTextInputFormatter maskInputPhoneNumber() {
    return MaskTextInputFormatter(
      mask: '### ### ####',
      filter: {
        '#': RegExp(r'[0-9]'),
        '&': RegExp(r'[1-9]'),
      },
    );
  }

  static bool _isEmail(String value) {
    final RegExp email = RegExp(
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
    return email.hasMatch(value.toLowerCase());
  }
}
