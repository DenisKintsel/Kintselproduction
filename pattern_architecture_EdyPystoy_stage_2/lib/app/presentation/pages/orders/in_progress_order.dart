import 'package:flutter/material.dart';

import '../../widget/form_container_order.dart';

class InProgressOrder extends StatelessWidget {
  const InProgressOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: const [
              SizedBox(height: 16.0),
              FormContainerOrder(),
            ],
          );
        });
  }
}
