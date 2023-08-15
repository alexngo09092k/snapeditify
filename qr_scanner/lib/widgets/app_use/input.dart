import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.enabled,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppDimensions.instance.paddingX(0.5),
          horizontal: AppDimensions.instance.padding,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: BorderRadius.circular(AppDimensions.instance.radius),
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
