

import 'package:flutter/material.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/screens/Pages/profile_Auser/profile_au.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';

class ProfilCargo extends StatelessWidget {
  final User user;
   final  cargo;
  ProfilCargo({this.cargo,this.user});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
     return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text('ЕдуПустой'),
      ),
      body: Center(
        child: TextCity(cargo:cargo,user: user),
      ),
      
    );

    
  }
}


class TextCity extends StatelessWidget{
  final User user;
  final cargo;
TextCity({this.cargo,this.user});
  @override
  Widget build(BuildContext context) {
    String idA = cargo['id_user'];
       return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child:Center(
            child: Container(
              child:Card(
                elevation: 12,
               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(24),),
              color: Colors.white54,
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric( vertical: 5),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cargo['pynktA'],
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:20),
                      ),
                      Text(
                        ' - ',
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:20),
                      ),
                      Text(
                        cargo['pynktB'],
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:20),
                      )
                    ],
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric( vertical: 5),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Дата размещения: ',
                        style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                      ),
                      Text(
                        cargo['Adata'],
                       // '${cargo['Adata'].day.toString().padLeft(2, '0')}-${cargo['Adata'].month.toString().padLeft(2, '0')}-${cargo['Adata'].year.toString()}',
                        style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                      )
                         ],
                       )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric( vertical: 10) ,
                       child: Row(
                         children: [
                           Text(
                             'Груз: ',
                             style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                           ),
                           Text(
                             cargo['vid'],
                             style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                           )
                         ],
                         )
                  ),
                  Padding(
                    padding:const EdgeInsets.symmetric( vertical: 10),
                       child:Row(
                         children: [
                           Text(
                             'Телефон: ',
                             style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                           ),
                           Text(
                             cargo['phone'],
                             style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                           )
                         ],
                       )
                  ),
                  Padding(
                    padding:const EdgeInsets.symmetric( vertical: 10),
                        child: Row(
                           children: [
                             Text(
                               'Имя: ',
                               style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                             ),
                             Text(
                               cargo['username'],
                               style: TextStyle(fontWeight:FontWeight.w400,color: Colors.black, fontSize:12),
                             )
                           ],
                         )
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.assignment_late,
                        size:20
                      ),
                      Text(
                        'Примечания:',
                        style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:20),
                      )
                  ],
                  ),
                  Padding(padding:const EdgeInsets.symmetric( vertical: 10),
                      child:Container(
                        height: 150,
                        width:MediaQuery.of(context).size.width,
                         child:Card(
                           elevation: 12,
                           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(24),),
                           color: Colors.white38,
                           child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Text(
                                cargo['note'],
                                textAlign: TextAlign.left,
                                softWrap: true,
                                //maxLines: 9,
                                //overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                         ))
                       
                
                
              )
                  ),
                  Column(
                    children: [
                      Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 30, bottom: 30),
                    child:  Container(
                         height: 70,
                         width:MediaQuery.of(context).size.width,
                        // width:  MediaQuery.of(context).size.width,
                          child: RaisedButton.icon(
                            icon: Icon(
                             Icons.phone
                            ),
                            onPressed: ()async{   
                              print('${cargo['phone']}');
                               final url = 'tel:${cargo['phone']}';   
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }   
                            }, 
                            splashColor: Colors.black,
                            highlightColor: Color.fromRGBO(17, 177, 85, 1),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                           // side: BorderSide(color: Colors.black, width: 3),
                              ),
                            color: Color.fromRGBO(17, 177, 85, 1),
                            label: Text('Позвонить',
                            style: TextStyle(
                              color: Colors.black, fontSize: 22),
              ),
              ),
                            ),
                          ),
                     ]
                      ),
                      Column(
                    children: [
                      Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 30, bottom: 30),
                    child:  Container(
                         height: 70,
                         width:MediaQuery.of(context).size.width,
                        // width:  MediaQuery.of(context).size.width,
                          child: RaisedButton.icon(
                            icon: Icon(
                             Icons.account_box
                            ),
                            onPressed: () {
                              final Map idAS = {'id': idA.toString().trim()};
              
                              print('${idA.toString()}');
                               Navigator.push(context,
                               MaterialPageRoute(builder: (context) => ProfileAu(idAS: idAS,user:user)));
                            }, 
                            splashColor: Colors.black,
                            highlightColor: Color.fromRGBO(17, 177, 85, 1),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                           // side: BorderSide(color: Color.fromRGBO(17, 177, 85, 1), width: 3),
                              ),
                            color: Color.fromRGBO(17, 177, 85, 1),
                            label: Text('Перейти в профиль',
                            style: TextStyle(
                              color: Colors.black, fontSize: 22),
              ),
              ),
                            ),
                          ),
                     ]
                      )
                    ],
                  )
                  , 
               ),
              ) 
              )
              )  
              );
               
             
            
                 
  }

}
