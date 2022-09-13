import 'package:flutter/material.dart';
import '../../../../core_global/colors/colors.dart';
import '../../../widget/appBar.dart';
import '../../../widget/search_widget.dart';
import 'order_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersWidget extends StatefulWidget{
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  _OrdersWidget createState() => _OrdersWidget();
}

class _OrdersWidget extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: CustomAppBar(title: loc.transporter,
          icon: Icons.notifications,
          titleAlert: "Запросы на выполнение",
          onPress:() => null, //widget.onClick.call()
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