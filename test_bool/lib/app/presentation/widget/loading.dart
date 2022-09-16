import 'package:flutter/material.dart';

import '../../core_global/colors/colors.dart';

class LoadingWidget extends StatelessWidget{
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}