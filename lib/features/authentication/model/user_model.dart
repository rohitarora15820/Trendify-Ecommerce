import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tstore/utils/formatters/formatter.dart';

import '../../../utils/helpers/helper_functions.dart';

class UserModel {
  final String id;
  final String email;
    String firstName;
    String lastName;
  final String username;
  final String phoneNumber;
   String profilePicture;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.profilePicture,
  });

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    final firstName = nameParts[0].toLowerCase();
    final lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = "$firstName$lastName";
    String userNameWithPrefix = "cwt_$camelCaseUserName";
    return userNameWithPrefix;
  }

  static UserModel empty() => UserModel(
        id: "",
        email: "",
        firstName: "",
        lastName: "",
        username: "",
        phoneNumber: "", profilePicture: '',
      );

  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> document) {

    if(document.data()!=null) {
      final data =document.data()!;
      return UserModel(
        id: document.id,
        email: data['email'],
        firstName: data['firstName'],
        lastName: data['lastName'],
          username: data['username'],
          phoneNumber: data['phoneNumber'],
          profilePicture: data['profilePicture'],
      );
    }
    return UserModel.empty();

  }

  Map<String, dynamic> toJson() {
    return {

      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }
}
