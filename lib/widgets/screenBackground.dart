import 'package:besttodotask/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Screenbackground extends StatelessWidget {
  const Screenbackground({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AssetPath.backgroundSvg, fit: BoxFit.cover),
        SafeArea(child: child),
      ],
    );
  }
}
