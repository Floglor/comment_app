import 'dart:io';

import 'package:comment_app/providers/profile.dart';
import 'package:comment_app/screens/saved_images_screen.dart';
import 'package:comment_app/widgets/main_avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var _loginController = TextEditingController();

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  bool imageChanged = false;
  File image;
  String value = "";

  void _showEditProfileDialog(
      BuildContext context, TextEditingController savedLoginController) {
    if (savedLoginController != null) _loginController = savedLoginController;
    print(imageChanged);
    // flutter defined function
    showDialog(
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: ListView(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    //Provider.of<Profile>(context).avatar = image;
                    setState(() async {
                      image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      Navigator.of(context).pop();
                      _showEditProfileDialog(context, _loginController);
                    });
                  },
                  child: MainAvatar(0.1, image)),
              TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  labelText: Provider.of<Profile>(context).login,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (image != null) Provider.of<Profile>(context).avatar = image;
                if (_loginController.text.isNotEmpty)
                  Provider.of<Profile>(context).login = _loginController.text;
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: GestureDetector(
                onTap: () => _showEditProfileDialog(context, null),
                child: MainAvatar(0.04, null)),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Saved Images', Icons.save, () {
            Navigator.of(context).pushNamed(SavedImages.routeName);
          }),
         // buildListTile('Profile', Icons.person, () {
         //   Navigator.of(context).pushNamed(ProfileEdit.routeName);
         // }),
        ],
      ),
    );
  }
}
