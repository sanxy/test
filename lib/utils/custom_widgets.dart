import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/utils/my_colors.dart';


class BuildBtn extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color textColor;
  final void Function()? onPressed;
  final String? prefix;
  final Color? borderColor;
  final Color? iconColor;
  final bool? showLoadingIcon;
  final bool? enabled;

  const BuildBtn({
    super.key,
    required this.title,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
    this.prefix,
    this.borderColor,
    this.iconColor = Colors.white,
    this.showLoadingIcon = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled! && !showLoadingIcon!
                ? buttonColor
                : buttonColor.withOpacity(0.5),
            foregroundColor: enabled! && !showLoadingIcon!
                ? Colors.white
                : buttonColor.withOpacity(0.1),
            elevation: 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            shape: RoundedRectangleBorder(
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: 1.5)
                  : BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          onPressed: !enabled!
              ? null
              : showLoadingIcon!
              ? null
              : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefix != null
                  ? Row(
                  children: [
                    SvgPicture.asset(prefix!, colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn), height: 20),
                    const SizedBox(width: 10)
                  ])
                  : const SizedBox(),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  letterSpacing: 0.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              showLoadingIcon!
                  ? Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: iconColor,
                    strokeWidth: 3,
                  ),
                ),
              )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String icon;
  final bool isDarkTheme;

  const GameCard({
    required this.title,
    required this.icon,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 18.0),
      child: Column(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(icon),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GameCategory extends StatelessWidget {
  final String icon;
  final bool isDarkTheme;

  const GameCategory({super.key,
    required this.icon,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 18.0),
      child: Row(
        children: [
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(icon),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Game 1',
                  style: TextStyle(
                    color: isDarkTheme ? MyColors.white : MyColors.black,
                  ),
                ),
                Text(
                  'Hello game',
                  style: TextStyle(
                    color: MyColors.grey,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}




