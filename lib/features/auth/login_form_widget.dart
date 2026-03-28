import 'package:flutter/material.dart';
import 'package:gympanion/core/services/firebase_auth_services.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/shared/widgets/wide_button.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Text(
            '* Email:',
            style: AppTextStyles.titleLarge,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
          ),
          SizedBox(height: 30),
          Text(
            '* Password:',
            style: AppTextStyles.titleLarge,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          SizedBox(height: 50),
          WideButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<FirebaseAuthServices>(context, listen: false)
                      .loginWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                }
              },
              title: 'Login',
              color: Colors.grey),
        ],
      ),
    );
  }
}
