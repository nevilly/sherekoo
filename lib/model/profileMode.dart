class User {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String avater;
  final String phoneNo;
  final String email;
  final String gender;
  final String address;
  final String meritalStatus;
  final String role;
  final String bio;
  final dynamic isCurrentUser;

  User(
      {required this.id,
      required this.username,
      required this.firstname,
      required this.lastname,
      required this.avater,
      required this.phoneNo,
      required this.email,
      required this.gender,
      required this.role,
      required this.address,
      required this.meritalStatus,
      required this.bio,
      required this.isCurrentUser});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] ?? "",
        username: json['username'] ?? "",
        firstname: json['firstname'] ?? "",
        lastname: json['lastname'] ?? "",
        avater: json['avater'] ?? "",
        phoneNo: json['phoneNo'] ?? "",
        email: json['email'] ?? "",
        gender: json['gender'] ?? "",
        address: json['address'] ?? "",
        isCurrentUser: json['isCurrentUser'] ?? "",
        role: json['role'] ?? "",
        meritalStatus: json['merital_status'] ?? "",
        bio: json['bio'] ?? ""
        );
  }
}
