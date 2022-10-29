import '../model/bundleBooking/bundle-orders.dart';
import '../model/busness/busnessModel.dart';
import '../model/ceremony/ceremonyModel.dart';
import '../model/crmPackage/crmPackageModel.dart';
import '../model/userModel.dart';

CeremonyModel ceremony = CeremonyModel(
  cId: '',
  codeNo: '',
  ceremonyType: '',
  cName: '',
  fId: '',
  sId: '',
  cImage: '',
  ceremonyDate: '',
  admin: '',
  contact: '',
  userFid: User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      address: '',
      meritalStatus: '',
      bio: '',
      totalPost: '',
      isCurrentUser: '',
      isCurrentCrmAdmin: '',
      isCurrentBsnAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: ''),
  userSid: User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      address: '',
      meritalStatus: '',
      bio: '',
      totalPost: '',
      isCurrentUser: '',
      isCurrentCrmAdmin: '',
      isCurrentBsnAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: ''),
  youtubeLink: '',
);


    User currentUser = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      isCurrentUser: '',
      address: '',
      bio: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');


BusnessModel busness = BusnessModel(
    location: '',
    bId: '',
    knownAs: '',
    coProfile: '',
    busnessType: '',
    companyName: '',
    price: '',
    contact: '',
    hotStatus: '',
    aboutCEO: '',
    aboutCompany: '',
    ceoId: '',
    subcrlevel: '',
    createdBy: '',
    user: User(
        id: '',
        username: '',
        firstname: '',
        lastname: '',
        avater: '',
        phoneNo: '',
        email: '',
        gender: '',
        role: '',
        isCurrentUser: '',
        address: '',
        bio: '',
        meritalStatus: '',
        totalPost: '',
        isCurrentBsnAdmin: '',
        isCurrentCrmAdmin: '',
        totalFollowers: '',
        totalFollowing: '',
        totalLikes: ''),
    createdDate: '');

CrmPckModel pck = CrmPckModel(
    id: '',
    title: '',
    descr: '',
    status: '',
    colorCode: [],
    createdDate: '',
    inYear: '',
    pImage: '');




Map<String, String> myHttpHeaders(String token) {
  return {"Authorization": "Owesis $token", "Content-Type": "Application/json"};
}

invalidToken(token , model) {
  if (token.isEmpty) {
    return model.fromJson({
      "status": 204,
      "payload": {"error": "Invalid token"}
    });
  }
}