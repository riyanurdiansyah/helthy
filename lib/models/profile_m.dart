import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileM {
  final String directSuperior;
  final String username;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String fullname;
  final String id;
  final bool active;
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
    required this.active,
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
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : DateTime.parse(json['updatedAt']),
      fullname: json['fullname'] ?? '',
      id: json['id'] ?? '',
      active: json['active'] ?? false,
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'directSuperior': directSuperior,
      'username': username,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'fullname': fullname,
      'id': id,
      'active': active,
      'role': role,
      'signature': signature,
    };
  }
}
