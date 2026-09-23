import 'package:flutter/material.dart';

import '../../core/localization/generated/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final fields = [
      (Icons.cleaning_services_outlined, l.fieldCleaning),
      (Icons.window_outlined, l.fieldFacades),
      (Icons.factory_outlined, l.fieldIndustrial),
      (Icons.pool_outlined, l.fieldPools),
      (Icons.pest_control_outlined, l.fieldPest),
      (Icons.water_drop_outlined, l.fieldInsulation),
      (Icons.plumbing_outlined, l.fieldMaintenance),
      (Icons.groups_2_outlined, l.fieldManpower),
      (Icons.apartment_outlined, l.fieldFacilities),
      (Icons.construction_outlined, l.fieldEquipment),
      (Icons.engineering_outlined, l.fieldConstruction),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.aboutAljawad)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l.companyName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    )),
            const SizedBox(height: 10),
            Text(l.aboutIntro, style: const TextStyle(height: 1.7)),
            const SizedBox(height: 20),
            Text(l.aboutFieldsTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    )),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final f in fields)
                  Chip(
                    avatar: Icon(f.$1, size: 18),
                    label: Text(f.$2),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}