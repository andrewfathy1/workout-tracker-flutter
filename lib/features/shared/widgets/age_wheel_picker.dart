import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';

class AgeWheelPicker extends StatelessWidget {
  const AgeWheelPicker(
      {super.key, required this.ageController, required this.onNext});
  final VoidCallback onNext;
  final FixedExtentScrollController ageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        Center(
          child: Text(
            'How Old Are You?',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.grey,
                Colors.transparent,
              ],
            ),
            color: Colors.grey,
          ),
          child: ListWheelScrollView.useDelegate(
            controller: ageController,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: maxAge - minAge + 1,
              builder: (context, index) {
                return Center(
                  child: Text(
                    '${minAge + index}',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                );
              },
            ),
            useMagnifier: true,
            itemExtent: 50,
            magnification: 1.2,
            diameterRatio: 0.5,
            physics: FixedExtentScrollPhysics(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onNext();
          },
          child: Text(
            'Next',
          ),
        ),
      ],
    );
  }
}
