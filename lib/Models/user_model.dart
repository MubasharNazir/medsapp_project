class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  // String? profilePictureUrl;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    //  this.profilePictureUrl = ''
  });
// receiving the data from firestore
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      //  profilePictureUrl: map['profilePictureUrl']
    );
  }
// sending the data to firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
