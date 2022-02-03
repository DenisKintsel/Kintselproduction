import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/screens/Pages/adddriverbloc/adddriver_bloc.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

const TYPE_NUMBER = "number";
const TYPE_NOTE = "note";

class Adddriver extends StatelessWidget {
  static const String routeName = '/Adddriver';
  final User user;
  Adddriver({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('ЕдуПустой'),
        ),
        body: Body(user: user));
  }
}

class Body extends StatelessWidget {
  final User user;
  Body({this.user});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(
      children: [Logo(), FormSearch(user: user)],
    )));
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Container(
        child: Align(
          child: Text('Добавить водителя',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ),
    );
  }
}

class FormSearch extends StatefulWidget {
  final User user;
  FormSearch({this.user});
  @override
  _FormSearchState createState() => _FormSearchState(user: user);
}

class _FormSearchState extends State<FormSearch> {
  final User user;
  _FormSearchState({this.user});
  DateTime nowDate = DateTime.now(); // сегодняшняя дата
  DateTime startDate = DateTime.now(); // дата выезда

  var maskedText =
      new MaskedTextController(mask: '+7-000-000-00-00', text: '+7');

  final TextEditingController _addCityStartController =
      TextEditingController(); //Начальная точка пути
  final TextEditingController _addCityEndController =
      TextEditingController(); // Конечная точка пути
  final TextEditingController _carController =
      TextEditingController(); // Категория автомобиля
  final TextEditingController _priceController =
      TextEditingController(); // Цена за перевозку
  final TextEditingController _noteController =
      TextEditingController(); // Примечание

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(
            controller: _addCityStartController, hintText: "Город отправления"),
        Input(controller: _addCityEndController, hintText: "Город прибытия"),
        Input(controller: _carController, hintText: "Категория автомобиля"),
        Input(
            controller: _priceController,
            hintText: "Цена за перевозку",
            type: TYPE_NUMBER),
        Input(controller: maskedText, hintText: "Телефон", type: TYPE_NUMBER),
        Input(
            controller: _noteController,
            hintText: "Примечание",
            type: TYPE_NOTE),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "${startDate.day.toString().padLeft(2, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.year.toString()}",
                  style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
              
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  splashColor: Colors.black,
                  highlightColor: Color.fromRGBO(17, 177, 85, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide(color: Colors.black, width: 3),
                  ),
                  color: Color.fromRGBO(17, 177, 85, 1),
                  child: Text(
                    'Добавить',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 22),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_addCityStartController.text.isEmpty ||
                        _addCityEndController.text.isEmpty ||
                        _carController.text.isEmpty ||
                        _priceController.text.isEmpty ||
                        maskedText.text.isEmpty ||
                        _noteController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ModalInformation(
                                title: "Ошибка", textContent: "Пустые поля");
                          });
                    } else {
                      print(
                          'sity1:${_addCityStartController.text}\n city2 ${_addCityEndController.text}\n cargo ${_carController.text}\n price ${_priceController.text}\n phone ${maskedText.text}\n note ${_noteController.text}\n data ${startDate.toString()} ');
                      AddDriverBloc()
                        ..add(AddDriverButtonPressed(
                            city1: _addCityStartController.text,
                            city2: _addCityEndController.text,
                            car: _carController.text,
                            price: _priceController.text,
                            phone: maskedText.text,
                            note: _noteController.text,
                            data: startDate.toString(),
                            id: user.id));
                    }
                  },
                )))
      ],
    );
  }

}

class Input extends StatelessWidget {
  final controller;
  final hintText;
  final type;
  Input({this.controller, this.hintText, this.type});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextField(
        keyboardType:
            type == TYPE_NUMBER ? TextInputType.number : TextInputType.text,
        controller: controller,
        maxLength: type == TYPE_NOTE ? 100 : 30,
        maxLines: type == TYPE_NOTE ? 10 : null,
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
