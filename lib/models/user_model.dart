// var data = {
//   "createdAt": "January 19, 2023 at 1:27:41 AM UTC+5",
//   "firstName": "shakeeb Raza Ullah",
//   "imageUrl":
//       "https://firebasestorage.googleapis.com/v0/b/facebookclone-79d24.appspot.com/o/images%2F1674073653809943?alt=media&token=2c3e8cf7-5583-4616-a8b0-988a3e3a7830",
//   "lastName": "null",
//   "lastSeen": "January 19, 2023 at 1:27:41 AM UTC+5",
//   "metadata": {
//     "education": "bscs",
//     "email": "shakeebru007@gmail.com",
//     "gender": "Male",
//     "phone": "1234567980",
//     "coverImageUrl": ""
//   },
//   "role": "null",
//   "updatedAt": "January 19, 2023 at 1:27:41 AM UTC+5",
// };

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.createdAt,
    required this.firstName,
    required this.imageUrl,
    required this.lastName,
    required this.lastSeen,
    required this.metadata,
    required this.role,
    required this.updatedAt,
  });
  late final String createdAt;
  late final String firstName;
  late final String imageUrl;
  late final String lastName;
  late final String lastSeen;
  late final Metadata metadata;
  late final String role;
  late final String updatedAt;

  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'].toString();
    firstName = json['firstName'];
    imageUrl = json['imageUrl'];
    lastName = json['lastName'] ?? "";
    lastSeen = json['lastSeen'].toString();
    metadata = Metadata.fromJson(json['metadata']);
    role = json['role'] ?? "";
    updatedAt = json['updatedAt'].toString();
  }

  UserModel.documentSnapshot(DocumentSnapshot snapshot) {
    createdAt = snapshot['createdAt'];
    firstName = snapshot['firstName'];
    imageUrl = snapshot['imageUrl'];
    lastName = snapshot['lastName'];
    lastSeen = snapshot['lastSeen'];
    metadata = Metadata.fromJson(snapshot['metadata']);
    role = snapshot['role'];
    updatedAt = snapshot['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['firstName'] = firstName;
    _data['imageUrl'] = imageUrl;
    _data['lastName'] = lastName;
    _data['lastSeen'] = lastSeen;
    _data['metadata'] = metadata.toJson();
    _data['role'] = role;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Metadata {
  Metadata({
    required this.education,
    required this.email,
    required this.gender,
    required this.phone,
    required this.coverImageUrl,
  });
  late final String education;
  late final String email;
  late final String gender;
  late final String phone;
  late final String coverImageUrl;

  Metadata.fromJson(Map<String, dynamic> json) {
    education = json['education'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    coverImageUrl = json['coverImageUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['education'] = education;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['phone'] = phone;
    _data['coverImageUrl'] = coverImageUrl;
    return _data;
  }
}
