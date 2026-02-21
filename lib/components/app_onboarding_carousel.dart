// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:menuapp/components/app_image.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class AppOnboardingCarousel extends StatefulWidget {
//   final double screenHeight;
//   final List<AppImage> items;
//   const AppOnboardingCarousel({
//     super.key,
//     required this.screenHeight,
//     required this.items,
//   });

//   @override
//   State<AppOnboardingCarousel> createState() => _AppOnboardingCarouselState();
// }

// class _AppOnboardingCarouselState extends State<AppOnboardingCarousel> {
//   //check if the items are emapty and set it with default value with two images on init state

//   @override
//   void initState() {
//     super.initState();
//     if (widget.items.isEmpty) {
//       widget.items.addAll([
//         AppImage(imagePath: 'assets/images/offer_1.png'),
//         AppImage(imagePath: 'assets/images/offer_2.png'),
//       ]);
//     }
//   }

//   int activeIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider.builder(
//           itemCount: widget.items.length,
//           itemBuilder: (context, index, realIndex) {
//             return widget.items[index];
//           },
//           options: CarouselOptions(
//             height: widget.screenHeight,
//             autoPlay: true,
//             autoPlayInterval: Duration(seconds: 3),
//             enlargeCenterPage: true,
//             viewportFraction: 0.85,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 activeIndex = index;
//               });
//             },
//           ),
//         ),
//         const SizedBox(height: 12),

//         //  Indicator
//         AnimatedSmoothIndicator(
//           activeIndex: activeIndex,
//           count: widget.items.length,
//           effect: ScrollingDotsEffect(
//             dotHeight: 8,
//             dotWidth: 8,
//             activeDotColor: Colors.red,
//             dotColor: Colors.grey.shade300,
//             spacing: 6,
//           ),
//         ),
//       ],
//     );
//   }
// }
