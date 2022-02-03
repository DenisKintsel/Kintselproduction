import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp2/bloc/auth_bloc.dart';
import 'package:flutterapp2/repository/user_repository.dart';
import 'package:flutterapp2/screens/Registr/registr_form.dart';

import 'bloc/registr_bloc.dart';

class RegistrPage extends StatelessWidget {
  final UserRepository _userRepository;

  RegistrPage({@required UserRepository userRepository})
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
              return RegistrBloc(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
                userRepository: _userRepository,
              );
            },
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: RegistrForm(userRepository:_userRepository)
          
                )));
  }
  
}
