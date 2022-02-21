import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_prod/listpage.dart';
import 'package:test_prod/widget/alert.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 72, 50, 170),
        resizeToAvoidBottomInset: false,
        body: LoginBody());
  }
}

class LoginBody extends StatelessWidget {
  final TextEditingController _addloginController = TextEditingController();
  final TextEditingController _addpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var children2 = [
      Input(controller: _addloginController, hintText: "Логин"),
      Formpage(controller: _addpassController, hintText: "Пароль"),
    ];
    return Padding(
        padding: EdgeInsets.only(top: 170),
        child: Container(
          child: Column(children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Авторизация',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ]),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Column(children: children2),
            ),
            Padding(
                padding: EdgeInsets.only(top: 200),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Center(
                            child: ElevatedButton(
                                child: Text(
                                  'ВОЙТИ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_addloginController.text.isEmpty ||
                                      _addpassController.text.isEmpty) {
                                    EdgeAlert.show(context,
                                        title: 'Пустые поля',
                                        gravity: EdgeAlert.BOTTOM,
                                        borderColor:
                                            Color.fromARGB(255, 221, 27, 53),
                                        backgroundColor:
                                            Color.fromARGB(255, 248, 159, 181),
                                        icon: Icons.priority_high,
                                        description: '',
                                        duration: 1);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListPage()));
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 44, 39, 48)),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(265, 75)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                ))))
                  ],
                ))
          ]),
        ));
  }
}

class Input extends StatelessWidget {
  final controller;
  final hintText;
  Input({this.controller, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.white),
              hintText: hintText,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ));
  }
}

class Formpage extends StatefulWidget {
  final controller;
  final hintText;
  Formpage({this.controller, this.hintText});
  @override
  _Formpage createState() =>
      _Formpage(controller: controller, hintText: hintText);
}

class _Formpage extends State<Formpage> {
  final controller;
  final hintText;
  _Formpage({this.controller, this.hintText});
  bool pass = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextField(
        obscureText: pass,
        keyboardType: TextInputType.numberWithOptions(
            decimal:
                true), // ввод исключительно цифр, работает не везде, на win да
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: controller,
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
            hintText: hintText,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            suffixIcon:
                InkWell(onTap: _buttunpass, child: Icon(Icons.visibility))),
      ),
    );
  }

  void _buttunpass() {
    setState(() {
      pass = !pass;
    });
  }
}
