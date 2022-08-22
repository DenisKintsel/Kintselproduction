
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../get_injector.dart';
import '../cubit/autorization_cubit.dart';
import '../widget/autorization_widget.dart';

class AutorizationView extends StatelessWidget{
  const AutorizationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AuthorizationCubit>(),
      child: BlocBuilder<AuthorizationCubit, AuthState>(
        builder: (context, state) {
          return state.when(
              initial:() => Autorization(
                autUser: (email,password) async =>
                    BlocProvider.of<AuthorizationCubit>(context).autUser(email,password),
              ),
              loading:() => Autorization(
                autUser: (email,password) async =>
                    BlocProvider.of<AuthorizationCubit>(context).autUser(email,password),
              ),
              error:() => Container(child: Text("Error")),
          );
        }),
    );
  }

}