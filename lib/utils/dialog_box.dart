// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:noshbae/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({
    Key? key,
    required this.controller,
    required this.onSaved,
    required this.onCancel,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 150,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'New Task',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            //buttons = save + cancel
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(buttonName: 'Save', onPressed: onSaved),
                const SizedBox(width: 8),
                MyButton(buttonName: 'Cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
