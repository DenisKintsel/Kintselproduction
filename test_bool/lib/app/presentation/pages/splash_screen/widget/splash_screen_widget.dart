import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core_global/colors/colors.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({
    super.key,
  });

  @override
  _SplashScreenWidget createState() => _SplashScreenWidget();
}

class _SplashScreenWidget extends State<SplashScreenWidget>{
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    progress();
  }

  progress() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      setState(() {
        _progress = min(_progress + 7, 100);
      });

      progress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Text("ЗАГРУЗКА...",
              style: TextStyle(color: AppColors.selectionColor, fontSize: 32)),
            const SizedBox(height: 28),
            SizedBox(
              width: 300,
              child: LinearProgressIndicator(
                valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.selectionColor),
                value: _progress * 0.01,
              ),
            )
          ],
        ),
      ),
    );
  }

}