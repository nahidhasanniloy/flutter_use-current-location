import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final Color? color;
  final Color? color1;
  final Color? color2;


  const PageIndicator({super.key,this.color, this.color1,this.color2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 8,
          width: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration:  BoxDecoration(
            color: color ?? Colors.white24,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: 8,
          width: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration:  BoxDecoration(
            color: color1 ?? Colors.white24,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: 8,
          width: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration:  BoxDecoration(
            color: color2 ?? Colors.white24,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
