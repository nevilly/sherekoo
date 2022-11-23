class Likes {
   String? number, isLike;

  Likes({required this.number, required this.isLike});
  factory Likes.fromJson(Map<String, dynamic> json) {
    return Likes(
        number: json['n'].toString(), isLike: json['isLiked'].toString());
  }
}
