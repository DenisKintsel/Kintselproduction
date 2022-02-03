import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

import 'cargo_page/profil_cargo.dart';
import 'listcargo/cargo_bloc.dart';

class ListCargo extends StatelessWidget {
  final User user;
  final Map searchG;
  ListCargo({this.searchG,this.user});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Объявления'),
      ),
      body: ListCargoBody(searchG: searchG,user:user),
    );
  }
}

class ListCargoBody extends StatelessWidget {
  final User user;
  final Map searchG;
  ListCargoBody({this.searchG,this.user});

  @override
  Widget build(BuildContext context) {
    print(searchG);
    return BlocProvider<CargoBloc>(
      create: (context) => CargoBloc()..add(Init(searchG: searchG)),
      child: BlocBuilder<CargoBloc, CargoState>(
        builder: (context, state) {
          if (state is CargoInitial) {
            print(state.cargo);
            return ListView(
              
               children: state.cargo
                    .map((cargo) => CargoRow(cargo:cargo,user: user))
                    .toList()
            );
          } else if (state is CargoFailure) {
            return ModalInformation(title: 'Ошибка', textContent: state.error);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CargoRow extends StatelessWidget {
  final User user;
  final  cargo;
  CargoRow({this.cargo,this.user});
  @override
  Widget build(BuildContext context) {
    String rait = cargo['rait'];
   double rait1;
   rait1 =double.parse(rait);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child:InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilCargo(cargo: cargo,user:user)));},
          child:Center(
            child: Container(
              child:Card(
                elevation: 12,
               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(24),),
              color: Colors.white54,
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Вид груза',
                        style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:14),
                      ),
                      Text(
                        cargo['vid']
                      ),
                      Text(
                        'Рейтинг'
                      )
                    ],
                  ),
                  Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                       Column(
                         children: [
                           Text(
                            'Откуда:    '
                           ),
                           SizedBox(
                             height: 30,
                            ),
                           Text(
                             'Куда:    '
                           )
                         ],
                       ),
                       Padding(
                       padding: EdgeInsets.only(left: 35),
                       child: Column(
                       
                         children: [Row(
                           children: [
                             Image(
                             image:AssetImage("./images/circle.png"),width:15,height:15
                           ),
                           SizedBox(
                             width: 2,
                            ),
                           Text(
                             cargo['pynktA']
                           )
                           ],
                         ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Image(
                             image:AssetImage("./images/tchk.png"),width:30,height:30
                           ),
                             ],
                             ),
                            Row(
                              children: [
                                Image(
                             image:AssetImage("./images/circle2.png"),width:15,height:15
                           ),
                           SizedBox(
                             width: 2,
                            ),
                           Text(
                             cargo['pynktB']
                           )
                              ],
                            )
                         ],
                       )
                       ),
                       Column(
                         children: [
                           Text(
                            // cargo['pynktA']
                            ''
                           ),
                           SizedBox(
                             height: 30,
                            ),
                           Text(
                            // cargo['pynktB']
                            ''
                           ),
                           SizedBox(
                             height: 5,
                            )
                         ],
                       ),
                   Column(
                       
                         children: [
                           RatingBar.builder(
                                initialRating: rait1,
                                minRating: 1,
                                direction: Axis.vertical,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 20.0),
                                itemSize: 15.0,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                         ],
                       ),
                       
                    
                    
                    
                    ],
                  ),
                  Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     Padding(
                       padding: EdgeInsets.only(left: 16),
                       child: 
                       Row(
                         children: [
                           Text(
                             cargo['price']
                           ),
                           Text(
                             ' руб.'
                           )
                         ],
                       ),
                     )
                  ],)
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

