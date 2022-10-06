class User {
  final String? id,
      username,
      firstname,
      lastname,
      avater,
      phoneNo,
      email,
      gender,
      address,
      meritalStatus,
      role,
      bio,
      totalFollowers,
      totalFollowing,
      totalLikes,
      totalPost;
  final dynamic isCurrentUser, isCurrentCrmAdmin, isCurrentBsnAdmin;

  User({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.avater,
    this.phoneNo,
    this.email,
    this.gender,
    this.role,
    this.address,
    this.meritalStatus,
    this.bio,
    this.totalPost,
    this.isCurrentUser,
    this.isCurrentCrmAdmin,
    this.isCurrentBsnAdmin,
    // total
    this.totalFollowers,
    this.totalFollowing,
    this.totalLikes,
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
      totalFollowers: json['totalFollowers'].toString(),
      totalFollowing: json['totalFollowing'].toString(),
      totalLikes: json['totalLikes'].toString(),
    );
  }
}
