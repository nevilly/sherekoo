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


//Post Template
  // Full dimensions of an action
   const double actionWidgetSize = 60.0;

// The size of the icon showen for Social Actions
   const double actionIconSize = 35.0;

// The size of the share social icon
   const double shareActionIconSize = 25.0;

// The size of the profile image in the follow Action
   const double profileImageSize = 50.0;

// The size of the plus icon under the profile image in follow action
   const double plusIconSize = 20.0;