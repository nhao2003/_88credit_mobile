import '../../domain/entities/address.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/role.dart';
import '../../domain/enums/user_status.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.status,
    super.isIdentityVerified,
    super.role,
    super.email,
    super.address,
    super.firstName,
    super.lastName,
    super.gender,
    super.avatar,
    super.dob,
    super.phone,
    super.lastActiveAt,
    super.createdAt,
    super.updatedAt,
    super.bannedUtil,
    super.banReason,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatar: json['avatar'],
      gender: json['gender'],
      dob: json['dob'],
      phone: json['phone'],
      //status: UserStatus.parse(json['status']),
      status: json['status'] != null ? UserStatus.parse(json['status']) : null,
      isIdentityVerified: json['isIdentityVerified'],
      role: json['role'] != null ? Role.parse(json['role']) : null,
      address: json['address'],
      banReason: json['banReason'],
      lastActiveAt: json['lastActiveAt'] != null
          ? DateTime.parse(json['lastActiveAt'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      bannedUtil: json['bannedUtil'] != null
          ? DateTime.tryParse(json['bannedUtil'] ?? "")
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toString(),
      'isIdentityVerified': isIdentityVerified,
      'role': role.toString(),
      'email': email,
      'address': address,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'avatar': avatar,
      'dob': dob,
      'phone': phone,
      'banReason': banReason,
      'lastActiveAt': lastActiveAt!.toIso8601String(),
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
      'bannedUtil': bannedUtil!.toIso8601String(),
    };
  }
}
