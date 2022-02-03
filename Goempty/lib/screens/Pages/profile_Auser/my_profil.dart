import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/screens/Pages/cargo_page/comments.dart';
import 'package:flutterapp2/screens/Pages/cargo_page/output_comments.dart';
import 'package:flutterapp2/screens/Pages/cargo_page/prof_advertisement/prof_ad_bloc.dart';
import 'package:flutterapp2/screens/Pages/cargo_page/profil_cargo.dart';
import 'package:flutterapp2/screens/Pages/profile_au_bloc/profile_au_bloc.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

import 'my_prof_AD_bloc/my_prof_ad_bloc.dart';
import 'my_profil_bloc/my_profil_bloc.dart';

class MyProfil extends StatelessWidget{
  static const String routeName = '/MyProfil';
  final User user;
  MyProfil({this.user});
  @override
Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
      title: Text('ЕдуПустой'),
      ),
      resizeToAvoidBottomInset: false,
        body: Body(user: user)
        );
  }
  }

  class Body extends StatelessWidget{
  final User user;
  Body({this.user});
  @override
  Widget build(BuildContext context) {
    Map idAS = user.id as Map;
    print(idAS);
    return  Center(
      child : Column(
        children: [Column(
          children:[Zag(user:user)]
        ),
        Column(
          children: [SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.52,
              child: ListView(
                 scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
                children:[ProfAD(user: user)]
              ),
            ),
          )]
        )
        ]
      )
      );
  }
}

  class Zag extends StatelessWidget {
  final User user;
 //final Map  idAS;
  Zag({this.user});
@override
  Widget build(BuildContext context) {
   final Map idMy = {'id': user.id.toString().trim()};
    return BlocProvider<MyProfilBloc>(
      create: (context) => MyProfilBloc()..add(Initt(idMy: idMy)),
      child: BlocBuilder<MyProfilBloc, MyProfilState>(
        builder: (context, state) {
          if (state is MyProfilInitial) {
            print(state.myinf);
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
               children: state.myinf
                    .map((myinf) => PhoteStar(myinf:myinf,idMy:idMy))
                    .toList()
            );
          } else if (state is MyProfilFailure) {
            return ModalInformation(title: 'Ошибка', textContent: state.error);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


class PhoteStar extends StatelessWidget{
  final User user;
  final  myinf;
  final Map idMy;
  PhoteStar({this.myinf,this.idMy,this.user});
  @override
 Widget build(BuildContext context) {;
   String iduserA= myinf['id'];
   String rait = myinf['rait'];
   double rait1;
   rait1 =double.parse(rait);
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
   child:Column(
     children: [Row(
     children: [
       Column(
         children: [
           Image.asset("images/no_foto.jpg",width: 100, height: 100)
         ],
       ),
       SizedBox(
        width: 30,
        ),
       
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row( 
             children: [
               Text(
                'name'
                 //userA['username']
               )
             ],
           ),
           SizedBox(
        height: 5,
        ),
        Row(
          children: [
            Text(
              'Дата регистрации:'
            ),
            Text(
              'date'
             // userA['dataUS']
            )
          ],
          ),
          SizedBox(
        height: 10,
        ),
           Row(
             children: [
               RatingBar.builder(
                                initialRating: rait1,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemSize: 15.0,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                   
                                },
                              )
             ],
           ),
           Row(
             children: [
               Column(
                 children: [
                   Row(
                     children: [
                       TextButton(
                         onPressed: (){
                        /*   final Map searchid = {'id': iduserA };
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context) => OutputComments(searchid:searchid)));*/},
                          child: Text("Просмотреть отзывы") 
                          )
                     ],
                   )   
                 ],
               ),
               
             ],
           ),
         ],
       )
     
     ]
     ),
     Row(
      children: [
        
               Text("Email: "),
               Text('rtng@gmail.com')
      ],
     ),
     
     Pas(myinf: myinf,),
     SizedBox(
        height:20,
        ),
        Container(
          color:Theme.of(context).primaryColor,
          height: 40,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                        'Размещенные объявления'
                          ),
             ] ),      
     )
    
     ]),
   );
  }

 }

 class Pas extends StatefulWidget{
   final  myinf;
 Pas({this.myinf});
  @override
  State<Pas> createState() => Password(myinf: myinf);
}
 
class Password extends State<Pas> {
  final  myinf;
 Password({this.myinf});
  bool a = true;
  String mText = "Показать пароль";
  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Скрыть пароль";
      } else {
        a = true;
        mText = "Показать пароль";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(),
            child:Column(children: [
             Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new TextButton(
                onPressed: _visibilitymethod, child: new Text(mText),)]),
                Row(
                  children:[
                a != true ? new Text(
                myinf['password']
              ) : new Container(),]),
            ],
          )
      );
          
  }
  }





class ProfAD extends StatelessWidget {
  final User user;
 final Map idAS;
  ProfAD({this.idAS,this.user});
@override
  Widget build(BuildContext context) {
    return BlocProvider<MyProfAdBloc>(
      create: (context) => MyProfAdBloc()..add(MyProfAdInit(idAS: idAS)),
      child: BlocBuilder<MyProfAdBloc, MyProfAdState>(
        builder: (context, state) {
          if (state is MyProfAdInitial) {
            print(state.prof);
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
               children: state.prof
                    .map((prof) => Prof(prof:prof,user:user))
                    .toList()
            );
          } else if (state is MyProfAdFailure) {
            return ModalInformation(title: 'Ошибка', textContent: state.error);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Prof extends StatelessWidget{
  final User user;
  final prof;
  Prof({this.prof,this.user});
  @override
  Widget build(BuildContext context) {
   // Driver(prof:prof);
   /* String rait = prof['rait'];
   double rait1;
   rait1 =double.parse(rait);*/
    return Container(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal:15, vertical: 10),   
        child:InkWell(
        /*  onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilCargo(cargo: prof,user: user)));},*/
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
                       'Груз'
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
                           'Саратов'
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
                             'Москва'
                           )
                              ],
                            )
                         ],
                       )
                       ),
                       Column(
                         children: [
                           Text(
                            ''
                           ),
                           SizedBox(
                             height: 30,
                            ),
                           Text(
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
                                initialRating: 4,
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
                            '500'
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
            
           )
     
      );
  }

}
  