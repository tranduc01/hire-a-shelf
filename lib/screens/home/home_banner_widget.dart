import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ImageSlideshow(children: [
            Image.network(
              "https://s3.ap-southeast-1.amazonaws.com/hireashelf.com/resource/redbull-banner.jpg",
              fit: BoxFit.fill,
            ),
            Image.asset(
              "assets/images/thtruemilk-banner.jpg",
              fit: BoxFit.fill,
            )
          ]),
        ));
  }
}
