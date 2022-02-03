import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/alert.dart';
import 'package:flutter_application_1/widgets/del_info.dart';
import 'package:flutter_application_1/widgets/edit_sverka.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'add_sverka.dart';
import 'listsverkabloc/list_sverka_bloc.dart';
import 'widgets/information_modal.dart';

class OutputSverka extends StatelessWidget{
  final listAgent;
  const OutputSverka({this.listAgent});
  @override
  Widget build(BuildContext context) {
    final Map idp = {'idAgent': listAgent['idAgent']};
    return BlocProvider<ListSverkaBloc>(
      create: (context) =>ListSverkaBloc()..add(Init(idp: idp)), child: 
    OutputSverka1(listAgent: listAgent,));
  }


}

class OutputSverka1 extends StatelessWidget {
  final listAgent;
  const OutputSverka1({this.listAgent});
  @override
  Widget build(BuildContext context) {
    final Map idp = {'idAgent': listAgent['idAgent']};
   return Scaffold(
        backgroundColor:Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 120, 176),
          title: Text('Сверки агента'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          actions: [TextButton(
                 child: const Text('Добавление сверки агента',
                 style: TextStyle(fontWeight:FontWeight.normal,color: Colors.white, fontSize:20),), 
                 onPressed: () { 
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddSwerka(listAgent: listAgent,))).then(
                    (value) {
                      BlocProvider.of<ListSverkaBloc>(context)..add(Init(idp: idp));
                    },
                  );
                 },
            )],
        ),
        body: ListSverkaBody(idp: idp,));
  }
}
class ListSverkaBody extends StatelessWidget {
  final Map idp;
  ListSverkaBody( {required this.idp});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListSverkaBloc, ListSverkaState>(
      listener:  (context, state) {
            if (state is DelSverkaSuccess) {
                        EdgeAlert.show(context,
                    title: 'Успешно удалено',
                    gravity: EdgeAlert.BOTTOM,
                    borderColor: Color.fromARGB(255, 27, 221, 76),
                    backgroundColor: Color.fromARGB(255, 173, 255, 162),
                    icon: Icons.check,
                    description: '',
                    duration: 3);
                    BlocProvider.of<ListSverkaBloc>(context)..add(Init(idp: idp));
            }
            if (state is DelSverkaFailure) {
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
        if (state is ListSverkaInitial) {
          return ListView(
            children: state.listSverka
                .map((listSverka) => ListSverkaRow(listSverka:listSverka,idp:idp))
                .toList(),
          );
        } if (state is ListSverkaFailure) {
          return ModalInformation(title: 'Ошибка', textContent: state.error);
        } else {
          return const Center(child: CircularProgressIndicator());
          
        }
      },
    );
  }
}

class ListSverkaRow extends StatelessWidget {
  final listSverka;
  final idp;
  ListSverkaRow({this.listSverka,this.idp});
  @override
  Widget build(BuildContext context) {
    String id_Sverki = listSverka['id_Sverki'];
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child:InkWell(
           onTap: (){},
          child:Center(
            child: Container(
              child:Card(
               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(24),),
              color: Color.fromARGB(255, 255, 218, 234),
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children:[Column(
                       children: [Container(
                         width: 150,
                         height: 50,
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                             'Строка',
                        style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:14),
                             ),
                             Text(
                        listSverka['id_Sverki'],
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:15),
                             )
                             ],
                         ),
                       )],
                     ),
                     Column(
                       children: [Container(
                         width: 150,
                         height: 50,
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                             'Дата начала',
                        style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:14),
                             ),
                             Text(
                        listSverka['startSv'],
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:15),
                             )
                             ],
                         ),
                       )],
                     ),
                     Column(
                       children: [Container(
                         width: 150,
                         height: 50,
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                             'Дата конца',
                        style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:14),
                             ),
                             Text(
                        listSverka['endSv'],
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:15),
                             )
                             ],
                         ),
                       )],
                     ),
                     Column(
                       children: [Container(
                         width: 200,
                         height: 50,
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                             'Результат сверки',
                        style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:14),
                             ),
                             Text(
                        listSverka['result'],
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:15),
                             )
                             ],
                         ),
                       )],
                     ), 
                     Column(
                       children: [Container(
                         width: 200,
                         height: 50,
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                             'Номер скана сверки',
                        style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:14),
                             ),
                             Text(
                        listSverka['namber'],
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:15),
                             )
                             ],
                         ),
                       )],
                     ),
                      Column(
                       children: [Container(
                         width: 55,
                         height: 56,
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                           children: [ButtonBar(
                           children:<Widget>[
                             IconButton(
                               onPressed: () => BlocProvider.of<ListSverkaBloc>(context)..add(Del(id: id_Sverki)), 
                               icon: const Icon(Icons.delete_forever)
                               )
                           ])],
                         )
                         ),
                       ],
                     ),
                     Column(
                       children: [Container(
                         width: 55,
                         height: 56,
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                           children: [ButtonBar(
                           children:<Widget>[
                             IconButton(
                               onPressed: () { 
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => EditSwerka(listSverka:listSverka)));
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditSwerka(listSverka:listSverka ,))).then(
                    (value) {
                     // BlocProvider.of<ListSverkaBloc>(context)..add(Init(idp: idp));
                      BlocProvider.of<ListSverkaBloc>(context)..add(Init(idp: idp));
                    },
                  );
                 },
                               icon: const Icon(Icons.border_color)
                               )
                           ])],
                         )
                         ),
                       ],
                     ),
                     ],
                     
                  ),
                ],
                ),
                ),
               )
               )
               )
              ),
            
           );            
  }
  
}

