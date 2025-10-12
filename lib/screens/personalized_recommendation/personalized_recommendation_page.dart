import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PersonalizedRecommendationPage extends StatelessWidget {
  final String recommendationContent;

  const PersonalizedRecommendationPage({
    super.key,
    required this.recommendationContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rekomendasi Selanjutnya')),
      body: SafeArea(
        top: false,
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Html(data: recommendationContent),
        ),
      ),
    );
  }
}
