import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/auth/login_form_widget.dart';
import 'package:gympanion/features/auth/register_form_widget.dart';

class RegisterationPage extends StatelessWidget {
  const RegisterationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 2,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  // height: MediaQuery.of(context).size.height * .7,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      gradient: LinearGradient(
                          colors: [Colors.orange.shade200, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            80 / 600,
                            80 / 600,
                          ]),
                      borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
                        tabs: [
                          Text('Login',
                              style: AppTextStyles.displayMedium
                                  .copyWith(color: Colors.black54)),
                          Text('Sign Up',
                              style: AppTextStyles.displayMedium
                                  .copyWith(color: Colors.black54)),
                        ],
                        dividerHeight: 0,
                        indicatorColor: Colors.black54,
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .6,
                        child: TabBarView(
                          children: [
                            LoginFormWidget(),
                            SingleChildScrollView(child: RegisterFormWidget()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
