import 'package:flutter/material.dart';

class AddMeasurementScreen extends StatefulWidget {
  final String childId;
  const AddMeasurementScreen({super.key, required this.childId});

  @override
  _AddMeasurementScreenState createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final _formKey = GlobalKey<FormState>();
  // Add controllers for weight, height, head circumference

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pengukuran Bulanan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Add form fields for new measurement
              Text(
                "Form untuk menambah data pengukuran anak dengan ID: ${widget.childId}",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to save measurement
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
