import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/requests_providers.dart';
import '../../core/routing/app_router.dart';
import '../../core/utils/validators.dart';
import '../../data/datasources/services_catalog.dart';
import '../../data/models/request_status.dart';
import '../../data/models/service_request.dart';

class ServiceRequestPage extends ConsumerStatefulWidget {
  const ServiceRequestPage({super.key, this.initialServiceId});
  final String? initialServiceId;

  @override
  ConsumerState<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends ConsumerState<ServiceRequestPage> {
  int _step = 0;
  static const int _totalSteps = 8;

  String? _serviceId;
  String? _siteType;
  final _city = TextEditingController();
  final _district = TextEditingController();
  final _address = TextEditingController();
  final _details = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  DateTime? _date;
  TimeOfDay? _time;
  final List<String> _images = [];
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _serviceId = widget.initialServiceId;
  }

  @override
  void dispose() {
    _city.dispose();
    _district.dispose();
    _address.dispose();
    _details.dispose();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  bool get _canNext {
    switch (_step) {
      case 0:
        return _serviceId != null;
      case 1:
        return _siteType != null;
      case 2:
        return _city.text.trim().isNotEmpty &&
            _district.text.trim().isNotEmpty &&
            _address.text.trim().isNotEmpty;
      case 3:
        return _date != null && _time != null;
      case 4:
        return true;
      case 5:
        return true;
      case 6:
        return Validators.name(_name.text) == null &&
            Validators.phone(_phone.text) == null;
      default:
        return true;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final x = await picker.pickImage(source: source, imageQuality: 75);
      if (x != null) setState(() => _images.add(x.path));
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('غير متاح على هذه البيئة')),
        );
      }
    }
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      final service = ServicesCatalog.findById(_serviceId!)!;
      final now = DateTime.now();
      final id = 'JW-${now.millisecondsSinceEpoch.toString().substring(5)}';
      final req = ServiceRequest(
        id: id,
        kind: RequestKind.service,
        serviceId: service.id,
        serviceNameAr: service.nameAr,
        serviceNameEn: service.nameEn,
        siteTypeKey: _siteType ?? 'siteOther',
        city: _city.text.trim(),
        district: _district.text.trim(),
        address: _address.text.trim(),
        details: _details.text.trim(),
        dateIso: _date?.toIso8601String(),
        timeLabel: _time == null
            ? null
            : '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}',
        imagePaths: List.unmodifiable(_images),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(l.requestService),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_step + 1) / _totalSteps,
            minHeight: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(l.stepOf(_step + 1, _totalSteps),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: _buildStep(context, l),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _submitting
                            ? null
                            : () => setState(() => _step--),
                        child: Text(l.back),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: !_canNext || _submitting
                          ? null
                          : () {
                              if (_step < _totalSteps - 1) {
                                setState(() => _step++);
                              } else {
                                _submit();
                              }
                            },
                      child: _submitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_step == _totalSteps - 1
                              ? l.confirmSubmit
                              : l.next),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, AppLocalizations l) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    switch (_step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.selectService,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            for (final c in ServicesCatalog.categories)
              ExpansionTile(
                title: Text(c.name(isAr)),
                children: [
                  for (final s in c.services)
                    RadioListTile<String>(
                      value: s.id,
                      groupValue: _serviceId,
                      title: Text(s.name(isAr)),
                      onChanged: (v) => setState(() => _serviceId = v),
                    ),
                ],
              ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.siteType,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final key in ServicesCatalog.siteTypeKeys)
                  ChoiceChip(
                    label: Text(_siteTypeLabel(l, key)),
                    selected: _siteType == key,
                    onSelected: (_) => setState(() => _siteType = key),
                  ),
              ],
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.location,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            TextField(
              controller: _city,
              decoration: InputDecoration(labelText: l.city),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _district,
              decoration: InputDecoration(labelText: l.district),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _address,
              decoration: InputDecoration(labelText: l.address),
              onChanged: (_) => setState(() {}),
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.preferredDate,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () async {
                final d = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: _date ?? DateTime.now(),
                );
                if (d != null) setState(() => _date = d);
              },
              icon: const Icon(Icons.calendar_today_outlined),
              label: Text(_date == null
                  ? l.pickDate
                  : '${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}'),
            ),
            const SizedBox(height: 16),
            Text(l.preferredTime,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: _time ?? TimeOfDay.now(),
                );
                if (t != null) setState(() => _time = t);
              },
              icon: const Icon(Icons.access_time),
              label: Text(_time == null
                  ? l.pickTime
                  : '${_time!.hour.toString().padLeft(2, '0')}:${_time!.minute.toString().padLeft(2, '0')}'),
            ),
          ],
        );
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.details,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            TextField(
              controller: _details,
              maxLines: 6,
              decoration: InputDecoration(hintText: l.detailsHint),
            ),
          ],
        );
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.uploadImages,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: Text(l.gallery),
                ),
                const SizedBox(width: 10),
                if (!kIsWeb)
                  OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: Text(l.camera),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var i = 0; i < _images.length; i++)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: kIsWeb
                            ? Image.network(_images[i],
                                width: 90, height: 90, fit: BoxFit.cover)
                            : Image.file(File(_images[i]),
                                width: 90, height: 90, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => setState(() => _images.removeAt(i)),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close,
                                color: Colors.white, size: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        );
      case 6:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.customerInfo,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: l.fullName),
              onChanged: (_) => setState(() {}),
              errorText: _name.text.isEmpty
                  ? null
                  : Validators.name(_name.text) == null
                      ? null
                      : l.invalidName,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: l.phone),
              onChanged: (_) => setState(() {}),
              errorText: _phone.text.isEmpty
                  ? null
                  : Validators.phone(_phone.text) == null
                      ? null
                      : l.invalidPhone,
            ),
          ],
        );
      default:
        return _Review(
          serviceId: _serviceId,
          siteType: _siteType,
          city: _city.text,
          district: _district.text,
          address: _address.text,
          date: _date,
          time: _time,
          details: _details.text,
          images: _images.length,
          name: _name.text,
          phone: _phone.text,
        );
    }
  }

  String _siteTypeLabel(AppLocalizations l, String key) {
    switch (key) {
      case 'siteHome':
        return l.siteHome;
      case 'siteVilla':
        return l.siteVilla;
      case 'sitePalace':
        return l.sitePalace;
      case 'siteOffice':
        return l.siteOffice;
      case 'siteHotel':
        return l.siteHotel;
      case 'siteHospital':
        return l.siteHospital;
      case 'siteFactory':
        return l.siteFactory;
      case 'siteWarehouse':
        return l.siteWarehouse;
      case 'siteBuilding':
        return l.siteBuilding;
      case 'siteParking':
        return l.siteParking;
      default:
        return l.siteOther;
    }
  }
}

class _Review extends StatelessWidget {
  const _Review({
    required this.serviceId,
    required this.siteType,
    required this.city,
    required this.district,
    required this.address,
    required this.date,
    required this.time,
    required this.details,
    required this.images,
    required this.name,
    required this.phone,
  });

  final String? serviceId;
  final String? siteType;
  final String city;
  final String district;
  final String address;
  final DateTime? date;
  final TimeOfDay? time;
  final String details;
  final int images;
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final s = serviceId == null ? null : ServicesCatalog.findById(serviceId!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.review, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        _row(context, l.selectService, s?.name(isAr) ?? '-'),
        _row(context, l.siteType, siteType ?? '-'),
        _row(context, l.city, city),
        _row(context, l.district, district),
        _row(context, l.address, address),
        _row(
            context,
            l.preferredDate,
            date == null
                ? '-'
                : '${date!.year}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}'),
        _row(context, l.preferredTime,
            time == null ? '-' : '${time!.hour}:${time!.minute}'),
        _row(context, l.details, details.isEmpty ? '-' : details),
        _row(context, l.uploadImages, '$images'),
        _row(context, l.fullName, name),
        _row(context, l.phone, phone),
      ],
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 13)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
