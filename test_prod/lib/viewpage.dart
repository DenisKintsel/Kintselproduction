import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'icon/custom_icons.dart';

class ViewPage extends StatelessWidget {
  final list;
  ViewPage({this.list});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        // resizeToAvoidBottomInset: false,
        body: Column(children: [But(), ViewText(list: list)]));
  }
}

class But extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
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

class ViewText extends StatelessWidget {
  final list;
  ViewText({this.list});
  @override
  Widget build(BuildContext context) {
    var url = list['image'];
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ), // changes position of shadow

                  child: FadeInImage.assetNetwork(
                    placeholder: ("image/icons8.png"),
                    image: url,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 65),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(list['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 22),
                                softWrap: true,
                                textAlign: TextAlign.left),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 40, bottom: 30),
                              child: Text(list['crew'],
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 15),
                                  softWrap: true),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: TextButton(
                                    onPressed: () async {
                                      final url2 =
                                          'https://github.com/DenisKintsel/Kintselproduction';
                                      if (await canLaunch(url2)) {
                                        await launch(url2);
                                      }
                                    },
                                    child: Text('Ссылка на тему',
                                        style: TextStyle(
                                            fontSize: 17,
                                            decoration:
                                                TextDecoration.underline)))),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: TextButton(
                                    onPressed: () async {
                                      //final url2 =
                                      //    'https://github.com/DenisKintsel/Kintselproduction';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Text('Ссылка на фото',
                                        style: TextStyle(
                                            fontSize: 17,
                                            decoration:
                                                TextDecoration.underline)))),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Container(
                                child: Center(
                                    child: ElevatedButton(
                                        child: Text('Назад'),
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 44, 39, 48)),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 82, 82, 82)),
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(265, 45)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                        ))))
                          ]))
                    ],
                  ))
            ],
          ),
        ));
  }
}
