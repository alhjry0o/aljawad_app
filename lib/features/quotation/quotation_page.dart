import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/requests_providers.dart';
import '../../core/routing/app_router.dart';
import '../../core/utils/validators.dart';
import '../../data/datasources/services_catalog.dart';
import '../../data/models/request_status.dart';
import '../../data/models/service_request.dart';

class QuotationPage extends ConsumerStatefulWidget {
  const QuotationPage({super.key, this.initialServiceId});
  final String? initialServiceId;

  @override
  ConsumerState<QuotationPage> createState() => _QuotationPageState();
}

class _QuotationPageState extends ConsumerState<QuotationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _serviceId;
  final _city = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _serviceId = widget.initialServiceId ?? ServicesCatalog.categories.first.services.first.id;
  }

  @override
  void dispose() {
    _city.dispose();
    _address.dispose();
    _notes.dispose();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      final s = ServicesCatalog.findById(_serviceId!)!;
      final now = DateTime.now();
      final id = 'JW-Q-${now.millisecondsSinceEpoch.toString().substring(6)}';
      final req = ServiceRequest(
        id: id,
        kind: RequestKind.quotation,
        serviceId: s.id,
        serviceNameAr: s.nameAr,
        serviceNameEn: s.nameEn,
        siteTypeKey: 'siteOther',
        city: _city.text.trim(),
        district: '',
        address: _address.text.trim(),
        details: _notes.text.trim(),
        dateIso: null,
        timeLabel: null,
        imagePaths: const [],
        customerName: _name.text.trim(),
        customerPhone: _phone.text.trim(),
        status: RequestStatus.submitted,
        createdAtIso: now.toIso8601String(),
      );
      await ref.read(requestsRepositoryProvider).create(req);
      ref.read(requestsRefreshProvider.notifier).bump();
      ref.invalidate(requestsListProvider);
      if (!mounted) return;
      context.pushReplacement('${AppRoutes.requestSuccess}?id=$id');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(l.quotationTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              Text(l.quotationNote,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _serviceId,
                decoration: InputDecoration(labelText: l.selectService),
                items: [
                  for (final c in ServicesCatalog.categories)
                    for (final s in c.services)
                      DropdownMenuItem(value: s.id, child: Text(s.name(isAr))),
                ],
                onChanged: (v) => setState(() => _serviceId = v),
                validator: (v) => v == null ? l.requiredField : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _city,
                decoration: InputDecoration(labelText: l.city),
                validator: (v) => Validators.required(v) == null ? null : l.requiredField,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _address,
                decoration: InputDecoration(labelText: l.address),
                validator: (v) => Validators.required(v) == null ? null : l.requiredField,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notes,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: l.details,
                  hintText: l.detailsHint,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: l.fullName),
                validator: (v) => Validators.name(v) == null ? null : l.invalidName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: l.phone),
                validator: (v) => Validators.phone(v) == null ? null : l.invalidPhone,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}