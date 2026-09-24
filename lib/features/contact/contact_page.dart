import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/localization/generated/app_localizations.dart';
import '../../core/utils/launcher.dart';
import '../../core/widgets/app_button.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _safe(BuildContext context, Future<bool> f) async {
    final ok = await f;
    if (!context.mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('غير متاح على هذه البيئة')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.contactUs)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _tile(
              context,
              icon: Icons.location_on_outlined,
              title: l.companyLocation,
              subtitle: AppConstants.companyAddressAr,
              onTap: () => _safe(context, Launcher.maps(AppConstants.companyMapsQuery)),
            ),
            _tile(
              context,
              icon: Icons.call_outlined,
              title: l.callPhone,
              subtitle: AppConstants.companyPhone,
              onTap: () => _safe(context, Launcher.tel(AppConstants.companyPhone)),
            ),
            _tile(
              context,
              icon: Icons.phone_android_outlined,
              title: l.callMobile,
              subtitle: AppConstants.companyMobile1,
              onTap: () => _safe(context, Launcher.tel(AppConstants.companyMobile1)),
            ),
            _tile(
              context,
              icon: Icons.phone_android_outlined,
              title: l.callMobile,
              subtitle: AppConstants.companyMobile2,
              onTap: () => _safe(context, Launcher.tel(AppConstants.companyMobile2)),
            ),
            _tile(
              context,
              icon: Icons.chat_outlined,
              title: l.whatsapp,
              subtitle: '+966 55 424 1982',
              onTap: () => _safe(
                  context, Launcher.whatsapp(AppConstants.companyWhatsapp)),
            ),
            _tile(
              context,
              icon: Icons.email_outlined,
              title: l.email,
              subtitle: AppConstants.companyEmail,
              onTap: () =>
                  _safe(context, Launcher.mail(AppConstants.companyEmail)),
            ),
            _tile(
              context,
              icon: Icons.public,
              title: 'aljawadservices.com',
              subtitle: AppConstants.companyWebsite,
              onTap: () =>
                  _safe(context, Launcher.website(AppConstants.companyWebsite)),
            ),
            const SizedBox(height: 20),
            Text(l.sendMessage,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            const _ContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _subject = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final l = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l.messageSentDemo)));
    _name.clear();
    _phone.clear();
    _subject.clear();
    _message.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: l.fullName),
            validator: (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _phone,
            decoration: InputDecoration(labelText: l.phone),
            keyboardType: TextInputType.phone,
            validator: (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _subject,
            decoration: InputDecoration(labelText: l.subject),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _message,
            maxLines: 4,
            decoration: InputDecoration(labelText: l.message),
          ),
          const SizedBox(height: 14),
          AppButton(
            label: l.sendMessage,
            icon: Icons.send_rounded,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
