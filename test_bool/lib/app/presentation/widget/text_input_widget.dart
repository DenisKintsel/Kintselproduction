import 'package:flutter/material.dart';
import 'package:test_bool/app/core_global/colors/colors.dart';

class TextInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final Color? textColor;
  final int ?maxLines;

  const TextInputWidget(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.textColor,
      this.maxLines})
      : super(key: key);

  @override
  _TextInputWidget createState() => _TextInputWidget();
}

class _TextInputWidget extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        style: TextStyle(color: widget.textColor ?? AppColors.textColor),
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
          prefixIconColor: AppColors.textColor,
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.subtextColor),
        ),
      ),
    );
  }
}
