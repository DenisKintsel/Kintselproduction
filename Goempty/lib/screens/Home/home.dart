

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp2/model/user_model.dart';
import 'package:flutterapp2/routes/routes.dart';
import 'package:flutterapp2/screens/Pages/addcargo.dart';
import 'package:flutterapp2/screens/Pages/adddriver.dart';
import 'package:flutterapp2/screens/Pages/cargosearch.dart';
import 'package:flutterapp2/screens/Pages/profile_Auser/my_profil.dart';
import 'package:flutterapp2/screens/Pages/searchdriver.dart';
import 'package:flutterapp2/storage/simple_bloc_observer.dart';

import 'newsScreen/homeprog.dart';

class HomeLayout extends StatelessWidget {
  final User user;
  final firebaseMessaging;
  HomeLayout({this.user, this.firebaseMessaging});
  @override
  Widget build(BuildContext context) {
    
    Bloc.observer = SimpleBlocObserver();
    print(user);
    return MaterialApp(
      home: HomeProg(user: user),
      theme: ThemeData(
           scaffoldBackgroundColor: Colors.white,
          primaryColor:Color.fromRGBO(17, 177, 85,1),
          brightness: Brightness.light,
          fontFamily: 'DRONE'),
      routes: {
        Routes.home: (context) => HomeProg(user: user),
         Routes.cargosearch: (context) => Cargosearch(user: user),
         Routes.searchdriver: (context) => Searchdriver(user: user),
         Routes.addcargo: (context) => Addcargo(user: user),
         Routes.adddriver: (context) => Adddriver(user: user),
         Routes.myprofil: (context) => MyProfil(user: user),
      },
    );
  }
}
