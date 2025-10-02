import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/child_model.dart';
import '../../providers/child_provider.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Form Controllers
  final _nameController = TextEditingController();
  final _nikController = TextEditingController();
  final _motherAgeController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _headCircController = TextEditingController();

  String _selectedGender = 'Laki-laki';
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _nikController.dispose();
    _motherAgeController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _headCircController.dispose();
    super.dispose();
  }

  int get _ageInMonths {
    if (_birthDate == null) return 0;
    final now = DateTime.now();
    final difference = now.difference(_birthDate!);
    return (difference.inDays / 30.44).round();
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365)),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
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

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
        _tabController.animateTo(_currentStep);
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _tabController.animateTo(_currentStep);
      });
    }
  }

  Future<void> _saveChild() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal lahir harus diisi')),
      );
      return;
    }

    final motherAge = int.tryParse(_motherAgeController.text);
    final weight = double.tryParse(_weightController.text) ?? 0.0;
    final height = double.tryParse(_heightController.text) ?? 0.0;
    final headCirc = double.tryParse(_headCircController.text) ?? 0.0;

    final newChild = ChildModel(
      nik: _nikController.text.trim(),
      name: _nameController.text.trim(),
      age: _ageInMonths,
      gender: _selectedGender,
      weight: weight,
      height: height,
      headCircumference: headCirc,
      motherAgeAtBirth: motherAge,
    );

    try {
      context.read<ChildProvider>().addChild(newChild);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data anak berhasil ditambahkan'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan data: $e'),
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
          'Tambah Data Anak',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Theme.of(context).colorScheme.onPrimary,
              unselectedLabelColor: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.6),
              labelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Data Diri'),
                Tab(text: 'Data Lahir'),
                Tab(text: 'Ringkasan'),
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDataDiriStep(),
                  _buildDataKelahiranStep(),
                  _buildRingkasanStep(),
                ],
              ),
            ),
          ),

          // Bottom Navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildDataDiriStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Diri Anak',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Masukkan informasi dasar tentang anak',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),

          _buildTextField(
            controller: _nameController,
            label: 'Nama Lengkap',
            icon: Icons.person_outline,
            validator: (value) =>
                value?.isEmpty == true ? 'Nama harus diisi' : null,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _nikController,
            label: 'NIK',
            icon: Icons.badge_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
            validator: (value) {
              if (value?.isEmpty == true) return 'NIK harus diisi';
              if (value!.length != 16) return 'NIK harus 16 digit';
              return null;
            },
          ),
          const SizedBox(height: 16),

          _buildDropdownField(),
          const SizedBox(height: 16),

          _buildDateField(),
          const SizedBox(height: 16),

          _buildTextField(
            controller: TextEditingController(
              text: _birthDate != null ? '$_ageInMonths bulan' : '',
            ),
            label: 'Usia (otomatis)',
            icon: Icons.cake_outlined,
            enabled: false,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _motherAgeController,
            label: 'Usia Ibu Saat Melahirkan (tahun)',
            icon: Icons.woman_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
    );
  }

  Widget _buildDataKelahiranStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Kelahiran',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Masukkan data pengukuran saat lahir',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),

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
                    'Data ini akan digunakan sebagai baseline untuk memantau pertumbuhan anak.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildTextField(
            controller: _weightController,
            label: 'Berat Badan (kg)',
            icon: Icons.monitor_weight_outlined,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value?.isEmpty == true) return 'Berat badan harus diisi';
              final weight = double.tryParse(value!);
              if (weight == null || weight <= 0) {
                return 'Berat badan tidak valid';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _heightController,
            label: 'Tinggi Badan (cm)',
            icon: Icons.height_outlined,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value?.isEmpty == true) return 'Tinggi badan harus diisi';
              final height = double.tryParse(value!);
              if (height == null || height <= 0) {
                return 'Tinggi badan tidak valid';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _headCircController,
            label: 'Lingkar Kepala (cm)',
            icon: Icons.face_outlined,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value?.isEmpty == true) return 'Lingkar kepala harus diisi';
              final headCirc = double.tryParse(value!);
              if (headCirc == null || headCirc <= 0) {
                return 'Lingkar kepala tidak valid';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRingkasanStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Periksa kembali data yang telah dimasukkan',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),

          _buildSummaryCard(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Diri',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Nama', _nameController.text),
          _buildSummaryRow('NIK', _nikController.text),
          _buildSummaryRow('Jenis Kelamin', _selectedGender),
          _buildSummaryRow(
            'Tanggal Lahir',
            _birthDate != null ? _formatDate(_birthDate!) : '-',
          ),
          _buildSummaryRow('Usia', '$_ageInMonths bulan'),
          _buildSummaryRow(
            'Usia Ibu',
            _motherAgeController.text.isNotEmpty
                ? '${_motherAgeController.text} tahun'
                : '-',
          ),

          const Divider(height: 32),

          Text(
            'Data Kelahiran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Berat Badan', '${_weightController.text} kg'),
          _buildSummaryRow('Tinggi Badan', '${_heightController.text} cm'),
          _buildSummaryRow('Lingkar Kepala', '${_headCircController.text} cm'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          Text(
            ': ',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '-',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      enabled: enabled,
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

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
        prefixIcon: Icon(
          Icons.wc_outlined,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Theme.of(
          context,
        ).colorScheme.surfaceContainer.withOpacity(0.3),
      ),
      items: ['Laki-laki', 'Perempuan'].map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedGender = newValue;
          });
        }
      },
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _selectBirthDate,
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
                _birthDate != null
                    ? _formatDate(_birthDate!)
                    : 'Pilih Tanggal Lahir',
                style: TextStyle(
                  fontSize: 16,
                  color: _birthDate != null
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Sebelumnya'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _currentStep == 2 ? _saveChild : _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                _currentStep == 2 ? 'Simpan Data' : 'Selanjutnya',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
