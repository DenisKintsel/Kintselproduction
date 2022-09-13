import 'package:flutter/material.dart';
import 'package:pattern_architecture/app/core_global/colors/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormContainerOrder extends StatelessWidget {
  final String? car;
  final String name;
  final String departure;
  final String receipt;
  final String data;
  final String? cargo;
  final Function onPress;

  const FormContainerOrder(
      {Key? key,
      required this.car,
      required this.name,
      required this.departure,
      required this.receipt,
      required this.data,
        this.cargo, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => onPress.call(),
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
              Text(
                "$name ( $car )",
                style: const TextStyle(color: AppColors.textColor),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (cargo != null)
                    Text(cargo!, style: TextStyle(color: AppColors.subtextColor))
                  else
                    const Text('', style: TextStyle(color: AppColors.subtextColor)),
                  Row(
                    children: [
                      Text( loc.departureDate,
                          style: const TextStyle(color: AppColors.textColor)
                      ),
                      const SizedBox(width: 6),
                      Text(
                        data,
                        style: const TextStyle(color: AppColors.textColor),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(departure,
                      style: const TextStyle(color: AppColors.textColor)),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward,
                      color: AppColors.textColor, size: 16),
                  const SizedBox(width: 4),
                  Text(receipt, style: TextStyle(color: AppColors.textColor))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
