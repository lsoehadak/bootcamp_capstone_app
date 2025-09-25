import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/child_provider.dart';
import '../../providers/tips_provider.dart';
import 'add_child_screen.dart';
import '../child/child_detail_screen.dart';
import '../../widgets/child_card.dart'; // Assuming you have this widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of children for display
    final childProvider = Provider.of<ChildProvider>(context);
    final tipsProvider = Provider.of<TipsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome User
              Text(
                "Selamat Datang,",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Nama Pengguna", // Replace with actual user name from AuthProvider
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Tips Card
              Card(
                color: Colors.blue.shade50,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.blue.shade800, size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tips Gizi Hari Ini",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tipsProvider.randomTip,
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Children List Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daftar Anak",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: View All Children
                    },
                    child: const Text("Lihat Semua"),
                  )
                ],
              ),
              const SizedBox(height: 8),

              // Children List
              Consumer<ChildProvider>(
                builder: (context, provider, child) {
                  if (provider.children.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Text("Belum ada data anak. Tekan tombol + untuk menambah."),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.children.length,
                    itemBuilder: (context, index) {
                      final child = provider.children[index];
                      return ChildCard(
                        child: child,
                        onTap: () {
                          provider.setActiveChild(child);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ChildDetailScreen(),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddChildScreen()));
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Anak',
      ),
    );
  }
}
