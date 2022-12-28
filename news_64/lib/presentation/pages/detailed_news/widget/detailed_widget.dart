import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core_global/colors/colors.dart';
import '../../../../core_global/models/news_detailed_model/news_detailed_model.dart';
import '../../../../core_global/widget/card_photo_widget.dart';

class DetailedWidget extends StatefulWidget {
  final NewsDetailedModel detailed;

  DetailedWidget({Key? key, required this.detailed}) : super(key: key);

  @override
  State<DetailedWidget> createState() => _DetailedWidgetState();
}

class _DetailedWidgetState extends State<DetailedWidget> {
  formatDate(String datetime) {
    String day = datetime.substring(0, 2);
    String month = datetime.substring(2, 4);
    String year = datetime.substring(4, 6);

    String hours = datetime.substring(6, 8);
    String minutes = datetime.substring(8, 10);

    String formattedDate = day + '.' + month + '.' + year;
    String formattedTime = hours + ':' + minutes;

    return [formattedDate, formattedTime];
  }

  @override
  Widget build(BuildContext context) {
    String date = formatDate(widget.detailed.date!).first;
    String time = formatDate(widget.detailed.date!).last;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primaryAppBar,
        title: const Padding(
          padding: EdgeInsets.only(left: 120),
          child: Text('Aa'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.detailed.img != null)
                Image.network(widget.detailed.img!),
              const SizedBox(height: 16),
              Text('$date,  $time',
                  style: const TextStyle(color: AppColors.primaryData)),
              const SizedBox(height: 8),
              Text(widget.detailed.title!,
                  style: const TextStyle(
                      color: AppColors.textColorBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Container(
                color: AppColors.backgroundCard,
                height: 1,
              ),
              const SizedBox(height: 24),
              Html(data: widget.detailed.text!),
              if(widget.detailed.gallery != null)
                RestaurantCardWidget(
                  urls: widget.detailed.gallery!)
            ],
          ),
        ),
      ),
    );
  }
}
