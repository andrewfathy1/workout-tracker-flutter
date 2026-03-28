import 'package:flutter/material.dart';
import 'package:gympanion/core/data/notifiers.dart';

class UserWelcomePage extends StatelessWidget {
  const UserWelcomePage({super.key, required this.onNext});

  final VoidCallback onNext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome, ${userName.value}',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Wanna start your journey?',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: onNext,
            child: Text(
              'Let\'s Go!',
            ),
          ),
        ],
      ),
    );
  }
}
