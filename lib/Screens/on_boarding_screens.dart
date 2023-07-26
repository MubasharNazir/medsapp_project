import 'dart:ui';

import 'package:flutter/material.dart';

import '../Models/onboarding_model.dart';
import '../constains/onboardibd_screen_sizes.dart';
import 'login_screen1.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = [
    Colors.grey.shade50,
    Colors.grey.shade50,
    Colors.grey.shade50,
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xffF50057),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    Color backgroundColor = colors[i];
                    return Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          // ColorFiltered(
                          //   colorFilter: ColorFilter.mode(
                          //     backgroundColor.withOpacity(
                          //         0.0), // Adjust the opacity as needed
                          //     BlendMode.srcIn,
                          //   ),
                          // child:
                          // Container(
                          //   color: backgroundColor.withOpacity(0.5),
                          //   child: Image.asset(
                          //     contents[i].image,
                          //     height: SizeConfig.blockV! * 35,
                          //   ),
                          // ),
                          //  ),
                          Container(
                            height: SizeConfig.blockV! * 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: backgroundColor,
                              image: DecorationImage(
                                image: AssetImage(contents[i].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                              child: Container(
                                color: backgroundColor.withOpacity(0.3),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: (height >= 840) ? 60 : 40,
                          ),
                          Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: (width <= 550) ? 20 : 25,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            contents[i].desc,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: (width <= 550) ? 14 : 16,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (int index) => _buildDots(
                          index: index,
                        ),
                      ),
                    ),
                    _currentPage + 1 == contents.length
                        ? Padding(
                            padding: const EdgeInsets.all(30),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: const Text("START",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  )),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF50057),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: (width <= 550)
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 20)
                                    : EdgeInsets.symmetric(
                                        horizontal: width * 0.2, vertical: 25),
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _controller.jumpToPage(2);
                                  },
                                  child: const Text(
                                    "SKIP",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: (width <= 550) ? 13 : 17,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: const Text(
                                    "NEXT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    //  backgroundColor: Colors.red,
                                    backgroundColor: Color(0xffF50057),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    elevation: 0,
                                    padding: (width <= 550)
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 20)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 25),
                                    textStyle: TextStyle(
                                        fontSize: (width <= 550) ? 13 : 17),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
