import 'package:crm_project/core/const/app_tokens.dart';
import 'package:flutter/material.dart';


class CustomInputDecoration {
  CustomInputDecoration._();

  static InputDecoration build({
    required String hintText,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppTokens.neutral500, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      
      prefixIcon: prefixIcon,
      prefixIconColor: WidgetStateColor.resolveWith(
        (states) => states.contains(WidgetState.focused) ? AppTokens.primary600 : AppTokens.neutral500,
      ),
      suffixIcon: suffixIcon,
      suffixIconColor: WidgetStateColor.resolveWith(
        (states) => states.contains(WidgetState.focused) ? AppTokens.primary600 : AppTokens.neutral500,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.rMd),
        borderSide: const BorderSide(color: AppTokens.neutral300, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.rMd),
        borderSide: const BorderSide(color: AppTokens.primary600, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.rMd),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTokens.rMd),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.8),
      ),
      errorStyle: const TextStyle(
        fontFamily: AppTokens.fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}