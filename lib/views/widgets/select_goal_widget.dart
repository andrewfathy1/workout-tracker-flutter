import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/notifiers.dart';

class SelectGoalWidget extends StatefulWidget {
  const SelectGoalWidget({super.key, required this.onNext});
  final VoidCallback onNext;
  @override
  State<SelectGoalWidget> createState() => _SelectGoalWidgetState();
}

class _SelectGoalWidgetState extends State<SelectGoalWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'What about your goal?',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.count(
            padding: EdgeInsets.all(10),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 2,
            children: goals.map((goal) {
              final isSelected = selectedGoal.value == goal;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGoal.value = goal;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.cyan : Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          isSelected ? Colors.cyanAccent : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      goal,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Center(
            child: ElevatedButton(
              onPressed: widget.onNext,
              child: Text('Next'),
            ),
          ),
        ),
      ],
    );
  }
}
