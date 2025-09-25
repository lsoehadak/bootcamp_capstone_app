import 'package:flutter/material.dart';
import '../models/child_model.dart';

class ChildCard extends StatelessWidget {
  final ChildModel child;
  final VoidCallback onTap;

  const ChildCard({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(child: Text(child.name.substring(0, 1))),
        title: Text(child.name),
        subtitle: Text("Usia: ${child.age} bulan"),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
