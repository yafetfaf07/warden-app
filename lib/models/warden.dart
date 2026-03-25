class Warden {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNo;
  final String gender;
  final String currentLocation;
  final String residenceArea;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastLogin;
  final String wardenStatus;
  final String parkingAvenueId;

  Warden({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNo,
    required this.gender,
    required this.currentLocation,
    required this.residenceArea,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
    required this.wardenStatus,
    required this.parkingAvenueId,
  });

  factory Warden.fromJson(Map<String, dynamic> json) {
    return Warden(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      username: json['username'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      gender: json['gender'] ?? '',
      currentLocation: json['currentLocation'] ?? '',
      residenceArea: json['residenceArea'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      lastLogin: DateTime.parse(json['lastLogin']),
      wardenStatus: json['wardenStatus'] ?? '',
      parkingAvenueId: json['parkingAvenueId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'phoneNo': phoneNo,
      'gender': gender,
      'currentLocation': currentLocation,
      'residenceArea': residenceArea,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'wardenStatus': wardenStatus,
      'parkingAvenueId': parkingAvenueId,
    };
  }
}