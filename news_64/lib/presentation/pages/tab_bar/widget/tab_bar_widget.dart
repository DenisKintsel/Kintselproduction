import 'package:flutter/material.dart';
import 'package:news_64/core_global/colors/colors.dart';

import '../../article/view/article_view.dart';
import '../../important/view/important_view.dart';
import '../../news_view/view/news_view.dart';

class TabBarWidget extends StatefulWidget{
  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.primaryAppBar,
          appBar: AppBar(
            backgroundColor: AppColors.primaryAppBar,
            elevation: 0,
            title: Center(
              child: Image.asset(
                'assets/images/logo.bmp',
                height: 30,
              ),
            ),
          ),
          body: Column(
            children:  [
              TabBar(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.focused) ? null : Colors.transparent;
                    },
                  ),
                  indicatorPadding: const EdgeInsets.all(4),
                indicatorColor:AppColors.primaryAppBar,
                  tabs: [
                Tab(
                  child: Text('ЛЕНТА',
                  style: TextStyle(color: AppColors.backgroundPrimary),),
                ),
                Tab(

                  child: Text('ВАЖНОЕ',
                  style: TextStyle(color: AppColors.backgroundPrimary),),
                ),
                Tab(
                  child: Text('СТАТЬИ',
                  style: TextStyle(color: AppColors.backgroundPrimary),),
                )
              ]),
              Expanded(
                  child:TabBarView(children: [
                    NewsView(),
                    ImportantView(),
                    ArticleView()
                  ]) )
            ],
          ),
        ));
  }
}