class ExitResponse {
  final String message;
  final String licensePlate;
  final int hoursStayed;
  final double amountDue;
  final String checkoutUrl;

  ExitResponse({
    required this.message,
    required this.licensePlate,
    required this.hoursStayed,
    required this.amountDue,
    required this.checkoutUrl,
  });

  factory ExitResponse.fromJson(Map<String, dynamic> json) {
    return ExitResponse(
      message: json['message'] ?? '',
      licensePlate: json['licensePlate'] ?? '',
      hoursStayed: json['hoursStayed'] ?? 0,
      // Using .toDouble() to safely handle both int and double from JSON
      amountDue: (json['amountDue'] as num).toDouble(),
      checkoutUrl: json['checkoutUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'licensePlate': licensePlate,
      'hoursStayed': hoursStayed,
      'amountDue': amountDue,
      'checkoutUrl': checkoutUrl,
    };
  }
}