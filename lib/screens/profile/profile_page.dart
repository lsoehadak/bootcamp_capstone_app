import 'package:capstone_app/providers/profile_provider.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_card.dart';
import 'package:capstone_app/screens/common/widgets/custom_divider.dart';
import 'package:capstone_app/screens/login/login_page.dart';
import 'package:capstone_app/screens/profile/item_menu.dart';
import 'package:capstone_app/widgets/name_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ProfileProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDefaultCard(
                    content: Row(
                      children: [
                        NameAvatar(name: provider.user?.displayName ?? ''),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.user?.displayName ?? '',
                                style: AppTextStyles.titleText,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                provider.user?.email ?? '',
                                style: AppTextStyles.bodySmallText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Lainnya', style: AppTextStyles.sectionTitleText),
                  const SizedBox(height: 16),
                  CustomDefaultCard(
                    padding: EdgeInsets.zero,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemMenu(
                          label: 'Ubah Password',
                          icon: Icons.lock_outline_rounded,
                          onClick: () {},
                        ),
                        const DashedDivider(),
                        ItemMenu(
                          label: 'Bantuan',
                          icon: Icons.help_outline_outlined,
                          onClick: () {},
                        ),
                        const DashedDivider(),
                        ItemMenu(
                          label: 'Versi Aplikasi',
                          icon: Icons.info_outline_rounded,
                          onClick: () {},
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CustomDefaultButton(
                    label: 'Keluar',
                    onClick: () async {
                      final result = await provider.logout();
                      if (result) {
                        if (!context.mounted) return;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
