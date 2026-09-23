import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/request_status.dart';
import '../models/service_request.dart';
import 'requests_repository.dart';

class LocalRequestsRepository implements RequestsRepository {
  LocalRequestsRepository(this._prefs);

  final SharedPreferences _prefs;
  static const String _key = 'aljawad_requests_v1';

  @override
  Future<List<ServiceRequest>> all() async {
    final raw = _prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      final result = list.map(ServiceRequest.fromJson).toList();
      result.sort((a, b) => b.createdAtIso.compareTo(a.createdAtIso));
      return result;
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveAll(List<ServiceRequest> list) async {
    final raw = jsonEncode(list.map((e) => e.toJson()).toList());
    await _prefs.setString(_key, raw);
  }

  @override
  Future<ServiceRequest> create(ServiceRequest request) async {
    final list = await all();
    list.add(request);
    await _saveAll(list);
    return request;
  }

  @override
  Future<void> updateStatus(String id, RequestStatus status) async {
    final list = await all();
    final idx = list.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final r = list[idx];
    list[idx] = ServiceRequest(
      id: r.id,
      kind: r.kind,
      serviceId: r.serviceId,
      serviceNameAr: r.serviceNameAr,
      serviceNameEn: r.serviceNameEn,
      siteTypeKey: r.siteTypeKey,
      city: r.city,
      district: r.district,
      address: r.address,
      details: r.details,
      dateIso: r.dateIso,
      timeLabel: r.timeLabel,
      imagePaths: r.imagePaths,
      customerName: r.customerName,
      customerPhone: r.customerPhone,
      status: status,
      createdAtIso: r.createdAtIso,
    );
    await _saveAll(list);
  }

  @override
  Future<void> delete(String id) async {
    final list = await all();
    list.removeWhere((e) => e.id == id);
    await _saveAll(list);
  }

  @override
  Future<void> clear() async {
    await _prefs.remove(_key);
  }
}