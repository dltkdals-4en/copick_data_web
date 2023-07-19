import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class DataLoadingScreen extends StatefulWidget {
  const DataLoadingScreen({this.text, Key? key}) : super(key: key);

  final String? text;

  @override
  State<DataLoadingScreen> createState() => _DataLoadingScreenState();
}

class _DataLoadingScreenState extends State<DataLoadingScreen>
    with TickerProviderStateMixin {
  Color? _color = Colors.grey[400];
  late AnimationController _controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    animation = ColorTween(
      begin: Colors.grey,
      end: KColors.primary,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  color: KColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: animation.value),
                        child: Center(
                          child: Image.asset(
                            'assets/images/loadingLogo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      kSmH,
                      (widget.text != null) ? Text(widget.text!, style: kLabelTextStyle.copyWith(fontSize: 16),) : SizedBox(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          child: Opacity(
            opacity: 0.1,
            child: Container(
              width: size.width,
              height: size.height,
              color: KColors.white,
            ),
          ),
        )
      ],
    );
  }
}
