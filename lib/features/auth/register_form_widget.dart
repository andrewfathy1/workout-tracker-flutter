import 'package:flutter/material.dart';
import 'package:gympanion/core/services/firebase_auth_services.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/shared/widgets/wide_button.dart';
import 'package:provider/provider.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
            '* Name:',
            style: AppTextStyles.titleLarge,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 30),
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
            keyboardType: TextInputType.emailAddress,
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
                return 'Please enter password';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 30),
          Text(
            '* Confirm Password:',
            style: AppTextStyles.titleLarge,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a confirmation password';
              } else if (value != _passwordController.text) {
                return 'passwords dont match';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16))),
            obscureText: true,
          ),
          SizedBox(height: 50),
          WideButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<FirebaseAuthServices>(context, listen: false)
                      .registerWithEmailAndPassword(
                          displayName: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                }
              },
              title: 'Register',
              color: Colors.grey),
          SizedBox(height: 150),
        ],
      ),
    );
  }
}
