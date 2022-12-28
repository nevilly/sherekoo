import 'package:sherekoo/util/Preferences.dart';
import 'util.dart';

bool sw = false;
Preferences preferences = Preferences();
String token = '';

//BigMonth Tv Show
String urlBigShowImg = '${api}public/uploads/SherekooAdmin/bigMonthTvShow/';
String bigMonthShowStatus = 'true';
double pPbigMnthWidth = 50;
double pPbigMnthHeight = 50;

//Mshenga Tv Show
String urlMshenngaShowImg = '${api}public/uploads/SherekooAdmin/MshengaWar/';
String mshengaWarShowStatus = 'true';


//Ceremony Viewers
 String subScrbAs = 'Subscribe as ..?';
 List<String> crmViwrPosition = ['Viewer', 'Friend', 'Relative']; // positions Array
