import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

import 'cargo_page/profil_driver.dart';
import 'listdriverbloc/driver_bloc.dart';

class ListDriver extends StatelessWidget{
  final Map searchD;
  final User user;
  ListDriver( {this.searchD,this.user});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text('ЕдуПустой'),),
      body: ListDriverBody(searchD: searchD,user: user),
    );
  }
}

class ListDriverBody extends StatelessWidget{
  final Map searchD;
  final User user;
  ListDriverBody( {this.searchD,this.user});

  @override
  Widget build(BuildContext context) {
    print(searchD);
    return BlocProvider<DriverBloc>(
      create: (context) => DriverBloc()..add(Init(searchD: searchD)),
      child: BlocBuilder<DriverBloc, DriverState>(
        builder: (context, state) {
          if (state is DriverInitial) {
            return ListView(
                children: state.driver
                    .map((driver) => DriverRow(driver:driver,user: user))
                    .toList()
                    );
          } else if (state is DriverFailure) {
            return ModalInformation(
                title: 'Ошибка' , textContent: "Ошибка");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DriverRow extends StatelessWidget {
  final  driver;
  final User user;
  DriverRow({this.driver,this.user});
  @override
  Widget build(BuildContext context) {
    String rait = driver['rait'];
   double rait1;
   rait1 =double.parse(rait);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child:InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilDriver(driver:driver,user:user)));},
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
                        'Транспорт',
                        style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:14),
                      ),
                      Text(
                        driver['car']
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
                             driver['city1']
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
                             driver['city2']
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
                             driver['price']
                           ),
                           Text(
                             ' руб.'
                           )
                         ],
                       ),
                     )
                  ],),
                  SizedBox(
                             height: 5,
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Column(
                      children: [
                        Text(
                          'Дата выезда'
                        ),  
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          driver['data']
                        )
                      ],
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



