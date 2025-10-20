import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../utils/constants.dart';

class TFLiteService {
  late Interpreter? _interpreter;
  late final Tensor inputTensor;
  late final Tensor outputTensor;

  final modelPath = 'assets/model.tflite';
  final labels = ['Normal', 'Sangat Pendek', 'Pendek', 'Tinggi'];

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
      inputTensor = _interpreter!.getInputTensor(0);
      outputTensor = _interpreter!.getOutputTensor(0);

      debugPrint('--- KONFIGURASI TENSOR ---');
      debugPrint(
        'Input Tensor (0): Shape=${inputTensor.shape}, Type=${inputTensor.type}.',
      );
      debugPrint(
        'Output Tensor (0): Shape=${outputTensor.shape}, Type=${outputTensor.type}.',
      );
    } catch (e) {
      debugPrint('Failed to load model: $e');
      throw Exception('Gagal memuat model TF Lite.');
    }
  }

  Future<String> predict({
    required int ageIntMonth,
    required int gender,
    required double height,
  }) async {
    if (_interpreter == null) throw ('Model belum dimuat');

    // pre-process data
    final normalizedAgeInMonth = (ageIntMonth - ageMean) / ageStd;
    final normalizedHeight = (height - heightMean) / heightStd;

    debugPrint('normalizedAge : $normalizedAgeInMonth');
    debugPrint('normalizedHeight : $normalizedHeight');

    final input = [
      [gender, normalizedAgeInMonth, normalizedHeight],
    ];
    var output = List<List<double>>.filled(
      1,
      List<double>.filled(labels.length, 0.0),
    );

    try {
      _interpreter!.run(input, output);
    } catch (e) {
      debugPrint('Failed to predict: $e');
      throw Exception('Gagal melakukan prediksi.');
    }

    final probabilities = output[0];
    print('--- HASIL INFERENSI (RAW OUTPUT) ---');
    print('Probabilitas mentah (4 kelas): $probabilities');
    print('Asumsi Label (sesuai urutan): $labels');

    int bestIndex = 0;
    double maxProb = probabilities[0];

    for (int i = 1; i < probabilities.length; i++) {
      if (probabilities[i] > maxProb) {
        maxProb = probabilities[i];
        bestIndex = i;
      }
    }

    return labels[bestIndex];
  }
}
