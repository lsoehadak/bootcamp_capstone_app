import 'package:flutter/material.dart';

class CustomDefaultCard extends StatelessWidget {
  final Widget content;
  final EdgeInsets padding;

  const CustomDefaultCard({
    super.key,
    required this.content,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: content,
    );
  }
}