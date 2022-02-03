import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/routes/routes.dart';

class HomeProg extends StatelessWidget {
  static const String routeName = '/Home';
  final User user;
  HomeProg({this.user});
  @override
 Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(title: Text('ЕдуПустой'),
        actions: <Widget>[
          PopupMenuButton<String>(
           //onSelected: choicesAction(context),
           onSelected: (choice) => choicesAction(choice, context),
            itemBuilder: (BuildContext context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );     
              }).toList();
            },
            ),
        ],
        ),
        body: Body()
         );
  }
}

void choicesAction(String choices, context ){
  if (choices == Constants.Cargo){
      Navigator.pushNamed(context, Routes.addcargo);
  }
  else if (choices == Constants.Driver){
    Navigator.pushNamed(context, Routes.adddriver);
  }
}

class Constants{
  static const String Cargo = "Груз";
  static const String Driver = "Водитель";

  static const List<String> choices = <String>[
    Cargo,
    Driver
  ];
}


class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(children: [Logo(),Content()],);
  }
}



class Logo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width:MediaQuery.of(context).size.width,
      height: 300,
      child: Image(image:AssetImage("./images/logo.png"),width:MediaQuery.of(context).size.width,height:300,),
    );
  }
}


class Content extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DButton(text:"Груз",Onpress: (){
          Navigator.pushNamed(context, Routes.cargosearch);
        },),
        DButton(text:"Водители",Onpress: (){
          Navigator.pushNamed(context, Routes.searchdriver);
        },),
        DButton(text:"Профиль",Onpress: (){
          Navigator.pushNamed(context, Routes.myprofil);
        },)
      ],
    );
  }

}




class DButton extends StatelessWidget{


  final String text;
  final Onpress;
  DButton({this.Onpress,this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20,top: 30),
            child: Container(
              height: 70,
              width:  MediaQuery.of(context).size.width,
              // MediaQuery.of(context).size.width,
              child: RaisedButton(
                splashColor: Colors.black,
                highlightColor: Color.fromRGBO(17, 177, 85,1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),
                  side: BorderSide(color: Colors.black, width: 3),
                  ),
                color: Color.fromRGBO(17, 177, 85,1),
                child: Text(
                  text,
                  style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize:22),
                ),
                onPressed: Onpress
              )
            ),
          )
        ],
      ),
    );
  }
}


/*Widget ButtonCl (String text,void fonc()){
  return RaisedButton(
    splashColor: Color.fromRGBO(17, 177, 85,1),
    highlightColor: Color.fromRGBO(17, 177, 85,1),
    color: Colors.black,
    child: Text(
      text,
      style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white, fontSize:20),
    ),
    onPressed:(){
      fonc();

    },
  );
}


Widget _form(String label, fonc()){
  return Container(
    child: Column(
    children: <Widget>[
        Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
        child: DButton(text: "gjvkuhj",Onpress: (){}),
  ),
      ],
    ),
  );
}
Widget _form2(String label, fonc2()){
  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 40),
          child: Container(
            height: 50,
            width:  200,
            // MediaQuery.of(context).size.width,
            child: ButtonCl(label,fonc2),
          ),
        )
      ],
    ),
  );
}
Widget _form3(String label, fonc3()){
  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 40),
          child: Container(
            height: 50,
            width:  MediaQuery.of(context).size.width,
            // MediaQuery.of(context).size.width,
            child: ButtonCl(label,fonc3),
          ),
        )
      ],
    ),
  );
}
Widget _form4(String label, fonc4()){
  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 40),
          child: Container(
            height: 50,
            width:  200,
            // MediaQuery.of(context).size.width,
            child: ButtonCl(label,fonc4),
          ),
        )
      ],
    ),
  );
}
}*/
