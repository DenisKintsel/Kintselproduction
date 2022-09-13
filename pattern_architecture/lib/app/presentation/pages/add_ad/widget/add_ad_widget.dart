import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core_global/colors/colors.dart';
import '../../../widget/alert.dart';
import '../../../widget/button.dart';
import '../../../widget/text_input_widget.dart';
import 'package:intl/intl.dart';

class AddAdWidget extends StatefulWidget {

  final Function(String,String,String,String,String,String) addAd;

  const AddAdWidget({super.key, required this.addAd});

  @override
  _AddAdWidget createState() => _AddAdWidget();
}

class _AddAdWidget extends State<AddAdWidget> {
  final TextEditingController _textTitleController = TextEditingController();
  final TextEditingController _textCarController = TextEditingController();
  final TextEditingController _textNotesController = TextEditingController();
  final TextEditingController _textDepartureController = TextEditingController();
  final TextEditingController _textReceiptController = TextEditingController();
   final TextEditingController _data = TextEditingController();


  DateTime selectedDate = DateTime.now();
  DateTime dataTrip = DateTime.now();
   String formattedDate = 'dd-MM-yyyy';
  void _showDataParcker(){
    showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2050)).then((value) {
          setState(() {
            dataTrip = value!;
            formattedDate = DateFormat('dd-MM-yyyy').format(dataTrip);
            _data.text = formattedDate;
          });
    });
  }

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
                TextInputWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Название',
                    controller: _textTitleController),
                const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Автомобиль',
                    controller: _textCarController),
                const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextInputWidget(
                              keyboardType: TextInputType.emailAddress,
                              hintText: formattedDate,
                              controller: _data),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: _showDataParcker,
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'Город отправки',
                    controller: _textDepartureController),
                const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'Город прибытия',
                    controller: _textReceiptController),
                const SizedBox(height: 16),
                TextInputWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Описание',
                    controller: _textNotesController,
                    maxLines: 5),
                const SizedBox(height: 24),
                ButtonView(
                    backgroundColor: AppColors.selectionColor,
                    textColor: AppColors.textColorBlack,
                    text: 'Добавить',
                    onPressed: () {
                      if (_textTitleController.text.isNotEmpty &&
                          _textCarController.text.isNotEmpty &&
                          _textNotesController.text.isNotEmpty &&
                          _textDepartureController.text.isNotEmpty &&
                          _textReceiptController.text.isNotEmpty &&
                      _data.text.isNotEmpty) {
                        widget.addAd.call(
                            _textTitleController.text,
                                _textCarController.text,
                                _textNotesController.text,
                                _textDepartureController.text,
                                _textReceiptController.text,
                                _data.text);
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
