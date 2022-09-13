import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core_global/colors/colors.dart';
import '../../../widget/button.dart';

class AdCardWidget extends StatefulWidget{
  final List output;
  final Function(int,int,int) respond;
  const AdCardWidget({super.key, required this.output, required this.respond});

  @override
  _AdCardWidget createState() => _AdCardWidget();
}

class _AdCardWidget extends State<AdCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            child:Column(
              children: [
                Text('55555'),
                Text('55555'),
                Text('55555'),
                Text('55555'),
                Text('55555'),
                Text('55555'),
                Text('55555'),
                Text('55555'),
                ButtonView(text: "Откликтнуться",
                  onPressed: () {
                    widget.respond.call(
                        int.parse(widget.output[0]["idCargo"]),//id этого объявления
                        int.parse(widget.output[0]["idUser"]), // id заказчика этой услуги
                      4 // статус услуги(ожидание ответа)
                         );
                  }
                )
              ],
            ),
          ),
        ));
  }

}