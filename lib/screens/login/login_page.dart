import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_card.dart';
import 'package:capstone_app/screens/common/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

import '../common/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  var emailController = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomDefaultTextField(
                  controller: TextEditingController(),
                  hint: 'hint',
                  suffix: Text('bulan', style: AppTextStyles.bodyLowEmText,),
                  onSubmit: (value) {},
                ),
                const SizedBox(height: 16),
                CustomPasswordTextField(
                  controller: emailController,
                  hint: 'hint',
                  isObscure: isObscure,
                  onReveal: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomDefaultButton(
                  label: 'Submit',
                  isLoading: isLoading,
                  onClick: () {
                    setState(() {
                      isLoading = true;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomCompactOutlinedButton(
                  label: 'Get Recommendation',
                  height: 36,
                  textStyle: AppTextStyles.bodySmallText.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainThemeColor,
                  ),
                  onClick: () {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                const DashedDivider(),
                const SizedBox(height: 16),
                CustomDefaultCard(
                  padding: EdgeInsets.zero,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(color: Colors.red, width: 30, height: 30),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Budi Darmawan',
                              style: AppTextStyles.bodyHiEmText,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Laki - Laki',
                              style: AppTextStyles.captionLowEmText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
