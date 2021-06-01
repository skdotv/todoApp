import 'package:flutter/material.dart';
import 'package:todoapp/theme/test_style.dart';

class ClickText extends StatelessWidget {
  const ClickText({
    Key key,
    @required this.onTap,
    this.label,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(this.label ?? "",
            style: CommonTextStyle.normalTextStyle(
              color: Theme.of(context).primaryColor,
            )),
      ),
    );
  }
}
