import '../models/service_request.dart';
import '../models/request_status.dart';

abstract class RequestsRepository {
  Future<List<ServiceRequest>> all();
  Future<ServiceRequest> create(ServiceRequest request);
  Future<void> updateStatus(String id, RequestStatus status);
  Future<void> delete(String id);
  Future<void> clear();
}