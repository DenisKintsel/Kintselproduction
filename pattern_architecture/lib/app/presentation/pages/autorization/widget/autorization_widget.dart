import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core_global/colors/colors.dart';
import '../../../widget/alert.dart';
import '../../../widget/button.dart';
import '../../../widget/text_input_widget.dart';
import '../../home/home.dart';
import '../../registration/view/registration_view.dart';

class Autorization extends StatelessWidget {
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  final Function(String, String) autUser;

   Autorization({super.key, required this.autUser});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 150),
              TextInputWidget(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  controller: _textEmailController),
              const SizedBox(height: 16),
              TextInputWidget(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'password',
                  controller: _textPasswordController),
              const SizedBox(height: 24),
              TextButton(
                  onPressed: () => Get.to(RegistrationView()),
                  child: Text("Регистрация",
                      style: TextStyle(
                          fontSize: 24, color: AppColors.selectionTextColor))),
              const SizedBox(height: 24),
              ButtonView(
                backgroundColor: AppColors.selectionColor,
                textColor: AppColors.textColorBlack,
                text: "Войти",
                //onPressed: () => Get.to(Home()),
                onPressed: (){
                  if(_textEmailController.text.isNotEmpty && _textPasswordController.text.isNotEmpty){
                    autUser.call(
                        _textEmailController.text,
                        _textPasswordController.text);
                  } else{
                    Get.snackbar(
                      "Внимание",
                      "Незаполнены поля",
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
