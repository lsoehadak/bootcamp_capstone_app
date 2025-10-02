import 'package:flutter/material.dart';
import '../../models/child_model.dart';
import '../../models/child_tracking_model.dart';

class AddTrackingScreen extends StatefulWidget {
  final ChildModel child;

  const AddTrackingScreen({super.key, required this.child});

  @override
  State<AddTrackingScreen> createState() => _AddTrackingScreenState();
}

class _AddTrackingScreenState extends State<AddTrackingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _headCircController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _measurementDate = DateTime.now();

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _headCircController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  int get _currentAgeInMonths {
    final now = DateTime.now();
    final birthDate = now.subtract(
      Duration(days: (widget.child.age * 30.44).round()),
    );
    final difference = _measurementDate.difference(birthDate);
    return (difference.inDays / 30.44).round();
  }

  Future<void> _selectMeasurementDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _measurementDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _measurementDate) {
      setState(() {
        _measurementDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _saveTracking() async {
    if (!_formKey.currentState!.validate()) return;

    final weight = double.parse(_weightController.text);
    final height = double.parse(_heightController.text);
    final headCirc = double.parse(_headCircController.text);

    // Calculate status using the model's static method
    final status = ChildTrackingModel.calculateStatus(
      weight,
      height,
      headCirc,
      _currentAgeInMonths,
      widget.child.gender,
    );

    final newTracking = ChildTrackingModel(
      childNik: widget.child.nik,
      measurementDate: _measurementDate,
      weight: weight,
      height: height,
      headCircumference: headCirc,
      ageInMonths: _currentAgeInMonths,
      status: status,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    try {
      // Return the tracking data to be handled by the parent screen
      Navigator.of(context).pop(newTracking);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Tambah Data Perkembangan',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Child Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        widget.child.name[0].toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.child.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            'NIK: ${widget.child.nik}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            'Usia: ${widget.child.age} bulan',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Data Pengukuran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Masukkan hasil pengukuran terbaru anak',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 24),

              // Measurement Date
              _buildDateField(),
              const SizedBox(height: 16),

              // Age at measurement
              _buildTextField(
                controller: TextEditingController(
                  text: '$_currentAgeInMonths bulan',
                ),
                label: 'Usia saat pengukuran',
                icon: Icons.cake_outlined,
                enabled: false,
              ),
              const SizedBox(height: 16),

              // Weight
              _buildTextField(
                controller: _weightController,
                label: 'Berat Badan (kg)',
                icon: Icons.monitor_weight_outlined,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value?.isEmpty == true) return 'Berat badan harus diisi';
                  final weight = double.tryParse(value!);
                  if (weight == null || weight <= 0)
                    return 'Berat badan tidak valid';
                  if (weight > 50) return 'Berat badan terlalu tinggi';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Height
              _buildTextField(
                controller: _heightController,
                label: 'Tinggi Badan (cm)',
                icon: Icons.height_outlined,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value?.isEmpty == true) return 'Tinggi badan harus diisi';
                  final height = double.tryParse(value!);
                  if (height == null || height <= 0)
                    return 'Tinggi badan tidak valid';
                  if (height > 200) return 'Tinggi badan terlalu tinggi';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Head Circumference
              _buildTextField(
                controller: _headCircController,
                label: 'Lingkar Kepala (cm)',
                icon: Icons.face_outlined,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value?.isEmpty == true)
                    return 'Lingkar kepala harus diisi';
                  final headCirc = double.tryParse(value!);
                  if (headCirc == null || headCirc <= 0)
                    return 'Lingkar kepala tidak valid';
                  if (headCirc > 60) return 'Lingkar kepala terlalu besar';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Notes
              _buildTextField(
                controller: _notesController,
                label: 'Catatan (opsional)',
                icon: Icons.note_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Status pertumbuhan akan dihitung otomatis berdasarkan data yang dimasukkan.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTracking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Simpan Data Perkembangan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool enabled = true,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      style: TextStyle(
        color: enabled
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: enabled
            ? Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.3)
            : Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.1),
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _selectMeasurementDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainer.withOpacity(0.3),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _formatDate(_measurementDate),
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
