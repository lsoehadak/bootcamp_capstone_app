import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 2.0,
      dashGapLength: 2,
      dashColor: Colors.black.withOpacity(0.2),
    );
  }
}