import 'package:flutter/material.dart';
import 'package:grocery_app/app.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

import 'home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  homeScreenIcon(),
                  SizedBox(
                    height: 5,
                  ),
                  padded(locationWidget()),
                  SizedBox(
                    height: 15,
                  ),
                  padded(SearchBarWidget()),
                  SizedBox(
                    height: 25,
                  ),
                  padded(HomeBanner()),
                  SizedBox(
                    height: 25,
                  ),
                  padded(subTitle("Ending Soon")),
                  getHorizontalItemSliderOrdered(),
                  SizedBox(
                    height: 15,
                  ),
                  padded(subTitle("Now Available")),
                  getHorizontalItemSlider(),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: FutureBuilder<List<Campaign>>(
        future: fetchCampaigns(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Campaign> campaigns = snapshot.data as List<Campaign>;
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: campaigns.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onItemClicked(context, campaigns[index]);
                  },
                  child: GroceryItemCardWidget(
                    campaign: campaigns[index],
                    heroSuffix: "home_screen",
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20,
                );
              },
            );
          } else {
            print(snapshot.error.toString());
            return Text('error');
          }
        },
      ),
    );
  }

  Widget getHorizontalItemSliderOrdered() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: FutureBuilder<List<Campaign>>(
        future: fetchCampaignsOrderByExp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Campaign> campaigns = snapshot.data as List<Campaign>;
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: campaigns.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onItemClicked(context, campaigns[index]);
                  },
                  child: GroceryItemCardWidget(
                    campaign: campaigns[index],
                    heroSuffix: "home_screen",
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20,
                );
              },
            );
          } else {
            print(snapshot.error.toString());
            return Text('error');
          }
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, Campaign campaign) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                campaign,
                heroSuffix: "home_screen",
              )),
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          "See All",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 13, 14, 13)),
        ),
      ],
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/icons/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "Hire a Shelf",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget homeScreenIcon() {
    String iconPath = "assets/icons/splash_screen_icon.svg";
    return SvgPicture.asset(
      iconPath,
      height: 40,
      width: 40,
    );
  }
}
