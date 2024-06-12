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

//   {
//     "id": "2f434eae-7b6d-4b5e-8c09-38f315173743",
//     "email": "user2@example.com",
//     "firstName": "Jane",
//     "lastName": "Smith",
//     "avatar": "https://picsum.photos/200/300?random=2",
//     "role": "user",
//     "status": "verified",
//     "isIdentityVerified": true,
//     "password": "$2b$10$ncEX/2jmLUFm9GQzapSJle4vz5MMuhG0aV8hIWEZP/vaw3EJIIFZe",
//     "address": "{}",
//     "gender": false,
//     "dob": "1995-05-15T00:00:00.000Z",
//     "phone": "987-654-3210",
//     "banReason": null,
//     "banUntil": null,
//     "lastActiveAt": "2023-12-23T15:45:00.000Z",
//     "createdAt": "2023-02-15T08:30:00.000Z",
//     "updatedAt": "2024-06-08T16:42:30.655Z"
// },

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
