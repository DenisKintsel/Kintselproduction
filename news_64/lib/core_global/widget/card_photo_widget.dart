import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_64/core_global/models/news_detailed_model/gallery.dart';

class RestaurantCardWidget extends StatefulWidget {
  const RestaurantCardWidget({
    super.key,
    required this.urls,
  });

  final List<Gallery> urls;

  @override
  State<RestaurantCardWidget> createState() => _State();
}

class _State extends State<RestaurantCardWidget> {
  int _index = 0;
  Timer? _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    if (widget.urls.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (_index < widget.urls.length - 1) {
          _index++;
        } else {
          _index = 0;
        }
        viewController();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _pageController.dispose();
  }

  void viewController() {
    _pageController.animateToPage(
      _index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: 400,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: widget.urls.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _index = index % (widget.urls.length);
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              widget.urls[index].smallImg!,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(),
                      );
                    },
                  ),
                ),
                widget.urls.length > 1
                    ? Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(widget.urls.length, (i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      _index == i ? Colors.blue : Colors.grey),
                            );
                          }).toList(),
                        ))
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
