import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prod/viewpage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/list_bloc.dart';
import 'icon/custom_icons.dart';
import 'information_modal.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(children: [
          Column(children: [But()]),
          Column(children: [
            SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.90,
                  child: ListBody()),
            ),
          ])
        ])));
  }
} //[But(), ListBody()]

class But extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
              onPressed: () {
                SystemNavigator.pop();
              },
              icon: Icon(
                CustomIcons.out_,
                color: Colors.black,
              ),
              label: Text(
                'Выйти',
                style: TextStyle(
                  letterSpacing: .5,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListBloc>(
        create: (context) => ListBloc()..add(Init()),
        child: BlocBuilder<ListBloc, ListState>(builder: (context, state) {
          if (state is ListInitial) {
            return ListView(
                children: state.list
                    .map((list) => ListPageBody(list: list))
                    .toList());
            //ListPageBody(list: state.list);
          } else if (state is ListBD) {
            return ListView(
                children: state.name
                    .map((name) => ListPageBody(list: name))
                    .toList());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}

class ListPageBody extends StatelessWidget {
  final list;
  ListPageBody({this.list});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewPage(list: list)));
            },
            child: Container(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Color.fromARGB(255, 72, 50, 170),
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Row(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 130,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '#',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            fontSize: 22),
                                      ),
                                      Text(
                                        list['rank'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 22),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                                height: 130,
                                width: 2,
                                //color: Colors.black,
                                child: VerticalDivider(
                                  color: Colors.black, //color of divider
                                  width: 20, //width space of divider
                                  thickness: 1, //thickness of divier line
                                  indent: 10, //Spacing at the top of divider.
                                  endIndent:
                                      10, //Spacing at the bottom of divider.
                                )),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(list['title'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: 22),
                                        softWrap: true),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(list['crew'],
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                        maxLines: 10,
                                        softWrap: true),
                                    SizedBox(
                                      height: 70,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ]))))));
  }
}
