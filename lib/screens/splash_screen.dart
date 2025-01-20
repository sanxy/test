
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/screens/pre_load_screen.dart';
import '../utils/next_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {

    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
     nextScreenReplace(context, const PreLoadScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF3366FF), // Top color of the gradient
            Color(0xFF003399), // Bottom color of the gradient
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

        // backgroundColor: MyColors.backgroundColor,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/splash.svg',
                    height: 78,
                    width: 78,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Connect. Shop. Play.\nEarn with us",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ],
              ),
            ),

            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Text(
                'All right reserved \n (c) 2024',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),

    );
  }
}