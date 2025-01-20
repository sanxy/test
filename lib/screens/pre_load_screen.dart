import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/screens/login_screen.dart';
import '../utils/custom_widgets.dart';
import '../utils/my_colors.dart';
import '../utils/next_screen.dart';

class PreLoadScreen extends StatefulWidget {
  const PreLoadScreen({super.key});

  @override
  State<PreLoadScreen> createState() => _PreLoadScreenState();
}

class _PreLoadScreenState extends State<PreLoadScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pre_bg.png'),
          fit: BoxFit.cover,
        ),
      ),

      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/splash.svg',
              height: 78,
              width: 78,
            ),
          ),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: BuildBtn(
                      title: 'Log In',
                      onPressed: () {
                        nextScreenReplace(context, const LoginScreen());
                      },
                      buttonColor: MyColors.white,
                      textColor: MyColors.bluePrimary),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: BuildBtn(
                      title: 'Sign Up',
                      onPressed: () {

                      },
                      buttonColor: MyColors.bluePrimary,
                      textColor: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("English",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  'assets/images/arrow-down.svg',
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          )
        ],
      ),

    );
  }
}