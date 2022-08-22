import 'package:flutter/material.dart';
import 'package:pattern_architecture/app/core_global/colors/colors.dart';

class FormContainerOrder extends StatelessWidget {
  const FormContainerOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> print("нажатие"),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Artem Sokolov (IVECO Stralis...)",
                style: TextStyle(color: AppColors.textColor),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Medicines for HEALTH ",
                      style: TextStyle(color: AppColors.subtextColor)), //Груз
                  Text(
                    "29.01.2022 - 01.02.2022",
                    style: TextStyle(color: AppColors.textColor),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Text("Москва", style: TextStyle(color: AppColors.textColor)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: AppColors.textColor, size: 16),
                  SizedBox(width: 4),
                  Text("Саратов", style: TextStyle(color: AppColors.textColor))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
