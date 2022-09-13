import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_architecture/app/presentation/pages/orders/cubit/orders_cubit.dart';
import '../cubit/orders_cubit.dart';
import '../../../../../get_injector.dart';
import '../widget/orders_widget.dart';

class OrdersView extends StatelessWidget{
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<OrdersCubit>()..init(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return state.when(
              initial:() => OrdersWidget(),
              loading:() => OrdersWidget(),
              error:() => Container(child: Text("Error")),
            );
          }),
    );
  }

}