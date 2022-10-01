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
  final dynamic isCurrentCrmAdmin;
  final dynamic isCurrentBsnAdmin;
  final String totalFollowers;
  final String totalFollowing;
  final String totalLikes;

  final String totalPost;

  User({
    required this.id,
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
    required this.totalPost,
    required this.isCurrentUser,
    required this.isCurrentCrmAdmin,
    required this.isCurrentBsnAdmin,
    // total
    required this.totalFollowers,
    required this.totalFollowing,
    required this.totalLikes,
  });

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
      isCurrentUser: json['isCurrentUser'] ?? '',
      isCurrentCrmAdmin: json['crmAdmin'] ?? '',
      isCurrentBsnAdmin: json['bsnAdmin'] ?? '',

      role: json['role'] ?? "",
      meritalStatus: json['merital_status'] ?? "",
      bio: json['bio'] ?? "",

      //total
      totalPost: json['totalPost'].toString(),
      totalFollowers: json['totalFollowers'].toString() ,
      totalFollowing: json['totalFollowing'].toString(),
      totalLikes: json['totalLikes'].toString(),
    );
  }
}
