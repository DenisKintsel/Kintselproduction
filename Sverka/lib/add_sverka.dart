import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/add_info.dart';
import 'package:flutter_application_1/widgets/alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'addSverkabloc/addsverka_bloc.dart';
import 'output_sverka.dart';
import 'widgets/information_modal.dart';

const TYPE_NUMBER = "number";

class AddSwerka extends StatelessWidget {
  final listAgent;
  AddSwerka({this.listAgent});
  @override
  Widget build(BuildContext context) {
    // print('user:${user.email}');
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 120, 176),
          title: Text('Добавление сверки'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        body: AddBody(
          listAgent: listAgent,
        ));
  }
}

/*class Body extends StatelessWidget {
  final listAgent;
  Body({this.listAgent});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(children: [
      TextAgent(
        listAgent: listAgent,
      )
    ])));
  }
}*/

/*class AddBody extends StatelessWidget {
 final listAgent;
  AddBody({this.listAgent});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSverkaBloc>(
      create: (context) => AddSverkaBloc(),
      child: BlocBuilder<AddSverkaBloc, AddSverkaState>(
        builder: (context, state) {
          if (state is AddSverkaSuccess) {
            EdgeAlert.show(context,
                    title: 'Ошибка',
                    gravity: EdgeAlert.BOTTOM,
                    borderColor: Color.fromARGB(255, 221, 27, 53),
                    backgroundColor: Color.fromARGB(255, 248, 159, 181),
                    icon: Icons.safety_divider,
                    description: '',
                    duration: 3);
          } if (state is AddSverkaFailure) {
            return ModalInformation(title: 'Ошибка', textContent: state.error);
          }
         },
           child: BlocBuilder<AddSverkaBloc, AddSverkaState>(
              builder: (context, state) {
            return Center(
        child: SingleChildScrollView(
          child: Column(children: [TextAgent(listAgent: listAgent)])));
              })
        
      ),
    );
  }
}*/

class AddBody extends StatelessWidget {
  final listAgent;
  AddBody({this.listAgent});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSverkaBloc>(
        create: (context) => AddSverkaBloc(),
        child: BlocListener<AddSverkaBloc, AddSverkaState>(
          listener: (context, state) {
            if (state is AddSverkaFailure) {
                        EdgeAlert.show(context,
                    title: 'Ошибка',
                    gravity: EdgeAlert.BOTTOM,
                    borderColor: Color.fromARGB(255, 221, 27, 53),
                    backgroundColor: Color.fromARGB(255, 248, 159, 181),
                    icon: Icons.safety_divider,
                    description: '',
                    duration: 3);
            }
            if (state is AddSverkaSuccess) {
              EdgeAlert.show(context,
                  title: 'Успешно добавлено',
                  gravity: EdgeAlert.BOTTOM,
                  borderColor: Color.fromARGB(255, 27, 221, 76),
                  backgroundColor: Color.fromARGB(255, 173, 255, 162),
                  icon: Icons.safety_divider,
                  description: '',
                  duration: 3);
            }
          },
          child: BlocBuilder<AddSverkaBloc, AddSverkaState>(
              builder: (context, state) {
            return Center(
                child: SingleChildScrollView(
                    child: Column(children: [TextAgent(listAgent: listAgent)])));
          }),
        ));
  }
}





class TextAgent extends StatefulWidget {
  final listAgent;
  TextAgent({this.listAgent});
  @override
  _TextAgentState createState() => _TextAgentState(listAgent: listAgent);
}
enum SingingCharacter { svereno, nosvereno }
class _TextAgentState extends State<TextAgent> {
  final listAgent;
  _TextAgentState({this.listAgent});
  List<String> _checked = []; //["A", "B"];
  var maskedText = new MaskedTextController(mask: '00/00/0000');
  var maskedText2 = new MaskedTextController(mask: '00/00/0000');
  final TextEditingController _note = TextEditingController();
  var _namberSVController = new MaskedTextController(mask: '№00000000');
  String svok = 'Сверено';
  String svoff = 'Сверено с расхождениями';
  SingingCharacter? _character = SingingCharacter.svereno;
  String sv = 'Сверено';
 @override
  Widget build(BuildContext context) {
    String id = listAgent['idAgent'];
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 95, vertical: 10),
        child: Center(
            child: Container(
                child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          color: Color.fromARGB(255, 255, 218, 234),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Добавление сверки контрагента ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Название контрагента: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          listAgent['nameAgent'],
                          // '${cargo['Adata'].day.toString().padLeft(2, '0')}-${cargo['Adata'].month.toString().padLeft(2, '0')}-${cargo['Adata'].year.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'ИНН: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          listAgent['inn'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'КПП: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          listAgent['kpp'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Юридический адрес: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          listAgent['address'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [
                      Row(
                        children: [
                          Text(
                            'Период сверки: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Text(
                            ' с',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Input(
                              controller: maskedText,
                              hintText: "Начало",
                              type: TYPE_NUMBER),
                          Text(
                            'по',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Input(
                              controller: maskedText2,
                              hintText: "Конец",
                              type: TYPE_NUMBER),
                        ],
                      )
                    ])),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
      children: <Widget>[
        ListTile(
          isThreeLine: false,
          title: const Text('Сверено'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.svereno,
            groupValue: _character,
            activeColor:Color.fromARGB(255, 255, 120, 176),
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                sv = svok;
                print(sv);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Сверено с расхождениями'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.nosvereno,
            activeColor:Color.fromARGB(255, 255, 120, 176),
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                sv = svoff;
                print(sv);
                              });
            },
          ),
        ),
      ],
    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Column(
                    children: [
                      Input2(
                        controller: _namberSVController,
                        hintText: "№ сверки",
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.assignment_late, size: 20),
                    Text(
                      'Примечания:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    )
                  ],
                ),
                            Input3(
                              controller: _note,
                              hintText: "Примечания",
                              ),
                Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      // width:  MediaQuery.of(context).size.width,
                      child: RaisedButton.icon(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: ()  {
                          FocusScope.of(context).unfocus();
                    if (maskedText.text.isEmpty ||
                        maskedText2.text.isEmpty ||
                        _namberSVController.text.isEmpty) {
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
                           'name:${maskedText.text}\n inn ${maskedText2.text}\n kpp ${_note.text}\n note ${_namberSVController.text}\n note ${sv.toString()}');
                      BlocProvider.of<AddSverkaBloc>(context)
                      ..add(AddSverkaButtonPressed(
                            datego: maskedText.text,
                            datefinish: maskedText2.text,
                            namber: _namberSVController.text,
                            note: _note.text,
                            res: sv.toString(),
                            id: id.toString()
                           ));
                           maskedText.clear();
                           maskedText2.clear();
                           _namberSVController.clear();
                           _note.clear();
                    }
                 
                        },
                        splashColor: Color.fromARGB(255, 255, 255, 255),
                        highlightColor: Color.fromARGB(255, 255, 120, 176),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          // side: BorderSide(color: Colors.black, width: 3),
                        ),
                        color: Color.fromARGB(255, 255, 120, 176),
                        label: Text(
                          'Добавить сверку',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ))));
  }
}

class Input extends StatelessWidget {
  final controller;
  final hintText;
  final type;
  Input({this.controller, this.hintText, this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 23,
        width: 130,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 1),
          child: TextField(
            keyboardType:
                type == TYPE_NUMBER ? TextInputType.number : TextInputType.text,
            controller: controller,
            // maxLength: type == TYPE_NOTE ? 100 : 30,
            // maxLines: type == TYPE_NOTE ? 10 : null,
            style: TextStyle(fontSize: 15, color: Colors.black),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black45),
              hintText: hintText,
            ),
          ),
        ));
  }
}

class Input2 extends StatelessWidget {
  final controller;
  final hintText;
  Input2({this.controller, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        //keyboardType: TextInputType.number, клавиатура цифры
        controller: controller,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black45),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 120, 176)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 1),
          ),
        ),
      ),
    );
  }
}

class Input3 extends StatelessWidget {
  final controller;
  final hintText;
  Input3({this.controller, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Color.fromARGB(255, 255, 223, 236),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:  TextField(
        controller: controller,
        maxLength: 200,//макс ввод букв
        maxLines: 5,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black45),
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 3),
            ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 255, 120, 176), width: 1),
            ),
        ),
         ),
            )));
  }
}
