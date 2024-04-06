import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class GlassWidget extends StatelessWidget {
  const GlassWidget({
    super.key,
    required this.height,
    required this.width,
    required this.child,
  });
  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: height,
      width: width,
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: Colors.white.withOpacity(0.10),
      borderRadius: BorderRadius.circular(30),
      blur: 15.0,
      borderWidth: 0.5,
      elevation: 3.0,
      isFrostedGlass: false,
      shadowColor: Colors.black.withOpacity(0.20),
      alignment: Alignment.center,
      frostedOpacity: 0.12,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: child,
    );
  }
}
