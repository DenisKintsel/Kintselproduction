import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_agent.dart';
import 'package:flutter_application_1/add_sverka.dart';
import 'package:flutter_application_1/widgets/alert.dart';
import 'package:flutter_application_1/widgets/del_Agent_info.dart';
import 'package:flutter_application_1/widgets/del_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'listagentbloc/list_agent_bloc.dart';
import 'output_sverka.dart';
import 'widgets/information_modal.dart';

void main() {
  runApp(BlocProvider<ListAgentBloc>(
      create: (context) => ListAgentBloc()..add(Init()), child: AgentList()));
}

class AgentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('RRRRRRRRgggg5');
    return MaterialApp(
        home: Home() 
        );
  }
}

//create new class for "home" property of MaterialApp()
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Агенты'),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 255, 120, 176),
          actions: [
            TextButton(
                child: const Text(
                  'Добавить агента',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addagent())).then(
                    (value) {
                      BlocProvider.of<ListAgentBloc>(context)..add(Init());
                    },
                  );
                })
          ],
        ),
        body: AgentRowBody());
  }
}

 class AgentRowBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListAgentBloc, ListAgentState>(
      listener:  (context, state) {
            if (state is DelAgentSuccess) {
                        EdgeAlert.show(context,
                    title: 'Успешно удалено',
                    gravity: EdgeAlert.BOTTOM,
                    borderColor: Color.fromARGB(255, 27, 221, 76),
                    backgroundColor: Color.fromARGB(255, 173, 255, 162),
                    icon: Icons.check,
                    description: '',
                    duration: 3);
                    BlocProvider.of<ListAgentBloc>(context)..add(Init());
            }
            if (state is DelAgentFailure) {
              EdgeAlert.show(context,
                  title: 'Ошибка',
                  gravity: EdgeAlert.BOTTOM,
                  borderColor: Color.fromARGB(255, 221, 27, 53),
                  backgroundColor: Color.fromARGB(255, 248, 159, 181),
                  icon: Icons.priority_high,
                  description: '',
                  duration: 3);
            }
          },
      builder: (context, state) {
        if (state is ListAgentInitial) {
          return ListView(
            children: state.listAgent
                .map((listAgent) => AgentRow(listAgent: listAgent))
                .toList(),
          );
        } if (state is ListAgentFailure) {
          return ModalInformation(title: 'Ошибка', textContent: state.error);
        } else {
          return const Center(child: CircularProgressIndicator());
          
        }
      },
    );
  }
}

class AgentRow extends StatelessWidget {
  final listAgent;
  AgentRow({this.listAgent});
  @override
  Widget build(BuildContext context) {
    String idAgent = listAgent['idAgent'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
          onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OutputSverka(listAgent: listAgent,))).then(
                    (value) {
                      BlocProvider.of<ListAgentBloc>(context)..add(Init());
                    },
                  );
                },
          child: Center(
              child: Container(
                  child: Card(
            //elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: const Color.fromARGB(255, 255, 218, 234),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 150,
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Строка',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                Text(
                                  listAgent['idAgent'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 250,
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Агент',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                Text(
                                  listAgent['nameAgent'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              width: 55,
                              height: 56,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ButtonBar(children: <Widget>[
                                    IconButton(
                                        onPressed: () =>
                                            BlocProvider.of<ListAgentBloc>(context)..add(DelAgent(id: idAgent)),
                                        icon: const Icon(Icons.delete_forever))
                                  ])
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )))),
    );
  }
}
