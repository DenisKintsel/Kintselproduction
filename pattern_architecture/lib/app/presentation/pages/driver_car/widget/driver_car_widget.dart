import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core_global/colors/colors.dart';
import '../../../widget/appBar.dart';
import '../../../widget/form_container_order.dart';
import '../../../widget/search_widget.dart';

class DriverCarWidget extends StatefulWidget {
  final List output;
  final Function onClick;
  const DriverCarWidget({Key? key, required this.onClick, required this.output}) : super(key: key);

  @override
  _DriverCarWidget createState() => _DriverCarWidget();
}

class _DriverCarWidget extends State<DriverCarWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: CustomAppBar(title: loc.transporter,
        icon: Icons.add,
        onPress:() => widget.onClick.call()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(child: SearchWidget(onSearch: (String) {})),
                  const SizedBox(width: 5),
                  Expanded(child: SearchWidget(onSearch: (String) {})),
                ],
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.output.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children:  [
                        const SizedBox(height: 16.0),
                        FormContainerOrder(
                            car: widget.output[index]['car'],
                            name: "Артем Иванов",
                            departure: widget.output[index]['departure'],
                            receipt: widget.output[index]['receipt'],
                            data: widget.output[index]['data'],
                          onPress: (){},
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
