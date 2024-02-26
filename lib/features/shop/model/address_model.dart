import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tstore/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    required this.selectedAddress,
  });

  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '',
      selectedAddress: false);

  Map<String, dynamic> toMap() {
    return {
      'Id': this.id,
      'Name': this.name,
      'PhoneNumber': this.phoneNumber,
      'Street': this.street,
      'City': this.city,
      'State': this.state,
      'PostalCode': this.postalCode,
      'Country': this.country,
      'DateTime': DateTime.now(),
      'SelectedAddress': this.selectedAddress,
    };
  }

  factory AddressModel.fromDocumentSnapShot(DocumentSnapshot snapShot) {
    final map=snapShot.data() as Map<String,dynamic>;
    return AddressModel(
      id: snapShot.id,
      name: map['Name'] ??'',
      phoneNumber: map['PhoneNumber'] ??"",
      street: map['Street'] ??"",
      city: map['City'] ??'',
      state: map['State'] ??"",
      postalCode: map['PostalCode'] ??"",
      country: map['Country'] ??"",
      dateTime: (map['DateTime'] as Timestamp).toDate(),
      selectedAddress: map['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
