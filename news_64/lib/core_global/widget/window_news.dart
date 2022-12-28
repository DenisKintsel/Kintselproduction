import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../colors/colors.dart';

class WindowNews extends StatelessWidget{
  final String data;
  final String title;
  final String img;
  final int important;
   WindowNews({
    required this.data,
    required this.title,
    required this.img,
    required this.important,
});
  @override
  Widget build(BuildContext context) {
    formatDate(String datetime) {

      String day = datetime.substring(0,2);
      String month = datetime.substring(2,4);
      String year = datetime.substring(4,6);

      String hours = datetime.substring(6,8);
      String minutes = datetime.substring(8,10);


      String formattedDate = day + '.' + month + '.' + year;
      String formattedTime = hours + ':' + minutes;

      return [formattedDate, formattedTime];
    }
    String date = formatDate(data).first;
    String time = formatDate(data).last;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yy').format(now);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formattedDate == date ? time :
                    '$date,  $time',
                        style: TextStyle(color: AppColors.primaryData)),
                    const SizedBox(height: 8),
                    Text(title,
                      softWrap: true,
                      style: TextStyle(color: AppColors.textColorBlack,fontSize: 17,fontWeight: important == 1 ?FontWeight.bold :FontWeight.w400),
                    )
                  ],
                ),
              ),
              if(img != "")
              Expanded(
                flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(img,height: 80,width: 120,fit: BoxFit.fill,),
                      ],
                    ),
                  ))
            ],)
          ],
        ),
      )
    );
  }
  
}