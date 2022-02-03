import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/widgets/add_info.dart';
import 'package:flutter_application_1/widgets/alert.dart';
import 'package:flutter_application_1/widgets/information_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'addAgentbloc/addagent_bloc.dart';

class Addagent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('user:${user.email}');
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 120, 176),
          title: Text('Добавление агентов'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        body: AddBody());
  }
}

class AddBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddAgentBloc>(
        create: (context) => AddAgentBloc(),
        child: BlocListener<AddAgentBloc, AddAgentState>(
          listener: (context, state) {
            if (state is AddAgentFailure) {
                        EdgeAlert.show(context,
                    title: 'Ошибка',
                    gravity: EdgeAlert.BOTTOM,
                    borderColor: Color.fromARGB(255, 221, 27, 53),
                    backgroundColor: Color.fromARGB(255, 248, 159, 181),
                    icon: Icons.priority_high,
                    description: '',
                    duration: 3);
            }
            if (state is AddAgentSuccess) {
              EdgeAlert.show(context,
                  title: 'Успешно добавлено',
                  gravity: EdgeAlert.BOTTOM,
                  borderColor: Color.fromARGB(255, 27, 221, 76),
                  backgroundColor: Color.fromARGB(255, 173, 255, 162),
                  icon: Icons.check,
                  description: '',
                  duration: 3);
            }
          },
          child: BlocBuilder<AddAgentBloc, AddAgentState>(
              builder: (context, state) {
            return Center(
                child: SingleChildScrollView(
                    child: Column(children: [FormSearch()])));
          }),
        ));
  }
}

class FormSearch extends StatelessWidget {
  final TextEditingController _addnameController = TextEditingController();
  final TextEditingController _addINNController = TextEditingController();
  final TextEditingController _addKPPController = TextEditingController();
  final TextEditingController _addnoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var children2 = [
      Input(controller: _addnameController, hintText: "Название Агента"),
      InputNum(controller: _addINNController, hintText: "ИНН"),
      InputNum2(controller: _addKPPController, hintText: "КПП"),
      Inputnote(controller: _addnoteController, hintText: "Юр.Адрес"),
      Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
          child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton.icon(
                icon: Icon(Icons.add_circle_outline),
                splashColor: Color.fromARGB(255, 255, 255, 255),
                highlightColor: Color.fromARGB(255, 255, 120, 176),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                color: Color.fromARGB(255, 255, 120, 176),
                label: Text(
                  'Добавить',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 22),
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_addnameController.text.isEmpty ||
                      _addINNController.text.isEmpty ||
                      _addKPPController.text.isEmpty ||
                      _addnoteController.text.isEmpty) {
                          EdgeAlert.show(context,
                              title: 'Пустые поля',
                              gravity: EdgeAlert.BOTTOM,
                              borderColor: Color.fromARGB(255, 221, 27, 53),
                              backgroundColor: Color.fromARGB(255, 248, 159, 181),
                              icon: Icons.priority_high,
                              description: '',
                              duration: 1);
                
                  } else {
                    print(
                        'name:${_addnameController.text}\n inn ${_addINNController.text}\n kpp ${_addKPPController.text}\n note ${_addnoteController.text}');
                    // _addnameController.clear();//очищение поля
                    BlocProvider.of<AddAgentBloc>(context)..add(AddAgentButtonPressed(
                          name: _addnameController.text,
                          inn: _addINNController.text,
                          kpp: _addKPPController.text,
                          note: _addnoteController.text));
                  }
                },
              )))
    ];
    return Column(
      children: children2,
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
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextField(
        //keyboardType: TextInputType.number, клавиатура цифры
        controller: controller,
        maxLength: 30,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black45),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 1),
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
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: controller,
            maxLength: 100, //макс ввод букв
            maxLines: 10,
            style: TextStyle(fontSize: 20, color: Colors.black),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black45),
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 120, 176), width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 120, 176), width: 1),
              ),
            ),
          ),
        ));
  }
}

class InputNum extends StatelessWidget {
  final controller;
  final hintText;
  InputNum({this.controller, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(
            decimal:
                true), // ввод исключительно цифр, работает не везде, на win да
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: controller,
        maxLength: 10,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black45),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 1),
          ),
        ),
      ),
    );
  }
}

class InputNum2 extends StatelessWidget {
  final controller;
  final hintText;
  InputNum2({this.controller, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(
            decimal:
                true), // ввод исключительно цифр, работает не везде, на win да
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: controller,
        maxLength: 9,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black45),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 1),
          ),
        ),
      ),
    );
  }
}
