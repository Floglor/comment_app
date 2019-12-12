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
    } else {
      avatarBorderRadius = mediaQuery.size.width * 0.2;
    }
    var avatarDiameter = avatarBorderRadius * 1.9;

    var profile = Provider.of<Profile>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile Edit")),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        SizedBox(
        height: 50,
        ),
          CircleAvatar(
            radius: avatarBorderRadius,
            child: Container(
              width: avatarDiameter,
              height: avatarDiameter,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    image: profile.avatar.path == "assets/test_graphics/8kb6UL-FvxM.jpg" ? new AssetImage(profile.avatar.path) : FileImage(profile.avatar),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(profile.login),
        ],
      ),
    );
  }
}
