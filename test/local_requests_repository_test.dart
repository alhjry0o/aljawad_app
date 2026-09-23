import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aljawad_services/data/models/request_status.dart';
import 'package:aljawad_services/data/models/service_request.dart';
import 'package:aljawad_services/data/repositories/local_requests_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('create & fetch & update status', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = LocalRequestsRepository(prefs);

    final r = ServiceRequest(
      id: 'JW-1',
      kind: RequestKind.service,
      serviceId: 'x',
      serviceNameAr: 'خدمة',
      serviceNameEn: 'Service',
      siteTypeKey: 'siteHome',
      city: 'الرياض',
      district: 'العليا',
      address: 'عنوان',
      details: '',
      dateIso: null,
      timeLabel: null,
      imagePaths: const [],
      customerName: 'أحمد',
      customerPhone: '0500000000',
      status: RequestStatus.submitted,
      createdAtIso: DateTime.now().toIso8601String(),
    );

    await repo.create(r);
    final all = await repo.all();
    expect(all.length, 1);

    await repo.updateStatus('JW-1', RequestStatus.received);
    final updated = (await repo.all()).first;
    expect(updated.status, RequestStatus.received);
  });
}