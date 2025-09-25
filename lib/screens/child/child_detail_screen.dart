import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/child_provider.dart';
import '../../widgets/status_indicator.dart'; // Assuming you have this widget
// import 'package:fl_chart/fl_chart.dart'; // Add this for charts

class ChildDetailScreen extends StatelessWidget {
  const ChildDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final child = Provider.of<ChildProvider>(context).activeChild;

    if (child == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("No child selected.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(child.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Indicator
            StatusIndicator(status: 'Hijau'), // Dummy status
            const SizedBox(height: 20),

            // Child Info
            Text(
              "Nama: ${child.name}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text("Usia: ${child.age} bulan"),
            Text(
              "BB: ${child.weight} kg, TB: ${child.height} cm, LK: ${child.headCircumference} cm",
            ),

            const SizedBox(height: 20),
            Text(
              "Grafik Perkembangan (Z-Score)",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // Placeholder for chart
            Container(
              height: 200,
              color: Colors.grey[200],
              child: const Center(child: Text("Chart placeholder")),
            ),

            const SizedBox(height: 20),
            Text(
              "Riwayat Pengukuran",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // Placeholder for measurement history
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Dummy count
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Pengukuran ${index + 1}"),
                    subtitle: Text("BB: 8.${index}kg, TB: 7${index}cm"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add measurement screen
        },
        child: const Icon(Icons.add_chart),
        tooltip: 'Tambah Pengukuran',
      ),
    );
  }
}
