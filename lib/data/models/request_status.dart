enum RequestStatus {
  submitted,
  received,
  underReview,
  awaitingInspection,
  preparingQuote,
  scheduled,
  inProgress,
  completed,
  cancelled,
}

extension RequestStatusX on RequestStatus {
  String get storageKey => name;

  static RequestStatus fromStorage(String? key) {
    if (key == null) return RequestStatus.submitted;
    return RequestStatus.values.firstWhere(
      (e) => e.name == key,
      orElse: () => RequestStatus.submitted,
    );
  }
}

enum RequestKind { service, quotation, inspection }