import 'package:flutter/material.dart';
import 'package:todoapp/widgets/clickable_text.dart';
import 'package:todoapp/widgets/common_button.dart';
import 'package:todoapp/widgets/illustration_widget.dart';

class PageViewWidget extends StatelessWidget {
  final String imageSrc;
  final String title;
  final String subTitle;
  final bool isFirstScreen;
  final bool isLastScreen;
  final VoidCallback onTapSkip;
  final VoidCallback onTapNext;
  final VoidCallback onTapPrev;
  final VoidCallback onTapGetStarted;
  final bool isOnlyIllustration;

  const PageViewWidget({
    Key key,
    this.imageSrc,
    this.title,
    this.subTitle,
    this.isFirstScreen = false,
    this.isLastScreen = false,
    this.onTapSkip,
    this.onTapNext,
    this.onTapPrev,
    this.onTapGetStarted,
    this.isOnlyIllustration = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IllustrationWidget(
            imageSrc: imageSrc, title: title, subTitle: subTitle),
        isOnlyIllustration
            ? SizedBox.shrink()
            : _BottomButtonWidgets(
                isLastScreen: isLastScreen,
                isFirstScreen: isFirstScreen,
                onTapSkip: this.onTapSkip,
                onTapPrev: this.onTapPrev,
                onTapNext: this.onTapNext,
              ),
        isOnlyIllustration
            ? SizedBox.shrink()
            : isLastScreen
                ? CommonButton(
                    label: "GET STARTED",
                    onTap: this.onTapGetStarted,
                    buttonColor: Theme.of(context).primaryColor,
                  )
                : SizedBox.shrink()
      ],
    );
  }
}

class _BottomButtonWidgets extends StatelessWidget {
  const _BottomButtonWidgets({
    Key key,
    @required this.isLastScreen,
    @required this.isFirstScreen,
    @required this.onTapSkip,
    @required this.onTapPrev,
    @required this.onTapNext,
  }) : super(key: key);

  final bool isLastScreen;
  final bool isFirstScreen;
  final VoidCallback onTapSkip;
  final VoidCallback onTapPrev;
  final VoidCallback onTapNext;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: this.isLastScreen
              ? SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    this.isFirstScreen
                        ? ClickText(
                            label: "Skip",
                            onTap: this.onTapSkip,
                          )
                        : ClickText(
                            label: "Prev",
                            onTap: this.onTapPrev,
                          ),
                    ClickText(
                      label: "Next",
                      onTap: this.onTapNext,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
