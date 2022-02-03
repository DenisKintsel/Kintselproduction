import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterapp2/screens/Pages/outputcomments_bloc/outputcomments_bloc.dart';
import 'package:flutterapp2/widgets/information_modal.dart';

class OutputComments extends StatelessWidget{
  final Map searchid;
  OutputComments({this.searchid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
      title: Text('Комментарии'),
      ),
      resizeToAvoidBottomInset: false,
        body: Body(searchid:searchid)
        );
  }

}

class Body extends StatelessWidget {
  final Map searchid;
  Body({this.searchid});

  @override
  Widget build(BuildContext context) {
    print(searchid);
    return BlocProvider<OutputCommentsBloc>(
      create: (context) => OutputCommentsBloc()..add(Init(searchid: searchid)),
      child: BlocBuilder<OutputCommentsBloc, OutputCommentsState>(
        builder: (context, state) {
          if (state is OutputCommentsInitial) {
            print(state.comment);
            return ListView(
               children: state.comment
                    .map((comment) => Com(comment:comment))
                    .toList()
            );
          } else if (state is OutputCommentsFailure) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Com extends StatelessWidget{
  final comment;
  Com({this.comment});
  @override
  Widget build(BuildContext context) {
    String rait = comment['star'];
   double rait1;
   rait1 =double.parse(rait);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Center(
        child: Container(
          child: Card(
            elevation: 12,
               shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(24),),
              color: Colors.white54,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children:[
                            Image.asset("images/no_foto.jpg",width: 50, height: 50)
                          ]
                        ),
                        SizedBox(
                              width: 10,
                            ),
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(  
                              children:[
                                Text(
                                 comment['username']
                                )
                              ]
                            ),
                            Row(
                              children: [
                                Text(
                                  'Оценка: '
                                ),
                                RatingBar.builder(
                                initialRating: rait1,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemSize: 15.0,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                   
                                },
                              )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Дата добавления'
                                ),
                                SizedBox(
                             width: 10,
                            ),
                                Text(
                                  comment['dataR']
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                             height: 5,
                            ),
                    Row(
                      children: [
                        Text(
                          'Комментарий:'
                        )
                      ],
                    ),
                    SizedBox(
                             height: 5,
                            ),       
                    Row(
                      children:[
                        Text(
                          comment['comments']
                        )
                      ]
                    )
                  ],
                ),
                ),
          ),
        ),
      ),
      );
  }

}