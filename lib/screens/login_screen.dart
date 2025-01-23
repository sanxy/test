
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/screens/dashboard_screen.dart';
import 'package:test/screens/pre_load_screen.dart';
import 'package:test/utils/next_screen.dart';
import '../api/api_requests.dart';
import '../api/api_response.dart';
import '../api/api_response_type.dart';
import '../utils/custom_widgets.dart';
import '../utils/my_colors.dart';
import '../utils/strings.dart';
import '../utils/tools.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordObscured = true;
  bool isLoading = false;
  // username: 'emilys',
  // password: 'emilyspass',


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 30.0, vertical: 5.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            nextScreenReplace(context, const PreLoadScreen());
                          },
                          child: SvgPicture.asset(
                            'assets/images/arrow-left.svg',
                            height: 25,
                            width: 25,
                          ),
                        ),
                        const SizedBox(height: 60),
                        Center(
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: 78,
                            width: 78,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildInputField(
                          controller: usernameController,
                          label: 'Username',
                          hintText: 'Enter your username',
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          controller: passwordController,
                          label: 'Password',
                          hintText: 'Enter your password',
                          obscureText: isPasswordObscured,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordObscured = !isPasswordObscured;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        BuildBtn(
                          title: 'Log In',
                          showLoadingIcon: isLoading,
                          onPressed: () {
                            // Validate username and password
                            if (usernameController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              loginMode(context);
                            } else {
                              // Show error dialog
                              dialog(context, 'Login Error',
                                  'Username or password can\'t be empty');
                            }
                          },
                          buttonColor: MyColors.bluePrimary,
                          textColor: MyColors.white,
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            // Handle forgot password action
                          },
                          child: Center(
                            child: Text(
                              'Forgotten Password?',
                              style: TextStyle(color: MyColors.bluePrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BuildBtn(
                  title: 'Create new account',
                  onPressed: () {
                    // Handle account creation
                  },
                  borderColor: MyColors.grey.withOpacity(0.2),
                  buttonColor: MyColors.white,
                  textColor: MyColors.bluePrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: MyColors.black, fontSize: 14),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: MyColors.red, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(
            color: MyColors.black, // Input text color
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: MyColors.grey, // Hint text color
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: MyColors.grey), // Border color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: MyColors.grey), // Border color for enabled state
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: MyColors.bluePrimary,
                  width: 2), // Border color for focused state
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            // Background color
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  void loginMode(BuildContext context) {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

      postRequest(
        route: 'https://dummyjson.com/auth/login',
        isAuthorized: false,
        payload: {
          "username": usernameController.text.trim(),
          "password": passwordController.text.trim(),
          "expiresInMins": 60
        },
      ).then((ApiResponse response) async {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        if (response.type == ApiResponseType.success) {
          dPrint('login successful');
          dynamic json = jsonDecode(response.response);

          dPrint('login user::: ${json}');
          nextScreen(context, const DashboardScreen());
        } else if (response.type == ApiResponseType.failed) {
          dynamic json = jsonDecode(response.response);
          dialog(context, 'Login Error',
              json['message'] ?? AppStrings.unknownError);
        } else if (response.type == ApiResponseType.server) {
          dialog(context, 'Network Error', AppStrings.internetError);
        } else {
          dialog(context, 'Login Error', AppStrings.unknownError);
        }
      });
    }
  }

  void dialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(title),
            content: Text(
                message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }



