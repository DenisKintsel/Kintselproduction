import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core_global/colors/colors.dart';
import '../../../widget/appBar.dart';
import '../../../widget/form_container_order.dart';
import '../../../widget/search_widget.dart';

class CargoWidget extends StatefulWidget{
  final List output;
  final Function onClick;
  final Function(int) onPress;
  const CargoWidget({super.key, required this.output, required this.onClick, required this.onPress});

  @override
  _CargoWidget createState() => _CargoWidget();
}

class _CargoWidget extends State<CargoWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: CustomAppBar(title: loc.cargo,
          icon: Icons.add,
          onPress:() => widget.onClick.call()
      ),
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
                          onPress:(){
                            widget.onPress.call(int.parse(widget.output[index]['idCargo']));
                          }
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