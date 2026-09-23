import 'package:flutter_test/flutter_test.dart';
import 'package:aljawad_services/data/models/request_status.dart';
import 'package:aljawad_services/data/models/service_request.dart';

void main() {
  test('ServiceRequest JSON round-trip preserves data', () {
    final r = ServiceRequest(
      id: 'JW-1',
      kind: RequestKind.service,
      serviceId: 'cleaning_deep',
      serviceNameAr: 'التنظيف العميق',
      serviceNameEn: 'Deep cleaning',
      siteTypeKey: 'siteVilla',
      city: 'الرياض',
      district: 'العليا',
      address: 'أمام الرياض جاليري',
      details: 'تفاصيل',
      dateIso: '2025-06-01T00:00:00.000',
      timeLabel: '10:00',
      imagePaths: const ['a.jpg'],
      customerName: 'أحمد',
      customerPhone: '0500000000',
      status: RequestStatus.submitted,
      createdAtIso: '2025-05-20T10:00:00.000',
    );

    final restored = ServiceRequest.fromJson(r.toJson());
    expect(restored.id, r.id);
    expect(restored.kind, r.kind);
    expect(restored.status, r.status);
    expect(restored.imagePaths.length, 1);
    expect(restored.serviceNameAr, r.serviceNameAr);
  });

  test('RequestStatus.fromStorage falls back to submitted', () {
    expect(RequestStatusX.fromStorage('unknownKey'), RequestStatus.submitted);
    expect(RequestStatusX.fromStorage('received'), RequestStatus.received);
  });
}