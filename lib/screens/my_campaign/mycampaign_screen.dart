import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/models/account.dart';
import 'package:grocery_app/models/contract.dart';
import 'package:grocery_app/screens/my_campaign/mycampaign_item_card_widget.dart';
import 'package:grocery_app/screens/my_campaign/mycampaignstore_item_card_widget.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common_widgets/app_button.dart';
import '../../models/campaign.dart';

class MyCampaignScreen extends StatefulWidget {
  MyCampaignScreen({Key? key}) : super(key: key);
  @override
  _MyCampaignState createState() => _MyCampaignState();
}

List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];

class _MyCampaignState extends State<MyCampaignScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final storage = new FlutterSecureStorage();
  String _jwt = "";
  int i = 1;
  Account? account;
  Future<List<Campaign>>? campaigns;
  Future<List<Contract>>? contracts;
  ScrollController scrollController = ScrollController();

  // Animation controller
  late AnimationController animationController;

  // This is used to animate the icon of the main FAB
  late Animation<double> buttonAnimatedIcon;

  // This is used for the child FABs
  Animation<double>? translateButton;

  // This variable determnies whether the child FABs are visible or not
  bool _isExpanded = false;
  @override
  bool get wantKeepAlive => true;
  @override
  initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });

    buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          loadMoreData();
        }
      },
    );
    getAccount();
    super.initState();
  }

  // dispose the animation controller
  @override
  dispose() {
    animationController.dispose();
    // Dispose of the ScrollController
    scrollController.dispose();
    super.dispose();
  }

  // This function is used to expand/collapse the children floating buttons
  // It will be called when the primary FAB (with menu icon) is pressed
  _toggle() {
    if (_isExpanded) {
      animationController.reverse();
    } else {
      animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }

  Future<String?> readFromStorage(String key) async {
    return await storage.read(key: key);
  }

  getAccount() async {
    var id = await readFromStorage("accountId");
    var jwt = await readFromStorage("token");
    if (jwt != null) {
      if (!JwtDecoder.isExpired(jwt)) {
        var accId = int.parse(id!);
        var acc = await fetchAccountById(accId);
        if (acc.brand != null) {
          var campaignList = fetchCampaignsByBrand(acc.brand!.id, 0);
          setState(() {
            campaigns = campaignList;
          });
        } else {
          if (acc.store != null) {
            var contractList = fetchContractByStore(acc.store!.id);
            setState(() {
              contracts = contractList;
            });
          }
        }
        setState(() {
          _jwt = jwt;
          account = acc;
        });
      }
    }
  }

  loadMoreData() async {
    var campaignList = fetchCampaignsByBrand(account!.brand!.id, i++);
    var campaign = campaigns;
    setState(() {
      campaigns = addCampaigns(campaign!, campaignList);
    });
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
  void didUpdateWidget(covariant MyCampaignScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (account != null) {
      if (account!.brand != null) {
        fetchCampaignsByBrand(account!.brand!.id, 0).then((campaignList) {
          setState(() {
            i = 1;
            campaigns = Future.value(campaignList);
          });
        });
      } else if (account!.store != null) {
        var contractList = fetchContractByStore(account!.store!.id);
        setState(() {
          contracts = contractList;
        });
      }
    } else {
      getAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        floatingActionButton: getFloatingButton(_jwt),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: (_jwt != "")
                    ? account!.brand != null
                        ? getBrandCampaignList(campaigns!)
                        : account!.store != null
                            ? getStoreCampaignList(contracts!)
                            : Text("You are admin")
                    : getNotLoginWidget(),
              ),
            ],
          ),
        ));
  }

  Widget getBrandCampaignList(Future<List<Campaign>> campaigns) {
    return FutureBuilder<List<Campaign>>(
      future: campaigns,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Campaign> campaigns = snapshot.data as List<Campaign>;
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            itemCount: campaigns.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        insetPadding: EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          height: 600.0,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Test"),
                              Spacer(
                                flex: 8,
                              ),
                              AppButton(
                                label: "Ok",
                                fontWeight: FontWeight.w600,
                                onPressed: () {
                                  Navigator.pop(dialogContext, 'Cancel');
                                },
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: MyCampaignItemCardWidget(
                    campaign: campaigns[index],
                    color: gridColors[index % gridColors.length],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget getStoreCampaignList(Future<List<Contract>> contracts) {
    return FutureBuilder<List<Contract>>(
      future: contracts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Contract> contracts = snapshot.data as List<Contract>;
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            itemCount: contracts.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: MyCampaignStoreItemCardWidget(
                    contract: contracts[index],
                    color: gridColors[index % gridColors.length],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  getFloatingButton(String jwt) {
    if (jwt != "") {
      if (account!.brand != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                0,
                translateButton!.value * 3,
                0,
              ),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {
                  print("Product");
                },
                icon: const Icon(Icons.add),
                label: Text("Product"),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0,
                translateButton!.value * 2,
                0,
              ),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {
                  print("Campaign");
                },
                icon: const Icon(Icons.add),
                label: Text("Campaign"),
              ),
            ),
            // This is the primary FAB
            FloatingActionButton(
              onPressed: _toggle,
              backgroundColor: Colors.black,
              child: AnimatedIcon(
                icon: AnimatedIcons.add_event,
                progress: buttonAnimatedIcon,
              ),
            ),
          ],
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Widget getNotLoginWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background-error.jpg"),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Please login !!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Your Session has been expired',
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xFF7C7C7C)),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  getGridViewItem(
      String jwt, BuildContext context, Future<List<Campaign>> campaigns) {}
}
