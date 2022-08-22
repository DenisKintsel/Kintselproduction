import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pattern_architecture/app/core_global/colors/colors.dart';

import 'completed_orders.dart';
import 'in_progress_order.dart';

class OrderView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: TabBar(
          indicatorColor: AppColors.selectionColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
          tabs: [
            Text("В ПРОЦЕССЕ",style: TextStyle(fontSize: 16)),
            Text("ВЫПОЛНЕНО",style: TextStyle(fontSize: 16))
          ],
        ),
        body: TabBarView(
            children:[
              InProgressOrder(),
              CompletedOrder()
            ] ),
      ),

    );
  }
}