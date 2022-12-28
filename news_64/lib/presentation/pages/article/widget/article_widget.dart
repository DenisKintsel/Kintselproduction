import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core_global/colors/colors.dart';
import '../../../../core_global/models/news_model/news_model.dart';
import '../../../../core_global/widget/window_news.dart';

class ArticleWidget extends StatefulWidget {
  final List<NewsModel> news;
  final Function(String) onScroll;
  final Function onRefresh;
  final Function(String) onClick;

  ArticleWidget(
      {required this.news,
      required this.onScroll,
      required this.onRefresh,
      required this.onClick});

  @override
  _ArticleWidget createState() => _ArticleWidget();
}

class _ArticleWidget extends State<ArticleWidget> {
  final controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        widget.onScroll(widget.news[widget.news.length - 1].date!);
      }
    });
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: RefreshIndicator(
        onRefresh: () => widget.onRefresh(),
        child: SingleChildScrollView(
            controller: controller,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.news.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => widget.onClick(widget.news[index].id!),
                        child: WindowNews(
                            data: widget.news[index].date!,
                            title: widget.news[index].title!,
                            img: widget.news[index].img!,
                            important: widget.news[index].important!),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          color: AppColors.backgroundCard,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  );
                })),
      ),
    );
  }
}
