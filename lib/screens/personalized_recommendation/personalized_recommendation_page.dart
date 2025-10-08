import 'package:capstone_app/data/dummy_analysis_history_data.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PersonalizedRecommendationPage extends StatelessWidget {
  const PersonalizedRecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rekomendasi Selanjutnya')),
      body: const SafeArea(
        top: false,
        bottom: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Text(dummyRecommendationContent, style: AppTextStyles.bodyText,),
        ),
      )
    );
  }
}
