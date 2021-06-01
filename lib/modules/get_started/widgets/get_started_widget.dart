import 'package:flutter/material.dart';
import 'package:todoapp/modules/get_started/widgets/pageview_widget.dart';
import 'package:todoapp/modules/home/screens/home_screen.dart';

class GetStartedWidget extends StatelessWidget {
  const GetStartedWidget({
    Key key,
    @required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        PageViewWidget(
          // isOnlyIllustration: true,
          onTapNext: () {
            navigateToScreen(1);
          },
          onTapSkip: () {
            navigateToScreen(2);
          },
          isFirstScreen: true,
          imageSrc: "assets/images/idea_image.png",
          title: "Create tasks",
          subTitle: "What do you need to do?",
        ),
        PageViewWidget(
          onTapNext: () {
            navigateToScreen(2);
          },
          onTapSkip: () {
            navigateToScreen(2);
          },
          onTapPrev: () {
            navigateToScreen(0);
          },
          imageSrc: "assets/images/pin_task.png",
          title: "Pin the task",
          subTitle: "Pin it and then come back to it later",
        ),
        PageViewWidget(
          isLastScreen: true,
          imageSrc: "assets/images/todo_check_list.png",
          title: "Mark completed tasks",
          subTitle: "We know, you like it?",
          onTapGetStarted: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false);
          },
        )
      ],
    );
  }

  void navigateToScreen(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }
}
