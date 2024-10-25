import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel{
  final String? checkInDate;
  final String? checkOutDate;
  final String? hostel;

  HistoryModel({
    this.checkInDate,
    this.checkOutDate,
    this.hostel,
  });


  factory HistoryModel.fromSnapshot(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return HistoryModel(
      checkInDate: data['checkInDate'] != null ? (data['checkInDate']) : null,
      checkOutDate: data['checkOutDate'] != null ? (data['checkOutDate']) : null,
      hostel: data['hostel'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'hostel': hostel,
    };
  }


}