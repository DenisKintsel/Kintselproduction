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

class ProfileAu extends StatelessWidget{
  final User user;
  final Map idAS;
  ProfileAu({this.idAS,this.user});
  @override
Widget build(BuildContext context) {
  print(idAS);
  print('Fuck');
    return Scaffold(
    //  backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
      title: Text('ЕдуПустой'),
      ),
      resizeToAvoidBottomInset: false,
        body: Body(idAS:idAS,user:user)
        );
  }
  }

  class Body extends StatelessWidget{
  final User user;
  final Map  idAS;
  Body({this.user,this.idAS});
  @override
  Widget build(BuildContext context) {
    return  Center(
      child : Column(
        children: [Column(
          children:[Zag(idAS:idAS,user:user)]
        ),
        Column(
          children: [SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.58,
              child: ListView(
                 scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
                children:[ProfAD(idAS:idAS,user:user)]
              ),
            ),
          )]
        )
        ]
      )
      );
  }
}
  //children:[Zag(idAS:idAS,user:user),ProfAD(idAS:idAS)]
class Zag extends StatelessWidget {
  final User user;
 final Map  idAS;
  Zag({this.idAS,this.user});
@override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileAuBloc>(
      create: (context) => ProfileAuBloc()..add(Init(idAS: idAS)),
      child: BlocBuilder<ProfileAuBloc, ProfileAuState>(
        builder: (context, state) {
          if (state is ProfileAuInitial) {
            print(state.userA);
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
               children: state.userA
                    .map((userA) => PhoteStar(userA:userA,idAS:idAS,user: user))
                    .toList()
            );
          } else if (state is ProfileAuFailure) {
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
  final  userA;
  final Map idAS;
  PhoteStar({this.userA,this.idAS,this.user});
 //PhoteStar({this.userA,this.idAS});
  @override
 Widget build(BuildContext context) {
   String iduserA= userA['id'];
   String rait = userA['rait'];
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
                 userA['username']
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
              userA['dataUS']
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
                           final Map searchid = {'id': iduserA };
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context) => OutputComments(searchid:searchid)));},
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
        
               TextButton(
                 onPressed: (){Navigator.push(context,
                               MaterialPageRoute(builder: (context) => Comments(iduserA:iduserA,user:user)));},
                 child: Text("Оставить отзыв и оценку"),)
      ],
     ),
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

class ProfAD extends StatelessWidget {
  final User user;
 final Map idAS;
  ProfAD({this.idAS,this.user});
@override
  Widget build(BuildContext context) {
    return BlocProvider<ProfAdBloc>(
      create: (context) => ProfAdBloc()..add(ProfAdInit(idAS: idAS)),
      child: BlocBuilder<ProfAdBloc, ProfAdState>(
        builder: (context, state) {
          if (state is ProfAdInitial) {
            print(state.prof);
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
               children: state.prof
                    .map((prof) => Prof(prof:prof,user:user))
                    .toList()
            );
          } else if (state is ProfAdFailure) {
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
    String rait = prof['rait'];
   double rait1;
   rait1 =double.parse(rait);
    return Container(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal:15, vertical: 10),   
        child:InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilCargo(cargo: prof,user: user)));},
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
                       prof['vid']
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
                            prof['pynktA']
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
                             prof['pynktB']
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
                             prof['price']
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
  