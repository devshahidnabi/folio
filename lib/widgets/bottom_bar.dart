import 'package:flutter/material.dart';
import 'package:folio/widgets/custom_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
              height: 2,
              width: screenWidth * 0.9,
              color: Colors.white,
            )),
        Container(
          height: screenHeight * 0.05,
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, right: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CustomIconButton(
                      iconData: FontAwesomeIcons.youtube,
                      url:
                      'https://www.youtube.com/channel/UC8_LfLDVAHP-5lQXRbifbDw',
                      color: Colors.red,
                    ),
                    SizedBox(width: screenWidth * 0.021),
                    const CustomIconButton(
                      iconData: FontAwesomeIcons.github,
                      url: 'https://github.com/devshahidnabi',
                      color: Colors.white,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    const CustomIconButton(
                      iconData: FontAwesomeIcons.linkedin,
                      url: 'https://www.linkedin.com/in/devshahidnabi/',
                      color: Colors.blue,
                    ),
                    SizedBox(width: screenWidth * 0.021),
                    const CustomIconButton(
                      iconData: FontAwesomeIcons.instagram,
                      url: 'https://www.instagram.com/devshahidnabi/',
                      color: Colors.deepOrangeAccent,
                    ),
                  ],
                ),
                const Text('Made with Flutter Web \u00a9 2021',
                    style: TextStyle(color: Colors.white, fontFamily: 'Barlow')),
              ],
            ),
          ),
        )
      ],
    );
  }
}