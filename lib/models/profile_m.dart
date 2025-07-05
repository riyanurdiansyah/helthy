import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileM {
  final String directSuperior;
  final String username;
  final String email;
  final String? createdAt;
  final String? updatedAt;
  final String fullname;
  final String id;
  final bool status;
  final String role;
  final String signature;

  ProfileM({
    required this.directSuperior,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.fullname,
    required this.id,
    required this.status,
    required this.role,
    required this.signature,
  });

  factory ProfileM.fromJson(Map<String, dynamic> json) {
    return ProfileM(
      directSuperior: json['directSuperior'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      signature: json['signature'] ?? '',
      createdAt:
          json['createdAt'] == null
              ? null
              : json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate().toIso8601String()
              : DateTime.parse(json['createdAt']).toIso8601String(),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate().toIso8601String()
              : DateTime.parse(json['updatedAt']).toIso8601String(),
      fullname: json['fullname'] ?? '',
      id: json['id'] ?? '',
      status: json['status'] == "active" ? true : false,
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'directSuperior': directSuperior,
      'username': username,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'fullname': fullname,
      'id': id,
      'status': status,
      'role': role,
      'signature': signature,
    };
  }
}
