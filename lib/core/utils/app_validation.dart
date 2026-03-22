import 'package:flutter/material.dart';

class Validation {
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
    final bool isGmail = email.trim().toLowerCase().endsWith('@gmail.com');
    return emailvalid && !isGmail;
  }

  static String? emailValidation(String? value) {
    String? result = fullNameValidator(value, "Please enter your email");
    if (result == null) {
      if (!isValidEmail(value!)) {
        result = "Email is not valid";
      }
    }
    return result;
  }

  static String? passwordValidation(String? value) {
    String? result = fullNameValidator(value, "Please enter your password");
    if (result == null) {
      if (value!.length < 8) {
        result = "Min 8 characters";
      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
        result = "Add uppercase letter (A-Z)";
      } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
        result = "Add lowercase letter (a-z)";
      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
        result = "Add digit (0-9)";
      } else if (!RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
        result = "Add special char (#?!@\$%^&*-)";
      }
    }
    return result;
  }

  static String? passconfirmValidation(
    String? value,
    TextEditingController passwordController,
  ) {
    String? result = fullNameValidator(value, "Please confirm your password");
    if (result == null) {
      if (value != passwordController.text) {
        result = "Passwords don't match";
      } else if (value!.length < 8) {
        result = "Min 8 characters";
      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
        result = "Add uppercase letter (A-Z)";
      } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
        result = "Add lowercase letter (a-z)";
      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
        result = "Add digit (0-9)";
      } else if (!RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(value)) {
        result = "Add special char (#?!@\$%^&*-)";
      }
    }
    return result;
  }

  static String? phoneValidation(String? value) {
    String? result = fullNameValidator(value, "Please enter your phone number");
    if (result == null) {
      String phone = value!.replaceAll('+20', '0').replaceAll(' ', '');
      if (!RegExp(r'^01[0-9]{9}$').hasMatch(phone)) {
        return "Enter a valid Egyptian number like 01096703854";
      }
    }
    return result;
  }
}
