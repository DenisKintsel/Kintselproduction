import 'package:flutter/material.dart';

import '../../../core_global/colors/colors.dart';
import '../../widget/form_container_order.dart';

class ViewFilm extends StatelessWidget{
  const ViewFilm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Привет!!!!!"),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: FormContainerOrder(),
            // )
          ],
        ),
      ),
    );
  }

}