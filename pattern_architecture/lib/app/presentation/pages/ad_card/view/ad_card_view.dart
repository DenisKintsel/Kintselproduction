import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../get_injector.dart';
import '../cubit/ad_card_cubit.dart';
import '../widget/ad_card_widget.dart';

class AdCardView extends StatelessWidget {
  final int id;
  const AdCardView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AdCardCubit>()..init(id),
      child: BlocBuilder<AdCardCubit, AdCardState>(builder: (context, state) {
        return state.when(
          initial: (output) => AdCardWidget(output: output,
          respond: (idAd,idUserClient,statusOrder) async =>
              BlocProvider.of<AdCardCubit>(context).respond(idAd,idUserClient,statusOrder)),
          loading: () => Container(child: Text("Загрузка")),
          error: () => Container(child: Text("Error")),
        );
      }),
    );
  }
}
