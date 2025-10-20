import 'package:capstone_app/providers/analysis_result_provider.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_text_field.dart';
import 'package:capstone_app/screens/input_child_data/widgets/gender_chip.dart';
import 'package:capstone_app/services/firestore_service.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/analysis_history.dart';
import '../../providers/input_child_data_provider.dart';
import '../analysis_result/analysis_result_page.dart';

class InputChildDataPage extends StatefulWidget {
  const InputChildDataPage({super.key});

  @override
  State<InputChildDataPage> createState() => _InputChildDataPageState();
}

class _InputChildDataPageState extends State<InputChildDataPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  // final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    // _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultState = context.watch<InputChildDataProvider>().uiState;

    if (resultState is UiErrorState<AnalysisHistory>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorMessage(resultState.errorMessage);
      });
    } else if (resultState is UiSuccessState<AnalysisHistory>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _toResultPage(resultState.data);
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Input Data Pengukuran')),
      body: Consumer<InputChildDataProvider>(
        builder: (context, provider, child) {
          return SafeArea(
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
                        const Text(
                          'Masukkan data anak balita Anda sesuai form di bawah untuk melakukan analisis.',
                          style: AppTextStyles.bodyLowEmText,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Nama Lengkap',
                          style: AppTextStyles.labelText,
                        ),
                        const SizedBox(height: 8),
                        CustomDefaultTextField(
                          controller: _nameController,
                          hint: 'Masukkan Nama Lengkap',
                          onChanged: (value) {
                            provider.changeFormCompletionStatus(
                              _checkAllFieldsFilled(),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildGenderRadio(provider),
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
                                  // Text(
                                  //   '* Usia maksimal 60 bulan',
                                  //   style: AppTextStyles.bodySmallLowEmText
                                  //       .copyWith(fontSize: 11),
                                  // ),
                                  // const SizedBox(height: 12),
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
                                      provider.changeIsAgeInputValid(
                                        age != null && age > 60,
                                      );
                                      provider.changeFormCompletionStatus(
                                        _checkAllFieldsFilled(),
                                      );
                                    },
                                  ),
                                  provider.isAgeInputValid
                                      ? Padding(
                                          padding: const EdgeInsetsGeometry.only(
                                            top: 8,
                                          ),
                                          child: Text(
                                            'Usia maksimal 60 bulan',
                                            style: AppTextStyles.captionText
                                                .copyWith(
                                                  color: Colors.redAccent,
                                                ),
                                          ),
                                        )
                                      : const SizedBox(),
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
                            // Expanded(
                            //   flex: 1,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       const Text(
                            //         'Berat Badan',
                            //         style: AppTextStyles.labelText,
                            //       ),
                            //       const SizedBox(height: 8),
                            //       CustomDefaultTextField(
                            //         controller: _weightController,
                            //         hint: '',
                            //         keyboardType: TextInputType.number,
                            //         isDigitOnly: true,
                            //         suffix: const Text(
                            //           'kg',
                            //           style: AppTextStyles.bodyLowEmText,
                            //         ),
                            //         onChanged: (value) {
                            //           provider.changeFormCompletionStatus(
                            //             _checkAllFieldsFilled(),
                            //           );
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(width: 12),
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
                                    onChanged: (value) {
                                      provider.changeFormCompletionStatus(
                                        _checkAllFieldsFilled(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(flex: 1, child: SizedBox()),
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
                    isEnabled: provider.isFormCompleted,
                    isLoading: provider.uiState is UiLoadingState,
                    onClick: () async {
                      provider.startAnalyze(
                        _nameController.text,
                        _ageController.text,
                        _heightController.text,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGenderRadio(InputChildDataProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Jenis Kelamin', style: AppTextStyles.labelText),
        const SizedBox(height: 8),
        Row(
          children: [
            GenderChip(
              label: 'Laki - Laki',
              isSelected: provider.selectedGender == 0,
              onClick: () {
                provider.changeSelectedGender(0);
              },
            ),
            const SizedBox(width: 12),
            GenderChip(
              label: 'Perempuan',
              isSelected: provider.selectedGender == 1,
              onClick: () {
                provider.changeSelectedGender(1);
              },
            ),
          ],
        ),
      ],
    );
  }

  bool _checkAllFieldsFilled() {
    var age = int.tryParse(_ageController.text);

    return _nameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        (age != null && age <= 60) &&
        // _weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty;
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
    context.read<InputChildDataProvider>().resetState();
  }

  void _toResultPage(AnalysisHistory data) {
    context.read<InputChildDataProvider>().resetState();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider(
            create: (context) =>
                AnalysisResultProvider(data, context.read<FirestoreService>()),
            child: const AnalysisResultPage(),
          );
        },
      ),
    );
  }
}
