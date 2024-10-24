import 'package:cloud_firestore/cloud_firestore.dart';

class StatusModel{
  final String? checkInDate;
  final String? checkOutDate;
  final String? checkIn;
  final String? checkOut;
  final String? hostel;

  StatusModel({
    this.checkInDate,
    this.checkOutDate,
    this.checkIn,
    this.checkOut,
    this.hostel,
});


  factory StatusModel.fromSnapshot(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return StatusModel(
      checkInDate: data['checkInDate'] != null ? (data['checkInDate']) : null,
      checkOutDate: data['checkOutDate'] != null ? (data['checkOutDate']) : null,
      checkIn: data['checkIn'] != null ? (data['checkIn']) : null,
      checkOut: data['checkOut'] != null ? (data['checkOut']) : null,
      hostel: data['hostel'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'hostel': hostel,
    };
  }


}