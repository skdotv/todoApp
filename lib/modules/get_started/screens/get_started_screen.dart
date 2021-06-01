import 'package:flutter/material.dart';
import 'package:todoapp/modules/get_started/widgets/get_started_widget.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetStartedWidget(
        pageController: _pageController,
      ),
    );
  }
}
