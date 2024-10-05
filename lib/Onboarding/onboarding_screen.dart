import 'package:flutter/material.dart';
import 'package:flutter_onboarding/Onboarding/onboarding_item.dart';
import 'package:flutter_onboarding/home_screen.dart';
import 'package:flutter_onboarding/resources/colors/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final onBoardingController = OnboardingItems();
  final pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index){
            isLastPage = onBoardingController.items.length-1 == index;
            setState(() {});
          },
          itemCount: onBoardingController.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(onBoardingController.items[index].image),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  onBoardingController.items[index].title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  onBoardingController.items[index].description,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Next Button
                  TextButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: const Text("Next"),
                  ),

                  // Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onBoardingController.items.length,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    effect: const WormEffect(
                        activeDotColor: AppColors.primaryColor,
                        dotHeight: 12,
                        dotWidth: 12),
                  ),

                  // Skip Button
                  TextButton(
                    onPressed: () {
                      pageController.jumpToPage(onBoardingController.items.length - 1);
                    },
                    child: const Text("Skip"),
                  ),
                ],
              ),
      ),
    );
  }

  //Get started button
  Widget getStarted() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        child: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
