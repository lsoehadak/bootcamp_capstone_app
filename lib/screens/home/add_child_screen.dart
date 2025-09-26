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
    if (!_formKey.currentState!.validate()) return;

    int? parseIntSafe(String value) => int.tryParse(value);
    double? parseDoubleSafe(String value) => double.tryParse(value);

    final age = parseIntSafe(_ageController.text) ?? 0;
    final weight = parseDoubleSafe(_weightController.text) ?? 0.0;
    final height = parseDoubleSafe(_heightController.text) ?? 0.0;
    final headCirc = parseDoubleSafe(_headCircumferenceController.text) ?? 0.0;

    final newChild = ChildModel(
      nik: _nikController.text.trim(),
      name: _nameController.text.trim(),
      age: age,
      gender: _selectedGender,
      weight: weight,
      height: height,
      headCircumference: headCirc,
    );

    final provider = Provider.of<ChildProvider>(context, listen: false);
    await provider.addChild(newChild);
    if (mounted) Navigator.of(context).pop();
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
                initialValue: _selectedGender,
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
              Consumer<ChildProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: provider.isLoading ? null : _saveChild,
                    child: provider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Simpan'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
