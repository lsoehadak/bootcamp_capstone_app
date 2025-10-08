import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_text_field.dart';
import 'package:capstone_app/screens/input_child_data/widgets/gender_chip.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../analysis_result/analysis_result_page.dart';

class InputChildDataPage extends StatefulWidget {
  const InputChildDataPage({super.key});

  @override
  State<InputChildDataPage> createState() => _InputChildDataPageState();
}

class _InputChildDataPageState extends State<InputChildDataPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Data Pengukuran')),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nama Lengkap', style: AppTextStyles.labelText),
                    const SizedBox(height: 8),
                    CustomDefaultTextField(
                      controller: _nameController,
                      hint: 'Masukkan Nama Lengkap',
                    ),
                    const SizedBox(height: 16),
                    _buildGenderRadio(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Usia Anak',
                                style: AppTextStyles.labelText,
                              ),
                              const SizedBox(height: 8),
                              CustomDefaultTextField(
                                controller: _ageController,
                                hint: '',
                                keyboardType: TextInputType.number,
                                isDigitOnly: true,
                                suffix: const Text(
                                  'bulan',
                                  style: AppTextStyles.bodyLowEmText,
                                ),
                                onChanged: (value) {
                                  var age = int.tryParse(value);
                                  if (age != null && age > 60) {
                                    _ageController.text = '60';
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Berat Badan',
                                style: AppTextStyles.labelText,
                              ),
                              const SizedBox(height: 8),
                              CustomDefaultTextField(
                                controller: _weightController,
                                hint: '',
                                keyboardType: TextInputType.number,
                                isDigitOnly: true,
                                suffix: const Text(
                                  'kg',
                                  style: AppTextStyles.bodyLowEmText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tinggi Badan',
                                style: AppTextStyles.labelText,
                              ),
                              const SizedBox(height: 8),
                              CustomDefaultTextField(
                                controller: _heightController,
                                hint: '',
                                keyboardType: TextInputType.number,
                                isDigitOnly: true,
                                suffix: const Text(
                                  'cm',
                                  style: AppTextStyles.bodyLowEmText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: CustomDefaultButton(
                label: 'Analisa',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnalysisResultPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Jenis Kelamin', style: AppTextStyles.labelText),
        const SizedBox(height: 8),
        Row(
          children: [
            GenderChip(label: 'Laki - Laki', isSelected: false, onClick: () {}),
            const SizedBox(width: 12),
            GenderChip(label: 'Perempuan', isSelected: true, onClick: () {}),
          ],
        ),
      ],
    );
  }
}
