import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core_global/colors/colors.dart';
import '../../widget/search_widget.dart';
import 'completed_orders.dart';
import 'in_progress_order.dart';
import '../orders/widget/order_view.dart';

class Orders extends StatefulWidget{
  const Orders({Key? key}) : super(key: key);

  @override
  _Orders createState() => _Orders();
}

class _Orders extends State<Orders> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: AppColors.backgroundPrimary,
     appBar: AppBar(
       elevation: 0.0,
       backgroundColor: Colors.transparent,
       title:const Padding(
         padding: EdgeInsets.only(top: 12.0),
         child: Text("Заказы"),
       ),
       actions: const [
         IconButton(icon: Icon(Icons.notifications_outlined,
           color: AppColors.textColor,),onPressed: null,),
       ],
     ),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           SearchWidget(onSearch: (String) {  }),
           const SizedBox(height: 28.0),
           Expanded(child: OrderView())
         ],
       ),
     ),
   );
  }
}