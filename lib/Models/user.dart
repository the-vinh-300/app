class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
