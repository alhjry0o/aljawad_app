import 'request_status.dart';

class ServiceRequest {
  ServiceRequest({
    required this.id,
    required this.kind,
    required this.serviceId,
    required this.serviceNameAr,
    required this.serviceNameEn,
    required this.siteTypeKey,
    required this.city,
    required this.district,
    required this.address,
    required this.details,
    required this.dateIso,
    required this.timeLabel,
    required this.imagePaths,
    required this.customerName,
    required this.customerPhone,
    required this.status,
    required this.createdAtIso,
  });

  final String id;
  final RequestKind kind;
  final String serviceId;
  final String serviceNameAr;
  final String serviceNameEn;
  final String siteTypeKey;
  final String city;
  final String district;
  final String address;
  final String details;
  final String? dateIso;
  final String? timeLabel;
  final List<String> imagePaths;
  final String customerName;
  final String customerPhone;
  final RequestStatus status;
  final String createdAtIso;

  String serviceName(bool ar) => ar ? serviceNameAr : serviceNameEn;

  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind.name,
        'serviceId': serviceId,
        'serviceNameAr': serviceNameAr,
        'serviceNameEn': serviceNameEn,
        'siteTypeKey': siteTypeKey,
        'city': city,
        'district': district,
        'address': address,
        'details': details,
        'dateIso': dateIso,
        'timeLabel': timeLabel,
        'imagePaths': imagePaths,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'status': status.storageKey,
        'createdAtIso': createdAtIso,
      };

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
        id: json['id'] as String,
        kind: RequestKind.values.firstWhere(
          (e) => e.name == json['kind'],
          orElse: () => RequestKind.service,
        ),
        serviceId: json['serviceId'] as String,
        serviceNameAr: json['serviceNameAr'] as String,
        serviceNameEn: json['serviceNameEn'] as String,
        siteTypeKey: json['siteTypeKey'] as String,
        city: json['city'] as String,
        district: json['district'] as String,
        address: json['address'] as String,
        details: json['details'] as String? ?? '',
        dateIso: json['dateIso'] as String?,
        timeLabel: json['timeLabel'] as String?,
        imagePaths:
            (json['imagePaths'] as List?)?.map((e) => e.toString()).toList() ?? [],
        customerName: json['customerName'] as String,
        customerPhone: json['customerPhone'] as String,
        status: RequestStatusX.fromStorage(json['status'] as String?),
        createdAtIso: json['createdAtIso'] as String,
      );
}