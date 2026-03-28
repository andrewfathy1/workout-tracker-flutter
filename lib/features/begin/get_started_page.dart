import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/core/data/notifiers.dart';
import 'package:gympanion/core/data/user_data.dart';
import 'package:gympanion/features/shared/widgets/age_wheel_picker.dart';
import 'package:gympanion/features/shared/widgets/app_navigator.dart';
import 'package:gympanion/features/begin/user_welcome_page.dart';
import 'package:gympanion/features/shared/widgets/general_input_widget.dart';
import 'package:gympanion/features/begin/select_goal_widget.dart';
import 'package:gympanion/features/shared/widgets/semi_transparent_widget.dart';
import 'package:provider/provider.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final FixedExtentScrollController _ageController =
      FixedExtentScrollController();

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SemiTransparentWidget(alpha: 122),
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              GeneralInputWidget(
                titleText: 'Please, Enter Your Name',
                controller: _nameController,
                buttonText: 'Next',
                onNext: () => _handlePageChanged(1),
              ),
              AgeWheelPicker(
                ageController: _ageController,
                onNext: () => _handlePageChanged(2),
              ),
              SelectGoalWidget(
                onNext: () => _handlePageChanged(3),
              ),
              UserWelcomePage(
                onNext: () async {
                  // userData.userName = userName.value;
                  // userData.userAge = userAge.value;
                  // userData.userGoal = selectedGoal.value;

                  Provider.of<UserData>(context, listen: false).saveData(
                      name: userName.value,
                      age: userAge.value,
                      goal: selectedGoal.value);
                  _redirectToHomePage(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handlePageChanged(int currentPage) {
    if (currentPage == 1) {
      if (_nameController.text == '') return;
      userName.value = _nameController.text;
    } else if (currentPage == 2) {
      userAge.value = _ageController.selectedItem + minAge;
    } else if (currentPage == 3) {
      if (selectedGoal.value == '') return;
    }
    setState(() {
      currentPageIndex++;
    });

    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

void _redirectToHomePage(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (context) => AppNavigator(),
    ),
  );
}

class GettingStartedWidget extends StatelessWidget {
  const GettingStartedWidget({super.key, required this.onNext});

  final VoidCallback onNext;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onNext,
        child: Text('Get Started'),
      ),
    );
  }
}
