import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/generated/app_localizations.dart';
import '../../core/providers/requests_providers.dart';
import '../../core/routing/app_router.dart';

class RequestSuccessPage extends ConsumerWidget {
  const RequestSuccessPage({super.key, required this.requestId});
  final String requestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final req = ref.watch(requestByIdProvider(requestId));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_outline,
                    color: AppColors.green, size: 56),
              ),
              const SizedBox(height: 20),
              Text(l.requestSuccessTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      )),
              const SizedBox(height: 8),
              Text(l.requestSuccessSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Theme.of(context).dividerTheme.color!),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('${l.orderNumber}: ',
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                        Expanded(
                          child: Text(requestId,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppColors.green,
                              )),
                        ),
                      ],
                    ),
                    if (req.valueOrNull != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('${l.selectService}: ',
                              style: const TextStyle(fontWeight: FontWeight.w700)),
                          Expanded(
                            child: Text(
                              req.valueOrNull!.serviceName(isAr),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => context.go(AppRoutes.home),
                child: Text(l.backHome),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.requests),
                child: Text(l.goToMyRequests),
              ),
            ],
          ),
        ),
      ),
    );
  }
}