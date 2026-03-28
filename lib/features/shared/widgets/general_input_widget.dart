import 'package:flutter/material.dart';

class GeneralInputWidget extends StatelessWidget {
  const GeneralInputWidget(
      {super.key,
      required this.titleText,
      required this.controller,
      required this.buttonText,
      required this.onNext});
  final VoidCallback onNext;
  final TextEditingController controller;
  final String titleText;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.grey,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: Colors.black45,
                  width: 5,
                ),
              ),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: onNext,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
