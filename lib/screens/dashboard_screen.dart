import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/screens/mini_games_screen.dart';
import 'package:test/screens/video_player_screen.dart';
import 'package:test/utils/my_colors.dart';

import '../utils/next_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = -1;
  late PageController _pageController;
  late List<String> videoUrls;

  // State variables for likes and bookmarks
  List<bool> isLiked = [];
  List<int> likeCounts = [];
  List<bool> isBookmarked = [];
  List<int> bookmarkCounts = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // List of video URLs for each screen
    videoUrls = [
      'assets/videos/one.mp4',
      'assets/videos/two.mp4',
      'assets/videos/three.mp4',
      'assets/videos/four.mp4',
      'assets/videos/five.mp4',
    ];

    // Initialize like and bookmark states with random values
    isLiked = List.generate(videoUrls.length, (index) => index.isEven); // Randomly set some as liked
    likeCounts = List.generate(videoUrls.length, (index) => 1 + random.nextInt(30)); // Random initial like count
    isBookmarked = List.generate(videoUrls.length, (index) => index.isOdd); // Randomly set some as bookmarked
    bookmarkCounts = List.generate(videoUrls.length, (index) => 5 +random.nextInt(50)); // Random initial bookmark count

  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void toggleLike(int index) {
    setState(() {
      isLiked[index] = !isLiked[index];
      likeCounts[index] += isLiked[index] ? 1 : -1;
    });
  }

  void toggleBookmark(int index) {
    setState(() {
      isBookmarked[index] = !isBookmarked[index];
      bookmarkCounts[index] += isBookmarked[index] ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      bottomNavigationBar: BottomAppBar(
        height: 90.0,
        color: MyColors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem('assets/images/mini-game.svg', 'Mini Apps', 0),
              _buildNavItem('assets/images/chat.svg', 'Messages', 1),
              _buildFloatingActionButton(),
              _buildNavItem('assets/images/notification.svg', 'Notifications', 2),
              _buildNavItem('assets/images/profile.svg', 'Profile', 3),
            ],
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Full-screen Video Player
              Positioned.fill(
                child: VideoPlayerScreen(videoUrl: videoUrls[index]),
              ),
              // Top Section (AppBar)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/menu.svg',
                        height: 25,
                        width: 25,
                      ),
                      Row(
                        children: [
                          _buildTopTab('LIVE', false),
                          _buildTopTab('Following', false),
                          _buildTopTab('For You', true),
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/images/search-normal.svg',
                        height: 25,
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
              // Right Vertical Interaction Buttons
              Positioned(
                right: 16,
                bottom: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildProfileImage(),
                    const SizedBox(height: 20),
                    _buildVerticalActionButton(
                      'assets/images/like.svg',
                      '${likeCounts[index]}',
                          () => toggleLike(index),
                      isLiked[index],
                    ),
                    _buildVerticalActionButton('assets/images/live-chat.svg', '17'),
                    _buildVerticalActionButton(
                      'assets/images/bookmark.svg',
                      '${bookmarkCounts[index]}',
                          () => toggleBookmark(index),
                      isBookmarked[index],
                    ),

                    _buildVerticalActionButton('assets/images/reply.svg', '24'),
                  ],
                ),
              ),
              // Bottom Interaction Section
              Positioned(
                bottom: 10,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shop section
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.shopColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/shop.svg',
                                height: 15,
                                width: 15,
                              ),
                              const SizedBox(width: 4),
                               Text(
                                'Shop ',
                                style: TextStyle(color: MyColors.white),
                              ),
                              SvgPicture.asset(
                                'assets/images/dot.svg',
                                height: 3,
                                width: 3,
                              ),
                               Text(
                                ' 4',
                                style: TextStyle(color: MyColors.white),
                              ),
                              const SizedBox(width: 4),
                              SvgPicture.asset(
                                'assets/images/shop-down.svg',
                                height: 10,
                                width: 10,
                              ),
                              const SizedBox(width: 2),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // User info and description
                    Text(
                      'Username',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    RichText(
                      text: TextSpan(
                        text: 'This happens to be a great match!...',
                        style: TextStyle(color: MyColors.white, fontSize: 14, fontWeight: FontWeight.w500,),
                        children: [
                          TextSpan(
                            text: 'See more',
                            style: TextStyle(color: MyColors.white, fontSize: 12, fontWeight: FontWeight.w500,),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.musicColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/music.svg',
                                height: 15,
                                width: 15,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Falz - How Many (feat...',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.musicColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/effect.svg',
                                height: 15,
                                width: 15,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Effect Name',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                        const SizedBox(width: 60.0, height: 20.0),
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/mini-music-square.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVerticalActionButton(
      String icon, String label, [VoidCallback? onPressed, bool isSelected = false]) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: 25,
            width: 25,
            color: isSelected ? MyColors.red : null, // Highlight when selected
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: MyColors.white, fontSize: 12),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;

          if(index == 0){
            nextScreen(context, const MiniGamesScreen());
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            color: isSelected ? MyColors.white : Colors.white70,
            height: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? MyColors.white : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return GestureDetector(
      onTap: () {
        // Handle "+" button press
      },
      child: SizedBox(
        height: 90,
        child: SvgPicture.asset(
          'assets/images/add-square.svg',
        ),
      ),
    );
  }

  Widget _buildTopTab(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? MyColors.white : Colors.white70,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              width: 30,
              color: MyColors.white,
            )
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return const Column(
      children: [
        SizedBox(height: 16),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/pic.png'),
        ),
      ],
    );
  }

}
