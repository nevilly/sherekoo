import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherekoo/util/colors.dart';

import '../../model/profileMode.dart';
import '../../util/Preferences.dart';

class ProfileSetting extends StatefulWidget {
  final User user;
  const ProfileSetting({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final Preferences _preferences = Preferences();
  String token = '';
  File? _generalimage;
  // Image upload
  final _picker = ImagePicker();
  final _pickerG = ImagePicker();

  // Implementing the image Camera picker
  _openImagePickerG(arg) async {
    final pickG = _pickerG.pickImage(source: ImageSource.gallery);
    XFile? pickedImage = await pickG;

    if (pickedImage != null) {
      setState(() {
        _generalimage = File(pickedImage.path);
      });
    }
  }

  // Implementing the image Camera picker
  _openImagePickerC(arg) async {
    final pickC = _picker.pickImage(source: ImageSource.camera);
    XFile? pickedImage = await pickC;

    if (pickedImage != null) {
      setState(() {
        _generalimage = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
        // print('checkk token');
        // print(token);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OColors.appBarColor,
        title: const Text('Profile Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
