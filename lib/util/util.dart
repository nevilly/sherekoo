// String Api = "http://172.18.5.105/";

// String Api = "http://api.rd/";

// ignore_for_file: non_constant_identifier_names

// String api = "http://192.168.43.237/"; // Devota
//String api = "http://172.20.10.13/"; // Reddeath
String api = "http://192.168.43.125/"; // Neheman
//String api = "http://192.168.43.237/"; // challo

//Authentications
String login = "${api}Users/login";
String craetAcount = '${api}Users/addAccount';

//users
String urlGetUser = '${api}Users/user';
String urlUserList = '${api}Users/users';
String urlUserById = '${api}Users/userById';
String urlUserProfileById = '${api}Users/getUserProfileById';
String urlUpdateUserInfo = '${api}Users/updateAccount';
String urlUpdateUserSetting = '${api}Users/updateSetting';

//Ceremony
String urlPostCeremony = '${api}Ceremony/add';
String urlGetCeremony = '${api}Ceremony/get';
String urlGetCeremonyById = '${api}Ceremony/getById';
String urlCrmByDay = '${api}Ceremony/getCeremonyByDay';
String urlUpdateDayCeremony = '${api}Ceremony/update';
String urlCrmnByUserId = '${api}Ceremony/getCrmn_by_UserId';
String urlGetCrmByType = '${api}Ceremony/getCeremonyByType';

//Ceremonyt Viewers
String urladdCrmViewrs = '${api}CeremonyViewers/add';
String urlGetCrmViewrs = '${api}CeremonyViewers/get'; //urlshoulBe:./get/../..;
String urlGetExistViewrs = '${api}CeremonyViewers/viewerExist';

//Busness
String urlPostBusness = '${api}Busness/add';
String urlAllBusnessList = '${api}Busness/getBusness';
String urlBusnessByType = '${api}Busness/getByBusnessType';
String urlMyBusnessList = '${api}Busness/getByBusnessCeoId';
String urlMyBsnByCratorId = '${api}Busness/bsnByCreatorId';
String urlUpdateBusness = '${api}Busness/update';

String urlBusnessPhoto = '${api}Busness/getPhoto';
String urlBusnessMembers = '${api}Busness/getMembers';

//Services List
String urlPostHostList = '${api}Services/add';
String urlGetServices = '${api}Services/getById';
String urlGetBsnToCrmnServices = '${api}Services/getBsnsToCrmInvitation';
String urlGetInvatation = '${api}Services/getInvatation';

//PostsSherekkoo
String urlPostSherekoo = '${api}MyPost/add';
String urlGetSherekoo = '${api}MyPost/get';
String urlGetSherekooByCeremonyId = '${api}MyPost/getPostByCrmId';
String urlGetSherekooByUid = '${api}MyPost/getPostByUid';
String urlGetCrmPostByUid = '${api}MyPost/getPostByUid';
String urlProfileSherekooByUid = '${api}MyPost/getProfileByUid';
String urlVedioPostSherekoo = '${api}MyPost/addVedeo';

//LIkes
String urlpostLikes = '${api}Likes/add';

//Chats on Post
String urlPostChats = '${api}Chats/add';
String urlGetChats = '${api}Chats/get';

// Categries Varaible Dimensions
double ctg_hotHeight = 80.0;
double ctg_bodyHeight = 390.0;
int ctg_bodyItemCountx = 16;
int ctg_hotItemCountx = 3;
int ctg_crossAxisCountx = 3;
int ctg_hotcrossAxisCountx = 3;
