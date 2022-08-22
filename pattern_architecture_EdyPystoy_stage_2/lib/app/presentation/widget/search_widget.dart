import 'package:flutter/material.dart';

import '../../core_global/colors/colors.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;

   SearchWidget(
      {Key? key, required this.onSearch,})
      : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 44.0,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(children: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.subtextColor),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) => onSearch(value),
              cursorColor: AppColors.textColor,
              style: const TextStyle(color: AppColors.textColor),
              decoration: const InputDecoration(
                prefixIconColor: AppColors.textColor,
                border: InputBorder.none,
                hintText: "Поиск",
                hintStyle: TextStyle(color: AppColors.subtextColor),
              ),
            ),
          ),
        ]));
  }
}
