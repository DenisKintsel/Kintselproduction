import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:pattern_architecture/app/domain/usecases/user/registration_user.dart';
import '../../../../../get_injector.dart';
import '../cubit/registration_cubit.dart';
import '../widget/registration_widget.dart';

class RegistrationView extends StatelessWidget{
  const RegistrationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<RegistrationCubit>(),
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
          builder: (context, state) {
            return state.when(
              initial:() => RegistrationWidget(
                regUser: (email,name,city,password) async =>
                BlocProvider.of<RegistrationCubit>(context).regUser(email, name, city, password),
              ),
              loading:() => RegistrationWidget(
                regUser: (email,name,city,password) async =>
                    BlocProvider.of<RegistrationCubit>(context).regUser(email, name, city, password),
              ),
              error:() => Container(child: Text("Error")),
            );
          }),
    );
  }

}