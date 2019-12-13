import 'dart:io';

import 'package:comment_app/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAvatar extends StatelessWidget {

  final avatarDiameterMultiplier;
  final File _image;


  MainAvatar(this.avatarDiameterMultiplier, this._image);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    var avatarBorderRadius;
    var profile = Provider.of<Profile>(context);
    if (isLandscape) {
      avatarBorderRadius = mediaQuery.size.width * avatarDiameterMultiplier;
    } else {
      avatarBorderRadius = mediaQuery.size.width * avatarDiameterMultiplier*2;
    }
    var avatarDiameter = avatarBorderRadius * 1.8;

    return CircleAvatar(
      radius: avatarBorderRadius,
      child: Container(
        width: avatarDiameter,
        height: avatarDiameter,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: _image == null ? profile.avatar.path == "assets/test_graphics/8kb6UL-FvxM.jpg"
                ? new AssetImage(profile.avatar.path)
                : FileImage(profile.avatar)
            : FileImage(_image),
          ),
        ),
      ),
    );
  }
}
