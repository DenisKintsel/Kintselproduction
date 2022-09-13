import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pattern_architecture/app/core_global/colors/colors.dart';

import '../../orders1/completed_orders.dart';
import '../../orders1/in_progress_order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: TabBar(
          indicatorColor: AppColors.selectionColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          tabs: [
            Text(loc.inProgress, style: const TextStyle(fontSize: 16)),
            Text(loc.completed, style: const TextStyle(fontSize: 16))
          ],
        ),
        body: const TabBarView(children: [InProgressOrder(), CompletedOrder()]),
      ),
    );
  }
}
