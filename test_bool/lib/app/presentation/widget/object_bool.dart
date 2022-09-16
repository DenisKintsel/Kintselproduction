import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../core_global/colors/colors.dart';

class ObjectBoolWidget extends StatefulWidget {
  final ValueChanged onSwitch;
  int status;
  int check;
  final int title;
  int radio;
  final ValueChanged onRadio;
  final ValueChanged onCheckbox;

  ObjectBoolWidget(
      {Key? key,
      required this.title,
      required this.onSwitch,
      required this.status,
      required this.onRadio,
      required this.onCheckbox,
      required this.check,
      required this.radio})
      : super(key: key);

  @override
  _ObjectBoolWidget createState() => _ObjectBoolWidget();
}

class _ObjectBoolWidget extends State<ObjectBoolWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimary,
      child: Column(
        children: [
          Container(
            color: AppColors.backgroundCard,
            height: 54,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Object name",
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "ID:${widget.title}",
                    style: const TextStyle(color: AppColors.textColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Text(
                  "Switch name",
                  style: TextStyle(color: AppColors.textColor),
                ),
                const SizedBox(width: 8),
                Center(
                  child: FlutterSwitch(
                    width: 24.0,
                    height: 14.0,
                    toggleSize: 10.0,
                    value: widget.status == 1 ? true : false,
                    borderRadius: 30.0,
                    padding: 2.0,
                    toggleColor: AppColors.backgroundPrimary,
                    activeColor: AppColors.selectionColor,
                    inactiveColor: Colors.black12,
                    onToggle: (value) {
                      setState(() {
                        if (value == true) {
                          widget.status = 1;
                          widget.onSwitch(widget.status);
                        } else {
                          widget.status = 0;
                          widget.onSwitch(widget.status);
                        }
                        //  print(status);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: widget.radio,
                  onChanged: (T) {
                    setState(() {
                      widget.radio = 1;
                      widget.onRadio(widget.radio);
                    });
                  },
                ),
                const Text("Radio 1"),
                Radio(
                  value: 2,
                  groupValue: widget.radio,
                  onChanged: (T) {
                    setState(() {
                      widget.radio = 2;
                      widget.onRadio(widget.radio);
                    });
                  },
                ),
                const Text("Radio 2")
              ],
            ),
          ),
          const SizedBox(height: 22),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                children: [
                  Checkbox(
                      value: widget.check == 1 ? true : false,
                      activeColor: AppColors.selectionColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            widget.check = 1;
                            widget.onCheckbox(widget.check);
                          } else {
                            widget.check = 0;
                            widget.onCheckbox(widget.check);
                          }
                        });
                      }),
                  const Text("CheckBox")
                ],
              )),
          const SizedBox(height: 14)
        ],
      ),
    );
  }
}
