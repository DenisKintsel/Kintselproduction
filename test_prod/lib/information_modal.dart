import 'package:flutter/material.dart';

class ModalInformation extends StatelessWidget {
  final String textContent;
  final String title;

  ModalInformation({required this.textContent, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          height: 220,
          width: 220,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
              ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        textContent,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: Text(
                     "Закрыть",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight:FontWeight.normal,color: Color.fromARGB(255, 255, 120, 176), fontSize:15),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
