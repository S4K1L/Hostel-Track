import 'package:cloud_firestore/cloud_firestore.dart';

class HostelModel {
  String? hostelName;

  HostelModel({this.hostelName});

  HostelModel copyWith({String? hostelName}) {
    return HostelModel(
      hostelName: hostelName ?? this.hostelName,
    );
  }

  factory HostelModel.fromSnapshot(DocumentSnapshot doc) {
    return HostelModel(
      hostelName: doc['hostelName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hostelName': hostelName,
    };
  }


}