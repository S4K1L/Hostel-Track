import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? address;
  final String? email;
  final String? password;
  final String? uid;

  UserModel({
    this.name,
    this.address,
    this.email,
    this.password,
    this.uid,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    return UserModel(
      name: doc['name'],
      address: doc['address'],
      email: doc['email'],
      password: doc['password'],
      uid: doc['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'email': email,
      'password': password,
      'uid': uid
    };
  }
}
