import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core_global/colors/colors.dart';
import '../../../widget/alert.dart';
import '../../../widget/button.dart';
import '../../../widget/text_input_widget.dart';
import '../../autorization/view/autorizatoin_view.dart';

class RegistrationWidget extends StatelessWidget {
  final Function(String, String, String, String) regUser;
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textCityController = TextEditingController();

  RegistrationWidget({super.key, required this.regUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Center(
                    child: Image.asset(
                  'assets/images/logo.png',
                  color: AppColors.selectionColor,
                )),
                const SizedBox(height: 100),
                TextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    controller: _textEmailController),
                const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Имя',
                    controller: _textNameController),
                const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Город',
                    controller: _textCityController),
                const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'password',
                    controller: _textPasswordController),
                const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'Повторите пароль',
                    controller: _textPasswordController),
                const SizedBox(height: 24),
                TextButton(
                    onPressed: () => Get.to(const AutorizationView()),
                    child: const Text("Авторизация",
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.selectionTextColor))),
                const SizedBox(height: 24),
                ButtonView(
                    backgroundColor: AppColors.selectionColor,
                    textColor: AppColors.textColorBlack,
                    text: 'Регистрация',
                    onPressed: () {
                      if (_textEmailController.text.isNotEmpty &&
                          _textNameController.text.isNotEmpty &&
                          _textCityController.text.isNotEmpty &&
                          _textPasswordController.text.isNotEmpty) {
                        regUser.call(
                            _textEmailController.text,
                            _textNameController.text,
                            _textCityController.text,
                            _textPasswordController.text);
                      } else{
                        Get.snackbar(
                          "Внимание",
                          "Незаполнены поля",
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
