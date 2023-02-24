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
          child: ImageSlideshow(
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Fredbull-banner.jpg?alt=media&token=e4e1d457-b399-4882-ae8f-40ab52efd496",
                fit: BoxFit.fill,
              ),
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Fthtruemilk-banner.jpg?alt=media&token=ccb304fa-cc74-4b87-a1ba-6cb8d0d491ec",
                fit: BoxFit.fill,
              )
            ],
            autoPlayInterval: 3000,
            isLoop: true,
          ),
        ));
  }
}
