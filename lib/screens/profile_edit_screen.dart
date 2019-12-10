import 'package:comment_app/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  static const routeName = "/profile_edit";

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    var avatarBorderRadius;
    if (isLandscape) {
      avatarBorderRadius = mediaQuery.size.width * 0.1;
    }
    else {
      avatarBorderRadius = mediaQuery.size.width * 0.2;
    }
    var avatarDiameter = avatarBorderRadius*1.9;


    var profile = Provider.of<Profile>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile Edit")),
      body: Container(
        alignment: Alignment(0.0, 0.0),
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: avatarBorderRadius,
              child: Container(
                width: avatarDiameter,
                height: avatarDiameter,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage(
                       profile.avatar.path),
                  ),
                ),
              ),
            ),
            Text(profile.login),
          ],
        ),
      ),
    );
  }
}
