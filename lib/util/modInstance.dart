import 'package:sherekoo/model/ceremony/crmVwr-model.dart';
import 'package:sherekoo/model/mchango/mchango-model.dart';
import 'package:sherekoo/model/mchango/mchangoPayment-model.dart';

import '../model/busness/busnessModel.dart';
import '../model/ceremony/crm-model.dart';
import '../model/crmPackage/crmPackageModel.dart';
import '../model/subScription/subsrModel.dart';
import '../model/user/userModel.dart';

User emptyUser = User(
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

User emptycurrentUser = User(
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

CeremonyModel emptyCrmModel = CeremonyModel(
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
  isInFuture: '',
  isCrmAdmin: '',
  likeNo: '',
  chatNo: '',
  viwersNo: '',
  userFid: emptyUser,
  userSid: emptyUser,
  youtubeLink: '',
);

SubscriptionModel emptySubscrptn = SubscriptionModel(
    subId: '',
    level: '',
    subscriptionType: '',
    categoryId: '',
    activeted: '',
    duration: '',
    startTime: '',
    endTime: '',
    receiptNo: '',
    createdDate: '');

BusnessModel emptyBsnMdl = BusnessModel(
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
    subscriptionInfo: emptySubscrptn,
    isBsnAdmin: '',
    createdBy: '',
    user: emptyUser,
    createdDate: '');

CrmPckModel empytCrmPckModel = CrmPckModel(
    id: '',
    title: '',
    descr: '',
    status: '',
    colorCode: [],
    createdDate: '',
    inYear: '',
    pImage: '');

Map<String, dynamic> get shereKoMap {
  return {
    'pId': '',
    'createdBy': '',
    'ceremonyId': '',
    'body': '',
    'vedeo': '',
    'creatorInfo': {
      'id': '',
      'username': '',
      'firstname': '',
      'lastname': '',
      'avater': '',
      'phoneNo': '',
      'email': '',
      'gender': '',
      'role': '',
      'isCurrentUser': '',
      'address': '',
      'bio': '',
      'meritalStatus': '',
      'totalPost': '',
      'isCurrentBsnAdmin': '',
      'isCurrentCrmAdmin': '',
      'totalFollowers': '',
      'totalFollowing': '',
      'totalLikes': ''
    },
    'createdDate': '',
    'commentNumber': '',
    'crmInfo': {
      'cId': '',
      'codeNo': '',
      'ceremonyType': '',
      'cName': '',
      'fId': '',
      'sId': '',
      'cImage': '',
      'ceremonyDate': '',
      'admin': '',
      'contact': '',
      'isInFuture': '',
      'isCrmAdmin': '',
      'likeNo': '',
      'chatNo': '',
      'viwersNo': '',
      'userFid': {
        'id': '',
        'username': '',
        'firstname': '',
        'lastname': '',
        'avater': '',
        'phoneNo': '',
        'email': '',
        'gender': '',
        'role': '',
        'isCurrentUser': '',
        'address': '',
        'bio': '',
        'meritalStatus': '',
        'totalPost': '',
        'isCurrentBsnAdmin': '',
        'isCurrentCrmAdmin': '',
        'totalFollowers': '',
        'totalFollowing': '',
        'totalLikes': ''
      },
      'userSid': {
        'id': '',
        'username': '',
        'firstname': '',
        'lastname': '',
        'avater': '',
        'phoneNo': '',
        'email': '',
        'gender': '',
        'role': '',
        'isCurrentUser': '',
        'address': '',
        'bio': '',
        'meritalStatus': '',
        'totalPost': '',
        'isCurrentBsnAdmin': '',
        'isCurrentCrmAdmin': '',
        'totalFollowers': '',
        'totalFollowing': '',
        'totalLikes': ''
      },
      'youtubeLink': '',
    },
    'totalLikes': '',
    'isLike': '',
    'totalShare': '',
    'hashTag': '',
    'isPostAdmin': '',
    'crmViewer': ''
  };
}

MchangoPaymentModel emptyMchangoPay = MchangoPaymentModel(
  id: '',
  mchangoId: '',
  amount: '',
  createdBy: '',
  createdDate: '', contact: '', crmId: '',
  status: '',
  // total: '',
  reciept: '',
);

MchangoModel emptyMchango = MchangoModel(
    id: '',
    crmId: '',
    viewerId: '',
    ahadi: '',
    totalPayInfo: '',
    mchangoPayInfo: []);

CrmViewersModel emptyCrmVwr = CrmViewersModel(
    id: '',
    userId: '',
    name: '',
    contact: '',
    position: '',
    crmInfo: emptyCrmModel,
    viewerInfo: emptyUser,
    isAdmin: '',
    crmId: '',
    mchangoInfo: emptyMchango);
