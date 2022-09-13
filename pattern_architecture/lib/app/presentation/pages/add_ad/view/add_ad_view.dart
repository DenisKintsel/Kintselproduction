import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:pattern_architecture/app/domain/usecases/user/registration_user.dart';
import '../../../../../get_injector.dart';
import '../cubit/add_ad_cubit.dart';
import '../widget/add_ad_widget.dart';

class AddAdView extends StatelessWidget{
  const AddAdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AddAdCubit>()..init(),
      child: BlocBuilder<AddAdCubit, AddAdState>(
          builder: (context, state) {
            return state.when(
              initial:() => AddAdWidget(
                addAd:(title,car,notes,departure,receipt,data) async =>
                    BlocProvider.of<AddAdCubit>(context).add(title, car, data, notes, departure, receipt),
              ),
              loading:() => AddAdWidget(
                  addAd:(title,car,notes,departure,receipt,data) async =>
                      BlocProvider.of<AddAdCubit>(context).add(title, car, data, notes, departure, receipt)
              ),
              error:() => Container(child: Text("Error")),
            );
          }),
    );
  }

}