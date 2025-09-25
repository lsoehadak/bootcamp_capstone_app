import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/child_model.dart';
import '../../providers/child_provider.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  _AddChildScreenState createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _headCircumferenceController = TextEditingController();
  String _selectedGender = 'Laki-laki';

  @override
  void dispose() {
    _nikController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _headCircumferenceController.dispose();
    super.dispose();
  }

  Future<void> _saveChild() async {
    if (_formKey.currentState!.validate()) {
      final newChild = ChildModel(
        nik: _nikController.text,
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: _selectedGender,
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
        headCircumference: double.parse(_headCircumferenceController.text),
      );
      await Provider.of<ChildProvider>(
        context,
        listen: false,
      ).addChild(newChild);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Data Anak")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nikController,
                decoration: const InputDecoration(labelText: 'NIK'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Usia (bulan)'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Laki-laki', 'Perempuan'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) =>
                    setState(() => _selectedGender = newValue!),
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Berat Badan (kg)',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _headCircumferenceController,
                decoration: const InputDecoration(
                  labelText: 'Lingkar Kepala (cm)',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChild,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
