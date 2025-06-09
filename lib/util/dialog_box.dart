import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Get User Input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task"
              ),
            ),

            // Save button & Cancel Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                MyButton(text: "Save", onPressed: onSave),

                // gap between the buttons
                const SizedBox(
                  width: 8,
                ),

                // Cancel button
                MyButton(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}