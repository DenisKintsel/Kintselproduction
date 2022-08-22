import 'package:flutter/material.dart';
import 'package:pattern_architecture/app/core_global/colors/colors.dart';

import '../orders/orders.dart';
import '../view_film/view_film.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  int _selectionIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Container(
                        width: 130,
                        decoration: const BoxDecoration(
                          color: AppColors.selectionColor,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/Vector.png'),
                              const SizedBox(width: 4),
                              const Text(
                                "Заказы",
                                style:
                                    TextStyle(color: AppColors.textColorBlack),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Image.asset('assets/images/truck.png'),
                    ),
                    Tab(
                      child: Image.asset('assets/images/users.png'),
                    ),
                    Tab(
                      child: Image.asset('assets/images/chat.png'),
                    ),
                  ]),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Orders(),
            ViewFilm(),
            Orders(),
            ViewFilm(),
          ],
        ),
      ),
    );
  }
}
