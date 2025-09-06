import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/indicator_widget.dart';
import 'LocationScreen/location_screen.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

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
                    "assets/images/onboarding3.gif",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

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

          // 👉 Text Section
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              color: Colors.grey.shade900,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Relax & Unwind",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Font-Family/Text',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "hope to take the courage to pursue your dreams.",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Oxygen',
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  PageIndicator(color2: AppColors.primaryColor),
                  const SizedBox(height: 20),

                  // =================================== custom button page 2 ==================================//
                  CustomButton(
                    text: 'Text',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LocationScreen(),
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
