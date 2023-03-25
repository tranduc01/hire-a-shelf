import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../models/account.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  final token;
  HomeScreen({this.token, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = new FlutterSecureStorage();
  Future<List<Campaign>>? campaigns;
  Future<List<Campaign>>? campaignsNear;
  ScrollController scrollControllerAll = ScrollController();
  ScrollController scrollControllerNear = ScrollController();
  int i = 1;
  @override
  void initState() {
    super.initState();
    _refreshData();
    scrollControllerAll.addListener(
      () {
        if (scrollControllerAll.position.pixels ==
            scrollControllerAll.position.maxScrollExtent) {
          loadMoreDataAll();
        }
      },
    );
    scrollControllerNear.addListener(
      () {
        if (scrollControllerNear.position.pixels ==
            scrollControllerNear.position.maxScrollExtent) {
          loadMoreDataNear();
        }
      },
    );
  }

  Future<String?> readFromStorage(String key) async {
    return await storage.read(key: key);
  }

  Future<void> _refreshData() async {
    var newCampaigns = fetchCampaigns(0);
    var id = await readFromStorage("accountId");
    var jwt = await readFromStorage("token");
    if (jwt != null) {
      if (!JwtDecoder.isExpired(jwt)) {
        var accId = int.parse(id!);
        var acc = await fetchAccountById(accId);
        if (acc.store != null) {
          var campaignList = fetchCampaignsByLocation(acc.store!.id, 0);
          setState(() {
            campaignsNear = campaignList;
          });
        }
      }
      setState(() {
        campaigns = newCampaigns;
      });
    }
  }

  loadMoreDataAll() {
    var campaignList = fetchCampaigns(i++);
    var campaign = campaigns;
    setState(() {
      campaigns = addCampaigns(campaign!, campaignList);
    });
  }

  loadMoreDataNear() {
    print("Near");
  }

  Future<List<Campaign>> addCampaigns(
      Future<List<Campaign>> list1, Future<List<Campaign>> list2) async {
    // Wait for the results of both futures
    List<Campaign> result1 = await list1;
    List<Campaign> result2 = await list2;

    // Concatenate the two lists and return the result
    return List<Campaign>.from([...result1, ...result2]);
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchCampaigns(0).then((campaignList) {
      setState(() {
        i = 1;
        campaigns = Future.value(campaignList);
      });
    });
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
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
                    padded(subTitle("Now Available")),
                    getHorizontalItemSliderAll(campaigns),
                    SizedBox(
                      height: 15,
                    ),
                    padded(subTitle("Near You")),
                    getHorizontalItemSliderNear(campaignsNear),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
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

  Widget getHorizontalItemSliderAll(Future<List<Campaign>>? campaigns) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: FutureBuilder<List<Campaign>>(
        future: campaigns,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Campaign> campaigns = snapshot.data as List<Campaign>;
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: campaigns.length,
              scrollDirection: Axis.horizontal,
              controller: scrollControllerAll,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onItemClicked(context, campaigns[index]);
                  },
                  child: GroceryItemCardWidget(
                    campaign: campaigns[index],
                    heroSuffix: "home_screen_${campaigns[index].id}",
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
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget getHorizontalItemSliderNear(Future<List<Campaign>>? campaigns) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: FutureBuilder<List<Campaign>>(
        future: campaigns,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Campaign> campaigns = snapshot.data!;
            campaigns
                .sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: campaigns.length,
              scrollDirection: Axis.horizontal,
              controller: scrollControllerNear,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onItemClicked(context, campaigns[index]);
                  },
                  child: GroceryItemCardWidget(
                    campaign: campaigns[index],
                    heroSuffix: "home_screen_ordered${campaigns[index].id}",
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
            return Center(child: CircularProgressIndicator());
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
                heroSuffix: "horizontal_slider",
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
