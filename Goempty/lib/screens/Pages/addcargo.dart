import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/screens/Pages/addcargobloc/addcargo_bloc.dart';
import 'package:flutterapp2/widgets/information_modal.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:sqflite/sqflite.dart';


class Addcargo extends StatelessWidget{
  static const String routeName = '/Addcargo';
  final User user;
  Addcargo({this.user});
  @override
  Widget build(BuildContext context) {
   // print('user:${user.email}');
    return  Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(title: Text('ЕдуПустой'),),
        body: Body(user:user)
         );
  }


}

class Body extends StatelessWidget{
  final User user;
  Body({this.user});
  @override
  Widget build(BuildContext context) {
    return  Center(
      child : SingleChildScrollView(
      child: Column(
      children:[Logo(),FormSearch(user:user)]
      )
      )
    );
  }
}

class Logo extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 50),
    child: Container(
    child: Align(
    child: Text('Добавить груз',
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
 var controller = new MaskedTextController(mask: '+7-000-000-00-00',text: '+7');

  AddCargoBloc _addCargoBloc;

final TextEditingController _addcityController = TextEditingController();
  final TextEditingController _addcity2Controller = TextEditingController();
  final TextEditingController _addcargoController = TextEditingController();
  final TextEditingController _addpriceController = TextEditingController();
  final TextEditingController _addnoteController = TextEditingController();
@override
Widget build(BuildContext context) {
  var children2 = [
    Input(controller: _addcityController, hintText: "Город отправления"),
    Input(controller: _addcity2Controller, hintText: "Город прибытия"),
    Input(controller: _addcargoController, hintText: "Что за груз"),
    InputNum(controller: _addpriceController, hintText: "Цена за перевозку"),
    InputNum(controller: controller, hintText: "Телефон"),
    Inputnote( controller: _addnoteController, hintText:  "Примечание"),
   Padding(
       padding: EdgeInsets.only(left: 20,right: 20,top: 30, bottom: 30),
        child: Container(
              height: 70,
              width:  MediaQuery.of(context).size.width,
        child:RaisedButton(
        splashColor: Colors.black,
        highlightColor: Color.fromRGBO(17, 177, 85, 1),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: Colors.black, width: 3),
          ),
        color: Color.fromRGBO(17, 177, 85, 1),
        child: Text('Добавить',
          style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
              ),
            onPressed: () {
              FocusScope.of(context).unfocus();
    if (_addcityController.text.isEmpty || _addcity2Controller.text.isEmpty || _addcargoController.text.isEmpty  || _addpriceController.text.isEmpty || controller.text.isEmpty || _addnoteController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return ModalInformation(title: "Ошибка", textContent: "Пустые поля");
          });
    } else { 
          {
             print('sity1: ${_addcityController.text}\n city2 ${_addcity2Controller.text}\n cargo ${_addcargoController.text}\n price ${_addpriceController.text}\n phone ${controller.text}\n note ${_addnoteController.text}  ');
            AddCargoBloc()..add(AddCargoButtonPressed(
              city1: _addcityController.text,
              city2: _addcity2Controller.text,
              cargo: _addcargoController.text,
              price: _addpriceController.text,
              phone: controller.text,
              note: _addnoteController.text,
              id: user.id
               )
               );
          }
      }
    }  ,)
          
          )
        )
      ];
  return Column(children: children2,
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
        //keyboardType: TextInputType.number, клавиатура цифры
        controller: controller,
         maxLength: 30,
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

class Inputnote extends StatelessWidget {
final controller;
final hintText;
  Inputnote({this.controller, this.hintText});
    @override
    Widget build(BuildContext context) {
      return  Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 30),
        child:Container(
              height: 150,
              width:  MediaQuery.of(context).size.width,
           child: TextField(
        controller: controller,
        maxLength: 100,//макс ввод букв
        maxLines: 10,
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
      )
      );
        
  }
}


class InputNum extends StatelessWidget {
final controller;
final hintText;
  InputNum({this.controller, this.hintText});
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 30),
            child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
         maxLength: 30,
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
