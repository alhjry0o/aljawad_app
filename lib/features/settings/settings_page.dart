import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/localization/generated/app_localizations.dart';
import '../../core/providers/app_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l.appearance,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: themeMode,
              title: Text(l.themeSystem),
              onChanged: (v) => ref.read(themeModeProvider.notifier).set(v!),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: themeMode,
              title: Text(l.themeLight),
              onChanged: (v) => ref.read(themeModeProvider.notifier).set(v!),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: themeMode,
              title: Text(l.themeDark),
              onChanged: (v) => ref.read(themeModeProvider.notifier).set(v!),
            ),
            const Divider(height: 32),
            Text(l.language, style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            RadioListTile<Locale>(
              value: const Locale('ar'),
              groupValue: locale,
              title: Text(l.languageArabic),
              onChanged: (v) => ref.read(localeProvider.notifier).set(v!),
            ),
            ListTile(
              title: Text(l.languageEnglish),
              subtitle: Text(l.languageEnglishNote),
              enabled: false,
            ),
            const Divider(height: 32),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text(l.notifications),
              subtitle: Text(l.notificationsNote),
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(l.privacy),
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(l.terms),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(l.appInfo),
              subtitle: const Text('Aljawad — 1.0.0 (Demo)'),
            ),
            const SizedBox(height: 12),
            Text(l.companyName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
            Text(AppConstants.companyWebsite,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}