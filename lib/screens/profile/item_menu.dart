import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

class ItemMenu extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onClick;

  const ItemMenu({
    super.key,
    required this.label,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 16),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: AppTextStyles.bodyText)),
            const SizedBox(width: 12),
            const Icon(Icons.chevron_right, color: Colors.black, size: 16),
          ],
        ),
      ),
    );
  }
}
