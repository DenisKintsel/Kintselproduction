import 'package:flutter/material.dart';
import 'package:flutter_application_1/listagentbloc/list_agent_bloc.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class DelAgentInformation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        title: const Text('Успешно'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Удалено'),
           ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Закрыть',
            style: TextStyle(fontWeight:FontWeight.normal,color: Color.fromARGB(255, 255, 120, 176), fontSize:14),),
            onPressed: () {
             //Navigator.push(context, MaterialPageRoute(builder: (context) => AgentList()));
            },
          ),
        ],
      );
    }
  
  }