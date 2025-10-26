import 'package:capstone_app/screens/common/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsapp(BuildContext context, String displayName) async {
  const String cleanedNumber = '+6285134703582';
  final String defaultMessage =
      'Halo saya $displayName, ingin bertanya tentang ...';

  final String encodedMessage = Uri.encodeComponent(defaultMessage);
  final Uri whatsappUrl = Uri.parse(
    'https://wa.me/$cleanedNumber?text=$encodedMessage',
  );

  try {
    final bool launched = await launchUrl(
      whatsappUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      if (!context.mounted) return;
      showSnackBar(
        context,
        'Gagal Membuka Bantuan',
        'Tidak dapat membuka browser atau aplikasi',
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    showSnackBar(
      context,
      'Gagal Membuka Bantuan',
      'Terjadi kesalahan saat mencoba membuka link.',
    );
    debugPrint('Error launching URL: $e');
  }
}
