import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp2/bloc/auth_bloc.dart';
import 'package:flutterapp2/repository/user_repository.dart';
import 'package:flutterapp2/screens/Login/login_form.dart';

import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository _userRepository;

  LoginPage({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super();
  // Формирование виджета
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.white,
          automaticallyImplyLeading: true,
        ),
        body: BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
                userRepository: _userRepository,
              );
            },
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: LoginForm(userRepository:_userRepository)
          
                )));
  }
  
}
