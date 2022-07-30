import 'package:flutter/material.dart';

class ActionsToolbar extends StatelessWidget {
  // Full dimensions of an action
  static const double actionWidgetSize = 60.0;

// The size of the icon showen for Social Actions
  static const double actionIconSize = 35.0;

// The size of the share social icon
  static const double shareActionIconSize = 25.0;

// The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

// The size of the plus icon under the profile image in follow action
  static const double plusIconSize = 20.0;

  const ActionsToolbar({Key? key}) : super(key: key);

  LinearGradient get musicGradient => const LinearGradient(colors: [
        Color(0xFF424242),
        Color(0xFF212121),
        Color(0xFF212121),
        Color(0xFF424242)
      ], stops: [
        0.0,
        0.4,
        0.6,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);
  // avater
  Widget _getMusicPlayerAction() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: actionWidgetSize,
        height: actionWidgetSize,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(11.0),
            height: profileImageSize,
            width: profileImageSize,
            decoration: BoxDecoration(
                gradient: musicGradient,
                borderRadius: BorderRadius.circular(profileImageSize / 2)),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/login/02.jpg'),
              // backgroundImage: NetworkImage('https://i.pravatar.cc/300')
            ),

            //    CachedNetworkImage(
            //     imageUrl: "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
            //     placeholder: (context, url) => new CircularProgressIndicator(),
            //     errorWidget: (context, url, error) => new Icon(Icons.error),
            // ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Sender Avater
          _getFollowAction(pictureUrl: 'assets/login/02.jpg'),

          _getSocialAction(
              icon: Icon(Icons.ac_unit, size: 35.0, color: Colors.grey[300]),
              title: '3.2m'),

          //var msg
          GestureDetector(
            onTap: () {},
            child: _getSocialAction(
                icon: Icon(Icons.chat_bubble,
                    size: 35.0, color: Colors.grey[300]),
                title: '16.4k'),
          ),

          _getSocialAction(
              icon: Icon(Icons.reply, size: 35.0, color: Colors.grey[300]),
              title: 'Share'),

          _getMusicPlayerAction()
        ],
      ),
    );
  }

  Widget _getSocialAction({required String title, required Icon icon}) {
    return Container(
        margin: const EdgeInsets.only(top: 15.0),
        width: 60.0,
        height: 60.0,
        child: Column(children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(title, style: const TextStyle(fontSize: 12.0)),
          )
        ]));
  }

  Widget _getFollowAction({required String pictureUrl}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: 60.0,
        height: 60.0,
        child: Stack(children: [_getProfilePicture(), _getPlusIcon()]));
  }

  Widget _getPlusIcon() {
    return Positioned(
      bottom: 0,
      left: ((actionWidgetSize / 2) - (plusIconSize / 2)),
      child: Container(
          width: plusIconSize, // PlusIconSize = 20.0;
          height: plusIconSize, // PlusIconSize = 20.0;
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 43, 84),
              borderRadius: BorderRadius.circular(15.0)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          )),
    );
  }

  //Avater
  Widget _getProfilePicture() {
    return Positioned(
        left: (actionWidgetSize / 2) - (profileImageSize / 2),
        child: Container(
          padding: const EdgeInsets.all(
              1.0), // Add 1.0 point padding to create border
          height: profileImageSize, // ProfileImageSize = 50.0;
          width: profileImageSize, // ProfileImageSize = 50.0;
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(profileImageSize / 2)),
          // import 'package:cached_network_image/cached_network_image.dart'; at the top to use CachedNetworkImage
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/login/02.jpg'),
            // backgroundImage: NetworkImage('https://i.pravatar.cc/300')
          ),
          //              CachedNetworkImage(
          //     imageUrl: "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
          //     placeholder: (context, url) => new CircularProgressIndicator(),
          //     errorWidget: (context, url, error) => new Icon(Icons.error),
          // ),
        ));
  }
}
