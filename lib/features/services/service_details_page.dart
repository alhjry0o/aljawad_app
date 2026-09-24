import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_assets.dart';
import '../../core/localization/generated/app_localizations.dart';
import '../../core/widgets/app_button.dart';
import '../../core/providers/catalog_providers.dart';
import '../../core/routing/app_router.dart';
import '../../core/widgets/empty_state.dart';

class ServiceDetailsPage extends ConsumerWidget {
  const ServiceDetailsPage({super.key, required this.serviceId});
  final String serviceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final service = ref.watch(serviceByIdProvider(serviceId));

    if (service == null) {
      return Scaffold(
        appBar: AppBar(),
        body: EmptyState(icon: Icons.error_outline, title: l.genericError),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(service.name(isAr))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _ServiceImage(serviceId: service.id),
          const SizedBox(height: 16),
          Text(service.name(isAr),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  )),
          const SizedBox(height: 8),
          Text(service.description(isAr),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  )),
          const SizedBox(height: 20),
          _Section(title: l.serviceIncludes, items: service.features(isAr)),
          const SizedBox(height: 16),
          _Section(title: l.suitableSites, items: service.sites(isAr)),
          const SizedBox(height: 24),
          AppButton(
           label: l.requestService,
           icon: Icons.arrow_forward_rounded,
           onPressed: () => context.push(
             '${AppRoutes.serviceRequest}?serviceId=${service.id}',
           ),
         ),
         const SizedBox(height: 12),
         AppButton(
           label: l.requestQuotation,
           icon: Icons.request_quote_outlined,
           variant: AppButtonVariant.outline,
           onPressed: () => context.push(
             '${AppRoutes.quotation}?serviceId=${service.id}',
           ),
         ),
         const SizedBox(height: 12),
         AppButton(
           label: l.requestInspection,
           icon: Icons.fact_check_outlined,
           variant: AppButtonVariant.outline,
           onPressed: () => context.push(
             '${AppRoutes.inspection}?serviceId=${service.id}',
           ),
         ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                )),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final it in items)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Text(it, style: const TextStyle(fontSize: 12.5)),
              ),
          ],
        ),
      ],
    );
  }
}

class _ServiceImage extends StatelessWidget {
  const _ServiceImage({required this.serviceId});
  final String serviceId;

  @override
  Widget build(BuildContext context) {
    final path = AppAssets.serviceImage(serviceId);

    if (path == null) return _placeholder();

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        path,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B2545), Color(0xFF13315C)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, color: Colors.white70, size: 44),
    );
  }
}
