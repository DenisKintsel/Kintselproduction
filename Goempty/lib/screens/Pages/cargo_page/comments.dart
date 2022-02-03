import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/screens/Pages/addcommentsbloc/addcomments_bloc.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

class Comments extends StatelessWidget{
  final User user;
  final String iduserA;
  Comments({this.iduserA,this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
      title: Text('ЕдуПустой'),
      ),
      resizeToAvoidBottomInset: false,
        body: Body(iduserA:iduserA,user: user)
        );
  }
  }

class Body extends StatelessWidget{
  final User user;
  final String iduserA;
  Body({this.iduserA,this.user});
  double _addraitController ;
  final TextEditingController _addcommentsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     var children2 = [
       Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 30),
        child:Center(
        child: Container(
            child: Column(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Установите оценку',
                      style: TextStyle(fontWeight:FontWeight.normal,color: Colors.black, fontSize:24)
                    )
                  ],
                ),
                SizedBox(
                     height: 20,
                     ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                                 initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemSize: 25.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                   _addraitController = rating;
                                },
                              )
                      ],
                    )
              ],
            ),
            
        ) 
        )
    ),
      //Rait( controller: _addraitController),
    Comment( controller: _addcommentsController, hintText:  "Комментарий"),
    Padding(
       padding: EdgeInsets.only(left: 20,right: 20,top: 30, bottom: 30),
        child: Container(
              height: 70,
              width:  MediaQuery.of(context).size.width,
        child:RaisedButton(
        splashColor: Colors.black,
        highlightColor: Color.fromRGBO(17, 177, 85, 1),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(color: Colors.black, width: 3),
          ),
        color: Color.fromRGBO(17, 177, 85, 1),
        child: Text('Добавить',
          style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
              ),
            onPressed: () {
              FocusScope.of(context).unfocus();
    if ( _addcommentsController.text.isEmpty||_addraitController == null) {
      showDialog(
          context: context,
          builder: (context) {
            return ModalInformation(title: "Ошибка", textContent: "Пустые поля");
          });
    } else { 
          {
             print('sity1: ${_addraitController.toString()}\n city2 ${_addcommentsController.text}\n id ${iduserA.toString()}\n id ${user.id}');
             AddCommentsBloc()..add(AddCommentsButtonPressed(
              idusers: user.id,
              iduserA: iduserA.toString(),
              comments: _addcommentsController.text,
              star: _addraitController.toString()
               )
               );
          }
      }
    }  ,)
          
          )
        )


     ];
     return Column(children: children2,);
  }
}


class Comment extends StatelessWidget{
  final controller;
final hintText;
  Comment({this.controller, this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 30),
        child:Container(
          height: 220,
           child:Card(
                elevation: 12,
               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(24),),
              color: Colors.white54,
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
        controller: controller,
        maxLength: 150,//макс ввод букв
        maxLines: 10,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
            hintText: hintText, 
        ),
         ),
      )
           )
        )
      );
  }
}
