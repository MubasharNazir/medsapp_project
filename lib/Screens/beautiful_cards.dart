import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:medsapp_project/Screens/dashbored.dart';
import 'package:medsapp_project/widgets/custom_button.dart';

class BeautifulCards extends StatefulWidget {
  @override
  State<BeautifulCards> createState() => _BeautifulCardsState();
}

class _BeautifulCardsState extends State<BeautifulCards> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffF50057),
          title: Text(
            '   MeDsApp',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image(image: AssetImage('assets/images/1.png')),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome Here !',
                    style: TextStyle(
                      color: Color(0xffF50057),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      //fontWeight: FontWeight.bold
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'We are delighted to have you onboard! Discover our apps features now',
                    style: TextStyle(
                      // color: Color(0xffF50057),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      // fontWeight: FontWeight.bold
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 170,
                child: HorizontalSlideshow(),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: CustomButton(
                      text: 'Lets Start',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Dashbored();
                        }));
                      }))
            ],
          ),
        ),
        // bottomNavigationBar: Container(
        // color: Colors.red,
        //  height: 60,
        // width: double.infinity,
        // padding: EdgeInsets.only(left: 120, right: 60, bottom: 10, top: 10),
        //color: Colors.red,
        //     child: Row(
        //       children: [
        //         Text(
        //           'Lets Start',
        //           style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
        //         ),
        //   //       Container(
        //   //         child: IconButton(onPressed: () {}, icon: Icon(Icons.forward)),
        //   //       )
        //   //     ],
        //   //   ),
      ),
    );
  }
}

class HorizontalSlideshow extends StatefulWidget {
  @override
  _HorizontalSlideshowState createState() => _HorizontalSlideshowState();
}

class _HorizontalSlideshowState extends State<HorizontalSlideshow> {
  final List<SlideshowItem> slides = [
    SlideshowItem(
      // backgroundImage: 'assets/images/1.png',
      title: 'Donate Medicine',
      description:
          'Support life-changing initiatives with your donations. Empower communities, provide resources, and create lasting impact.',
    ),
    SlideshowItem(
      // backgroundImage: 'assets/images/2.png',
      title: 'Donation Purpose',
      description:
          'Medicine donation is an act of giving medications for humanitarian purposes to those in need.',
    ),
    SlideshowItem(
      // backgroundImage: 'assets/images/3.png',
      title: 'Check Donations Here',
      description:
          'Track donated medicine with location-based distance in kilometers. Stay informed about the impact of your contributions in real-time.',
    ),
    SlideshowItem(
      // backgroundImage: 'assets/images/4.png',
      title: 'Find Alternatives ',
      description:
          'Discover alternative medicines here. Explore effective remedies for your health needs. Embrace new possibilities for a healthier you',
    ),
  ];

  PageController _pageController = PageController();
  int _currentPage = 0;
  final _duration = Duration(seconds: 4);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(_duration, (timer) {
      if (_currentPage < slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: slides.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: slides[index],
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: DotsIndicator(
            dotsCount: slides.length,
            position: _currentPage.toDouble().round(),
            decorator: DotsDecorator(
              color: Colors.white,
              activeColor: Color(0xffF50057),
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              spacing: const EdgeInsets.symmetric(horizontal: 2.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SlideshowItem extends StatefulWidget {
  //final String backgroundImage;
  final String title;
  final String description;

  SlideshowItem({
    // required this.backgroundImage,
    required this.title,
    required this.description,
  });

  @override
  State<SlideshowItem> createState() => _SlideshowItemState();
}

class _SlideshowItemState extends State<SlideshowItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        // height: 150,
        // height: 250,
        // width: MediaQuery.of(context).size.width * 0.85,
        // decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(16.0),
        //image: DecorationImage(
        // image: AssetImage(widget.backgroundImage),
        // fit: BoxFit.cover,

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF50057),
                ),
              ),
              SizedBox(height: 7),
              Text(
                widget.description,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  //color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
