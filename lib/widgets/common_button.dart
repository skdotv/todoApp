import 'package:flutter/material.dart';
import 'package:todoapp/theme/test_style.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color buttonColor;
  final double width;
  final double height;
  final bool isLabelBold;
  const CommonButton({
    Key key,
    this.label,
    this.onTap,
    this.buttonColor,
    this.width = 1.0,
    this.isLabelBold = true,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          elevation: MaterialStateProperty.all(2),
        ),
        onPressed: this.onTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * width,
          height: this.height,
          child: Center(
            child: Text(
              this.label,
              style: CommonTextStyle.normalTextStyle(
                color: Colors.white,
                fontWeight:
                    this.isLabelBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
