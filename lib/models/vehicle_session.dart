class VehicleSession {
  final String id;
  final String licensePlate;
  final String parkingAvenueId;
  final String? userId;
  final String? reservationId;
  final String status;
  final int calculatedAmount;
  final String? checkoutTxRef;
  final DateTime createdAt;
  final DateTime updatedAt;

  VehicleSession({
    required this.id,
    required this.licensePlate,
    required this.parkingAvenueId,
    this.userId,
    this.reservationId,
    required this.status,
    required this.calculatedAmount,
    this.checkoutTxRef,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleSession.fromJson(Map<String, dynamic> json) {
    return VehicleSession(
      id: json['id'] ?? '',
      licensePlate: json['licensePlate'] ?? '',
      parkingAvenueId: json['parkingAvenueId'] ?? '',
      userId: json['userId'],
      reservationId: json['reservationId'],
      status: json['status'] ?? 'ACTIVE',
      calculatedAmount: json['calculatedAmount'] ?? 0,
      checkoutTxRef: json['checkoutTxRef'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'licensePlate': licensePlate,
      'parkingAvenueId': parkingAvenueId,
      'userId': userId,
      'reservationId': reservationId,
      'status': status,
      'calculatedAmount': calculatedAmount,
      'checkoutTxRef': checkoutTxRef,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}