import 'package:flutter/material.dart';

class NewCommentary extends StatelessWidget {
  final Function addComm;
  final commentaryController = TextEditingController();

  NewCommentary(this.addComm);

  void submitData() {
    final enteredText = commentaryController.text;

    if (enteredText.isEmpty) {
      return;
    }

    addComm(enteredText);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          //width: 200,
          child: TextField(
              decoration: InputDecoration(labelText: "Add comment"),
              controller: commentaryController,
            onSubmitted: (_) => submitData(),
      ),
    ));
  }
}
