import 'package:flutter/material.dart';

import '../../core_global/colors/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  final VoidCallback onPress;
  final IconData icon;
  final String ?titleAlert;
  const CustomAppBar({super.key, required this.title, required this.onPress, required this.icon, this.titleAlert});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title:  Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(title),
      ),
      actions:  [
        titleAlert != null
        ?TextButton.icon(
            onPressed: onPress,
            icon: Icon(
              icon,
              color: AppColors.textColor,
            ),
            label: Text(titleAlert!))
        :IconButton(
          icon: Icon(
            icon,
            color: AppColors.textColor,
          ),
          onPressed: onPress,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);

}