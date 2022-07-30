class BusnessPhotoModel {
  final String bPhotoId;
  final String bId;
  final String photo;
  final String createdDate;

  BusnessPhotoModel({
    required this.bPhotoId,
    required this.bId,
    required this.photo,
    required this.createdDate,
  });

  factory BusnessPhotoModel.fromJson(Map<String, dynamic> json) {
    return BusnessPhotoModel(
        bPhotoId: json['bPhotoId'],
        bId: json['bId'],
        photo: json['photo'],
        createdDate: json['createdDate']);
  }
}
