import 'package:flutter/material.dart';
import 'package:todoapp/theme/test_style.dart';

class IllustrationWidget extends StatelessWidget {
  const IllustrationWidget({
    Key key,
    @required this.imageSrc,
    @required this.title,
    @required this.subTitle,
  }) : super(key: key);

  final String imageSrc;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
        ),
        Image.asset(
          this.imageSrc,
          height: 300,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          this.title ?? "",
          style: CommonTextStyle.titleStyle(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          this.subTitle ?? "",
          style: CommonTextStyle.subTitleStyle(),
        ),
      ],
    );
  }
}
