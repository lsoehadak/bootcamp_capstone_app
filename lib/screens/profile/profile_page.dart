import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_card.dart';
import 'package:capstone_app/screens/common/widgets/custom_divider.dart';
import 'package:capstone_app/screens/profile/item_menu.dart';
import 'package:capstone_app/widgets/name_avatar.dart';
import 'package:flutter/material.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDefaultCard(
                content: Row(
                  children: [
                    NameAvatar(name: 'Luthfi Soehadak'),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Luthfi Soehadak',
                            style: AppTextStyles.titleText,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'lsoehadak@gmail.com',
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
              CustomDefaultButton(label: 'Keluar', onClick: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
