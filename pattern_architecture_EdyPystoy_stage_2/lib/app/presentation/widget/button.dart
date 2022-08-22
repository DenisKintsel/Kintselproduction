import 'package:flutter/material.dart';

import '../../core_global/colors/colors.dart';

class ButtonView extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color ?backgroundColor;
  final Color ?textColor;
  const ButtonView({Key? key, required this.text, required this.onPressed, this.backgroundColor, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () => onPressed.call(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor ?? AppColors.backgroundCard),
              fixedSize: MaterialStateProperty.all(const Size(265, 65)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: textColor ?? Colors.white),
            ))
    );
  }
}
