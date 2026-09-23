import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/providers/requests_providers.dart';
import '../../core/widgets/error_view.dart';
import '../../core/widgets/loading_view.dart';
import '../../data/models/request_status.dart';

class RequestDetailsPage extends ConsumerWidget {
  const RequestDetailsPage({super.key, required this.requestId});
  final String requestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final async = ref.watch(requestByIdProvider(requestId));

    return Scaffold(
      appBar: AppBar(title: Text(l.review)),
      body: async.when(
        loading: () => const LoadingView(),
        error: (_, __) => const ErrorView(),
        data: (r) {
          if (r == null) return ErrorView();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _row(l.orderNumber, r.id),
              _row(l.selectService, r.serviceName(isAr)),
              _row(l.siteType, r.siteTypeKey),
              _row(l.city, r.city),
              if (r.district.isNotEmpty) _row(l.district, r.district),
              if (r.address.isNotEmpty) _row(l.address, r.address),
              if (r.dateIso != null) _row(l.preferredDate, r.dateIso!),
              if (r.timeLabel != null) _row(l.preferredTime, r.timeLabel!),
              if (r.details.isNotEmpty) _row(l.details, r.details),
              _row(l.uploadImages, '${r.imagePaths.length}'),
              _row(l.fullName, r.customerName),
              _row(l.phone, r.customerPhone),
              _row(l.status, _statusLabel(l, r.status)),
              const SizedBox(height: 20),
              Text(l.status,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              _Timeline(status: r.status),
            ],
          );
        },
      ),
    );
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(k,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          ),
          Expanded(child: Text(v, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  String _statusLabel(AppLocalizations l, RequestStatus s) => switch (s) {
        RequestStatus.submitted => l.statusSubmitted,
        RequestStatus.received => l.statusReceived,
        RequestStatus.underReview => l.statusUnderReview,
        RequestStatus.awaitingInspection => l.statusAwaitingInspection,
        RequestStatus.preparingQuote => l.statusPreparingQuote,
        RequestStatus.scheduled => l.statusScheduled,
        RequestStatus.inProgress => l.statusInProgress,
        RequestStatus.completed => l.statusCompleted,
        RequestStatus.cancelled => l.statusCancelled,
      };
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.status});
  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final steps = [
      RequestStatus.submitted,
      RequestStatus.received,
      RequestStatus.underReview,
      RequestStatus.scheduled,
      RequestStatus.inProgress,
      RequestStatus.completed,
    ];
    final current = steps.indexOf(status);
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          Row(
            children: [
              Icon(
                i <= current
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: i <= current
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(_label(l, steps[i]),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: i == current
                            ? FontWeight.w800
                            : FontWeight.w500,
                      )),
                ),
              ),
            ],
          ),
      ],
    );
  }

  String _label(AppLocalizations l, RequestStatus s) => switch (s) {
        RequestStatus.submitted => l.statusSubmitted,
        RequestStatus.received => l.statusReceived,
        RequestStatus.underReview => l.statusUnderReview,
        RequestStatus.awaitingInspection => l.statusAwaitingInspection,
        RequestStatus.preparingQuote => l.statusPreparingQuote,
        RequestStatus.scheduled => l.statusScheduled,
        RequestStatus.inProgress => l.statusInProgress,
        RequestStatus.completed => l.statusCompleted,
        RequestStatus.cancelled => l.statusCancelled,
      };
}