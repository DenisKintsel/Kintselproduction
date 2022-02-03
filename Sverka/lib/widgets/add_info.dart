import 'package:flutter/material.dart';

class AddInformation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        title: const Text('Успешно'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Добавлено'),
           ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Закрыть',
            style: TextStyle(fontWeight:FontWeight.normal,color: Color.fromARGB(255, 255, 120, 176), fontSize:14),),
            onPressed: () {
             Navigator.of(context).pop();
           // Navigator.push(context, AgentList()).then((result) => setState(() {}));
            },
          ),
        ],
      );
    }
  
  }

