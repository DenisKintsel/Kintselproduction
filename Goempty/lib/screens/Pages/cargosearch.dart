import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/screens/Pages/listcargo.dart';

class Cargosearch extends StatelessWidget {
static const String routeName = '/Pgryz';
final User user;
Cargosearch({this.user});
@override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
      title: Text('ЕдуПустой'),
      ),
      resizeToAvoidBottomInset: false,
        body: Body(user:user)
        );
  }
}

class Body extends StatelessWidget {
  final User user;
Body({this.user});
@override
Widget build(BuildContext context) {
return Column(
children: [Logo(), FormSearch(user:user)],
    );
  }
}

class Logo extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 200),
    child: Container(
    child: Align(
    child: Text('Найти груз',
    style: TextStyle(
      fontSize: 40,
        fontWeight: FontWeight.bold,
          color: Colors.black)),
      ),
    ),
  );
}
}

class FormSearch extends StatelessWidget {
final User user;
FormSearch({this.user});
final TextEditingController _cityController = TextEditingController();
final TextEditingController _city2Controller = TextEditingController();

@override
Widget build(BuildContext context) {
  return Column(children: [
    Input(controller: _cityController, hintText: "Город отправления"),
    Input(controller: _city2Controller, hintText: "Город прибытия"),
     Padding(
       padding: EdgeInsets.only(left: 20,right: 20,top: 30),
        child: Container(
              height: 70,
              width:  MediaQuery.of(context).size.width,
        child: RaisedButton(
        splashColor: Colors.black,
        highlightColor: Color.fromRGBO(17, 177, 85, 1),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: Colors.black, width: 3),
          ),
        color: Color.fromRGBO(17, 177, 85, 1),
        child: Text('Найти',
          style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
              ),
            onPressed: () {
            final Map searchG = {'startCity': _cityController.text.trim(),'endCity': _city2Controller.text.trim()
              };
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListCargo(searchG: searchG,user:user)));
              },)
          
          )
        )
      ],
      );
      }
}

class Input extends StatelessWidget {
final controller;
final hintText;
  Input({this.controller, this.hintText});
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 30),
          child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1),
            ),
        ),
          ),
          );
  }
}

