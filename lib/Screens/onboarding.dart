import 'package:flutter/material.dart';
import 'package:task/utils/colors.dart';
import 'package:task/widgets/custom_button.dart';
import '../widgets/indicator_widget.dart';
import 'LocationScreen/location_screen.dart';
import 'onboarding2.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Image.asset(
                    "assets/images/giftoonbord1.gif",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                //=================  Skip text top-right ======================//
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LocationScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ====================  Text + Indicator + Button Section
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              color: Colors.grey.shade900,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sync with Nature’s\nRhythm",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    "Experience a peaceful transition into the evening with an alarm "
                    "that aligns with the sunset.\nYour perfect reminder, always "
                    "15 minutes before sundown.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  PageIndicator(color: AppColors.primaryColor),
                  const SizedBox(height: 20),

                  CustomButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Onboarding2(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
