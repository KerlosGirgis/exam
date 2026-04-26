import 'package:flutter/material.dart';
import '../constant/app_text_constants.dart';

abstract class AppValidators {
  static String? fullNameValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static bool isValidEmail(String email) {
    final bool emailvalid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    return emailvalid;
  }

  static String? emailValidation(String? value) {
    String? result = fullNameValidator(value, AppTextConstants.enterEmail);
    if (result == null) {
      if (!isValidEmail(value!)) {
        result = AppTextConstants.emailInvalid;
      }
    }
    return result;
  }

  static String? nameValidation(String? value) {
    String? result = fullNameValidator(value, 'Name is required');
    if (result == null) {
      if (value!.length < 3) {
        return 'Name must be at least 3 characters';
      }
      final regex = RegExp(r'^[A-Za-z]+$');
      if (!regex.hasMatch(value)) {
        return 'Name must contain only letters (no spaces or symbols)';
      }
    }
    return result;
  }

  static String? passwordValidation(String? value) {
    String? result = fullNameValidator(value, AppTextConstants.enterPassword);
    if (result == null) {
      if (value!.length < 8) {
        result = AppTextConstants.passwordMinLength;
      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
        result = AppTextConstants.passwordUpper;
      } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
        result = AppTextConstants.passwordLower;
      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
        result = AppTextConstants.passwordDigit;
      } else if (!RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
        result = AppTextConstants.passwordSpecial;
      }
    }
    return result;
  }

  static String? passconfirmValidation(
    String? value,
    TextEditingController passwordController,
  ) {
    String? result = fullNameValidator(value, AppTextConstants.reEnterPassword);
    if (result == null) {
      if (value != passwordController.text) {
        result = AppTextConstants.passwordsDoNotMatch;
      } else if (value!.length < 8) {
        result = AppTextConstants.passwordMinLength;
      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
        result = AppTextConstants.passwordUpper;
      } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
        result = AppTextConstants.passwordLower;
      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
        result = AppTextConstants.passwordDigit;
      } else if (!RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
        result = AppTextConstants.passwordSpecial;
      }
    }
    return result;
  }

  static String? phoneValidation(String? value) {
    String? result = fullNameValidator(value, AppTextConstants.enterPhoneNumber);
    if (result == null) {
      String phone = value!.replaceAll('+20', '0').replaceAll(' ', '');
      if (!RegExp(r'^01[0-9]{9}$').hasMatch(phone)) {
        return AppTextConstants.phoneInvalid;
      }
    }
    return result;
  }
}
