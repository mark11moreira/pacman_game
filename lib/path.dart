import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  final innerColor;
  final outColor;
  final child;

  const MyPath({super.key, this.child, this.outColor, this.innerColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          padding: EdgeInsets.all(12),
          color: outColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                color: innerColor,
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
