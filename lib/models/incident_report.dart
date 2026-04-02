class IncidentReport {
  final String id;
  final String category;
  final String reason;
  final DateTime createdAt;
  final String? customerId;
  final String wardenId;
  final String parkingAvenueId;

  IncidentReport({
    required this.id,
    required this.category,
    required this.reason,
    required this.createdAt,
    this.customerId,
    required this.wardenId,
    required this.parkingAvenueId,
  });

  factory IncidentReport.fromJson(Map<String, dynamic> json) {
    return IncidentReport(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      reason: json['reason'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      customerId: json['customerId'], // Can be null
      wardenId: json['wardenId'] ?? '',
      parkingAvenueId: json['parkingAvenueId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'reason': reason,
      'createdAt': createdAt.toIso8601String(),
      'customerId': customerId,
      'wardenId': wardenId,
      'parkingAvenueId': parkingAvenueId,
    };
  }
}