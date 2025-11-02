import 'package:flutter/material.dart';

class TriIcon extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final double size;

  const TriIcon({
    super.key,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final double smallSize = size * 0.5;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Top icon
          Positioned(
            top: 0,
            child: Icon(icon1, size: smallSize),
          ),
          // Bottom-left icon
          Positioned(
            bottom: 0,
            left: 0,
            child: Icon(icon2, size: smallSize),
          ),
          // Bottom-right icon
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(icon3, size: smallSize),
          ),
        ],
      ),
    );
  }
}
