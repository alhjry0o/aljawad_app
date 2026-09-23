import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/providers/requests_providers.dart';
import '../../core/routing/app_router.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/error_view.dart';
import '../../core/widgets/loading_view.dart';
import '../../data/models/service_request.dart';

class RequestsPage extends ConsumerWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final async = ref.watch(requestsListProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(l.myRequests,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      )),
            ),
          ),
          Expanded(
            child: async.when(
              loading: () => const LoadingView(),
              error: (_, __) => ErrorView(
                onRetry: () => ref.invalidate(requestsListProvider),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return EmptyState(
                    icon: Icons.inbox_outlined,
                    title: l.noRequests,
                    description: l.noRequestsDesc,
                    actionLabel: l.requestService,
                    onAction: () => context.push(AppRoutes.serviceRequest),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(requestsListProvider),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final r = list[i];
                      return _RequestCard(
                        request: r,
                        isAr: isAr,
                        onTap: () => context.push(
                          '${AppRoutes.requestDetails}/${r.id}',
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.request,
    required this.isAr,
    required this.onTap,
  });
  final ServiceRequest request;
  final bool isAr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    request.serviceName(isAr),
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                _StatusChip(statusKey: request.status),
              ],
            ),
            const SizedBox(height: 6),
            Text('${l.orderNumber}: ${request.id}',
                style: theme.textTheme.bodySmall),
            const SizedBox(height: 2),
            Text('${request.city} - ${request.district}',
                style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.statusKey});
  final Object statusKey;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final label = switch (statusKey.toString().split('.').last) {
      'received' => l.statusReceived,
      'underReview' => l.statusUnderReview,
      'awaitingInspection' => l.statusAwaitingInspection,
      'preparingQuote' => l.statusPreparingQuote,
      'scheduled' => l.statusScheduled,
      'inProgress' => l.statusInProgress,
      'completed' => l.statusCompleted,
      'cancelled' => l.statusCancelled,
      _ => l.statusSubmitted,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700)),
    );
  }
}