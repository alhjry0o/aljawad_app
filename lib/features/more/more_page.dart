import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/localization/generated/app_localizations.dart';
import '../../core/routing/app_router.dart';
import '../../core/utils/launcher.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(l.navMore,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    )),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l.aboutAljawad),
            onTap: () => context.push(AppRoutes.about),
          ),
          ListTile(
            leading: const Icon(Icons.headset_mic_outlined),
            title: Text(l.contactUs),
            onTap: () => context.push(AppRoutes.contact),
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: Text(l.companyLocation),
            subtitle: Text(AppConstants.companyAddressAr),
            onTap: () => Launcher.maps(AppConstants.companyMapsQuery),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(l.settings),
            onTap: () => context.push(AppRoutes.settings),
          ),
          const Divider(height: 24),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l.privacy),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l.terms),
          ),
          ListTile(
            leading: const Icon(Icons.apps_outlined),
            title: Text(l.appInfo),
            subtitle: const Text('Aljawad — 1.0.0 (Demo)'),
          ),
        ],
      ),
    );
  }
}