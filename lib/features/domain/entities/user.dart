import 'package:equatable/equatable.dart';
import '../enums/role.dart';
import '../enums/user_status.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final bool? gender;
  final String? dob;
  final String? phone;
  final String? address;
  final UserStatus? status;
  final bool? isIdentityVerified;
  final Role? role;
  final DateTime? lastActiveAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? bannedUtil;
  final String? banReason;

  String get fullName {
    if (firstName == null && lastName == null) {
      return "Không có dữ liệu";
    }
    return "$firstName $lastName";
  }

  const UserEntity({
    this.id,
    this.status,
    this.isIdentityVerified,
    this.role,
    this.email,
    this.address,
    this.firstName,
    this.lastName,
    this.gender,
    this.avatar,
    this.dob,
    this.phone,
    this.banReason,
    this.lastActiveAt,
    this.createdAt,
    this.updatedAt,
    this.bannedUtil,
  });

  @override
  List<Object?> get props => [id];

  UserEntity copyWith({
    String? id,
    UserStatus? status,
    bool? isIdentityVerified,
    Role? role,
    String? email,
    String? address,
    String? firstName,
    String? lastName,
    bool? gender,
    String? avatar,
    String? dob,
    String? phone,
    String? banReason,
    DateTime? lastActiveAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? bannedUtil,
  }) {
    return UserEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      isIdentityVerified: isIdentityVerified ?? this.isIdentityVerified,
      role: role ?? this.role,
      email: email ?? this.email,
      address: address ?? this.address,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      banReason: banReason ?? this.banReason,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bannedUtil: bannedUtil ?? this.bannedUtil,
    );
  }

  String? getFullName() {
    if (firstName == "" || lastName == "") {
      return null;
    }
    return "$firstName $lastName";
  }
}
