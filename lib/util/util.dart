// String Api = "http://172.18.5.105/";

// String Api = "http://api.rd/";

// ignore_for_file: non_constant_identifier_names

//String api = "http://192.168.43.237/"; // Devota
//String api = "http://172.20.10.13/"; // Reddeath
//String api = "http://192.168.1.18/"; //familyfb as password
String api = "http://192.168.43.125/"; // Neheman
//String api = "http://192.168.43.237/"; // challo
String prfxUpld = "${api}public/uploads/";
//Authentications
String login = "${api}Users/login";
String craetAcount = '${api}Users/add';

//users
String urlGetUser = '${api}Users/user';
String urlUserList = '${api}Users/users';
String urlUserCrmVwr = '${api}Users/usersCrmViewer';
String urlUserById = '${api}Users/userById';
String urlUserProfileById = '${api}Users/getUserProfileById';
String urlUpdateUserInfo = '${api}Users/update';
String urlUpdateUserSetting = '${api}Users/updateSetting';

// Follow System
String urlAddFollow = '${api}Followers/add';
String urlUnFollow = '${api}Followers/anfollow';
String urlUnFollowback = '${api}Followers/update';
String urlGetFollowers = '${api}Followers/getFollowers';
String urlGetFollowing = '${api}Followers/getFollowings';

//Admin Ceremony
String urlAdminCrmnByUserId = '${api}Ceremony/getCrmn_by_UserId';
String urlAdmCrmnRequests = '${api}Ceremony/getAllCrmRequests';

//Ceremony
String urlPostCeremony = '${api}Ceremony/add';
String urlGetCeremony = '${api}Ceremony/get';
String urlGetCeremonyById = '${api}Ceremony/getById'; // not used
String urlCrmByDay = '${api}Ceremony/getCeremonyByDay';
String urlUpdateDayCeremony = '${api}Ceremony/update';
String urlGetByUserId = '${api}Ceremony/getCrmn_by_UserId';
String urlGetCrmByType = '${api}Ceremony/getCeremonyByType';

//Ceremony Bundle
String urladdCrmPackage = '${api}CeremonyPackageInfo/add';
String urlGetCrmPackage = '${api}CeremonyPackageInfo/get';
String urlActivateCrmPackage = '${api}CeremonyPackageInfo/activate';

//Ceremony Bundle
String urladdCrmBundle = '${api}CeremonyBundle/add';
String urlGetCrmBundle = '${api}CeremonyBundle/get';
String urlGetCrmBundleSearch = '${api}CeremonyBundle/search';
String urlGetCrmBundleHot = '${api}CeremonyBundle/getHotBundle';

//Invitation Cards
String urlGetInvCards = '${api}InvitationCard/get';
String urladdInvCards = '${api}InvitationCard/add';

//Order/Buy Invitation Cards
String urlGetOrderInvCards = '${api}InvCardOrders/get';
String urlOrderInvCards = '${api}InvCardOrders/add';

//Order/Buy Crm Bundle
String urlGetCrmBundleOrder = '${api}CrmBundleOrders/get';
String urlGetCrmBundleSchedule = '${api}CrmBundleOrders/getSchedule';
String urlOrderCrmBundle = '${api}CrmBundleOrders/add';

//Ceremonyt Viewers
String urladdCrmViewrs = '${api}CeremonyViewers/add';
String urlCrmAdminAddCrmViewrs = '${api}CeremonyViewers/addByCrmAdmin';
String urlGetCrmViewrs = '${api}CeremonyViewers/get'; //urlshoulBe:./get/../..;
String urlGetCrmVwrsByUid =
    '${api}CeremonyViewers/getByUid'; //urlshoulBe:./get/../..;
String urlGetExistViewrs = '${api}CeremonyViewers/viewerExist';
String urlRemoveCrmViewrs = '${api}CeremonyViewers/removeViewer';
String urlUpdateCrmViewerPostion = '${api}CeremonyViewers/updateCrmPosition';

//Ceremony Budget
String urlGetCrmAddBudget = '${api}Budget/add';
String urlGetCrmBudget = '${api}Budget/getByCrmId';

//Michango
String urlMchangoUpdate = '${api}Michango/update';

//Michango Payments
String urlMchangoPay = '${api}MichangoPayment/add';

//Busness
String urlPostBusness = '${api}Busness/add';
String urlAllBusnessList = '${api}Busness/getBsn';
String urlGoldBusness = '${api}Busness/getGoldenBusness';
String urlGoldBsnTyp = '${api}Busness/getByType';
String urlUpDateWorkList = '${api}Busness/updateWorkList';
String urlDeletePhoto = '${api}Busness/deletePhotoWork';

String urlMyBusnessList = '${api}Busness/getByBusnessCeoId';
String urlMyBsnByCratorId = '${api}Busness/bsnByCreatorId';
String urlUpdateBusness = '${api}Busness/update';
String urlBusnessRemove = '${api}Busness/remove';

String urlBusnessPhoto = '${api}Busness/getPhoto';
String urlBusnessMembers = '${api}Busness/getMembers';

//Admin Busness
String urlAdmBsnRequests = '${api}Busness/getBsnRequestsByCreatorId';

//Request List
String urlPostRequests = '${api}Requests/add';
String urlGetGoldReq = '${api}Requests/getGoldenRequests';
String urlCancelRequest = '${api}Requests/remove';
String urlUpdatelRequest = '${api}Requests/update';
// String urlGetRequests = '${api}Requests/getById';
// String urlGetBsnToCrmRequests = '${api}Requests/getBsnsToCrmInvitation';
// String urlGetInvRequest = '${api}Requests/getInvRequest';

//Services List
String urlPostService = '${api}Services/add';
String urlGetService = '${api}Services/get';
String urlGetGoldService = '${api}Services/getGoldenServices';
String urlRemoveServiceById = '${api}Services/remove';

//Subscription List
String urlUpdateSubscription = '${api}Subscription/update';

//Posts Sherekkoo
String urlPostSherekoo = '${api}MyPost/add';
String urlGetSherekoo = '${api}MyPost/get';

String urlUpdateSherekoo = '${api}MyPost/update';

String urlGetSherekooByCeremonyId = '${api}MyPost/getPostByCrmId';
String urlGetSherekooByUid = '${api}MyPost/getPostByUid';
String urlGetCrmPostByUid = '${api}MyPost/getPostByUid';
String urlProfileSherekooByUid = '${api}MyPost/getProfileByUid';
String urlVedioPostSherekoo = '${api}MyPost/addVedeo';
String urlremoveSherekoo = '${api}MyPost/remove';

//Likes
String urlpostLikes = '${api}Likes/add';

// Share
String urlpostShare = '${api}Share/add';

//Chats on Post
String urlPostChats = '${api}Chats/add';
String urlGetChats = '${api}Chats/get';

//Reply on chats
String urlAddReply = '${api}ChatsReply/add';

//BIGMONTH Tv Show
String urlAddBigMonth = '${api}TvshowBigMonth/add';
String urlGetBigMonth = '${api}TvshowBigMonth/get';
String urlGetBigMonthPacakge = '${api}TvshowBigMonth/get_as_Package';
String urlActivateGigMonthList = '${api}TvshowBigMonth/activate';
String urlRemoveBigMonthList = '${api}TvshowBigMonth/remove';
String urlUpdateBigShow = '${api}TvshowBigMonth/update';

//BigMonth Registration
String urlBigMonthRegistration = '${api}TvBmontRegistration/add';
String urlGetBigMonthRegistration =
    '${api}TvBmontRegistration/getRegisteredMembers';
String urlisSelectedInBiMonthMembers = '${api}TvBmontRegistration/isSelected';
String urlGetBiMonthWallMembers = '${api}TvBmontRegistration/getMembers';

//BigMonth Chats
String urlBigMonthPostChats = '${api}BigMonthChats/add';
String urlBigMonthGetChats = '${api}BigMonthChats/get';
// String urlMshengaGetLikes = '${api}MshengaChats/getAllLike';
String urlBigMonthAddLikes = '${api}BigMonthChats/addLike';
String urlBigMonthRemoveChat = '${api}BigMonthChats/remove';
String urlBigMOnthUpdateChat = '${api}BigMonthChats/update';

//MshengaWar Tv Show
String urlAddMshengaWar = '${api}TvShowMshengaWar/add';
String urlGetMshengaWar = '${api}TvShowMshengaWar/get';
String urlGeMshengaWarPacakge = '${api}TvShowMshengaWar/get_as_Package';
String urlActivateMshengaList = '${api}TvShowMshengaWar/activate';
String urlRemoveMshengaList = '${api}TvShowMshengaWar/remove';
String urlUpdateMshenga = '${api}TvShowMshengaWar/update';

//Mshenga War Chats
String urlMshengaPostChats = '${api}MshengaChats/add';
String urlMshengaGetChats = '${api}MshengaChats/get';
String urlMshengaGetLikes = '${api}MshengaChats/getAllLike';
String urlMshengaAddLikes = '${api}MshengaChats/addLike';
String urlMshengaRemoveChat = '${api}MshengaChats/remove';
String urlMshengaUpdateChat = '${api}MshengaChats/update';

// Mshenga Registration
String urlGetMshengaRegistration = '${api}TvShowMshengaWarReigistration/add';
String urlGetMshengaMembars = '${api}TvShowMshengaWarReigistration/getMembers';
