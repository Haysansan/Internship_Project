import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.contactUs.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColor.red));
        }

        final info = controller.contactUs.value;
        if (info == null) {
          return Center(child: Text('No data', style: AppTextStyle.normalGreyRegular));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // Company logo placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.business, size: 40, color: AppColor.primary),
              ),
              const SizedBox(height: 16),

              // Company name
              if (info.name.isNotEmpty)
                Text(
                  info.name,
                  style: AppTextStyle.largePrimaryBold,
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),

              // Address
              if (info.address.isNotEmpty)
                _ContactRow(
                  icon: Icons.location_on_outlined,
                  label: info.address,
                  onTap: () => _launch('https://maps.google.com/?q=${Uri.encodeComponent(info.address)}'),
                ),

              // Phone
              if (info.phone.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ContactRow(
                  icon: Icons.phone_outlined,
                  label: info.phone,
                  onTap: () => _launch('tel:${info.phone.split('/').first.replaceAll(' ', '').trim()}'),
                ),
              ],

              // Email
              if (info.email.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ContactRow(
                  icon: Icons.email_outlined,
                  label: info.email,
                  onTap: () => _launch('mailto:${info.email}'),
                ),
              ],

              // Website
              if (info.website.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ContactRow(
                  icon: Icons.language_outlined,
                  label: info.website,
                  onTap: () => _launch(info.website),
                ),
              ],

              // Telegram
              if (info.telegram.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ContactRow(
                  icon: Icons.send_outlined,
                  label: info.telegram,
                  onTap: () => _launch(info.telegram),
                ),
              ],

              // Facebook
              if (info.facebook.isNotEmpty) ...[
                const SizedBox(height: 16),
                _ContactRow(
                  icon: Icons.facebook_outlined,
                  label: info.facebook,
                  onTap: () => _launch(info.facebook),
                ),
              ],

              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }
}

Future<void> _launch(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColor.red, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.normalPrimaryRegular.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Icon(Icons.open_in_new, size: 14, color: Colors.blue),
        ],
      ),
    );
  }
}
