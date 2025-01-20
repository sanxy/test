import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/screens/dashboard_screen.dart';
import 'package:test/utils/my_colors.dart';
import '../utils/custom_widgets.dart';
import '../utils/next_screen.dart';


class MiniGamesScreen extends StatefulWidget {
  const MiniGamesScreen({super.key});

  @override
  _MiniGamesScreenState createState() => _MiniGamesScreenState();
}

class _MiniGamesScreenState extends State<MiniGamesScreen> {
  bool isDarkTheme = true;

  List<String> gameIcons = [
  'assets/images/game-one.png',
  'assets/images/game-two.png',
  'assets/images/game-three.png',
  'assets/images/game-four.png',
  ];

  List<String> gameCategory = [
    'assets/images/game-one.png',
    'assets/images/game-five.png',
    'assets/images/game-six.png',
    'assets/images/game-seven.jpeg',
    'assets/images/game-eight.jpeg',
    'assets/images/game-nine.jpeg',
  ];

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 700,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/mini-dark.png'),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),

                // Top Section (AppBar)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            nextScreenReplace(context, const DashboardScreen());
                          },
                          child: SvgPicture.asset(
                            'assets/images/arrow-left.svg',
                            height: 25,
                            width: 25,
                            color: isDarkTheme ? MyColors.white : MyColors.black,
                          ),
                        ),
                        Text(
                          'Mini Apps',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),

                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/search.svg',
                              height: 25,
                              width: 25,
                              color: isDarkTheme ? MyColors.white : MyColors.black,
                            ),
                            const SizedBox(width: 6),
                            SvgPicture.asset(
                              'assets/images/ranking.svg',
                              height: 25,
                              width: 25,
                              color: isDarkTheme ? MyColors.white : MyColors.black,
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: (){
                                // this changes the background and text color
                                toggleTheme();
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: isDarkTheme ? MyColors.white : MyColors.black,
                                backgroundImage: AssetImage('assets/images/avatar.png'),
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            //this hold the trending, category and recently opened view
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'Trending games from 30 days',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: MyColors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(4, (index) {
                        return GameCard(
                          title: 'Game ${index + 1}',
                          icon: gameIcons[index],
                          isDarkTheme: isDarkTheme,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GameCategory(
                              icon: gameCategory[0],
                              isDarkTheme: isDarkTheme,
                            ),
                            const SizedBox(width: 180),

                            GameCategory(
                              icon: gameCategory[3],
                              isDarkTheme: isDarkTheme,
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GameCategory(
                              icon: gameCategory[1],
                              isDarkTheme: isDarkTheme,
                            ),
                            const SizedBox(width: 180),
                            GameCategory(
                              icon: gameCategory[4],
                              isDarkTheme: isDarkTheme,
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GameCategory(
                              icon: gameCategory[2],
                              isDarkTheme: isDarkTheme,
                            ),
                            const SizedBox(width: 180),
                            GameCategory(
                              icon: gameCategory[5],
                              isDarkTheme: isDarkTheme,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'Recently Opened',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Here are some of your recently played games',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: MyColors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GameCard(
                          title: 'Game 2',
                          icon: gameIcons[1],
                          isDarkTheme: isDarkTheme,
                        ),
                        GameCard(
                          title: 'Game 4',
                          icon: gameIcons[3],
                          isDarkTheme: isDarkTheme,
                        ),
                        GameCard(
                          title: 'Game 3',
                          icon: gameIcons[2],
                          isDarkTheme: isDarkTheme,
                        ),
                        GameCard(
                          title: 'Game 1',
                          icon: gameIcons[0],
                          isDarkTheme: isDarkTheme,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}


