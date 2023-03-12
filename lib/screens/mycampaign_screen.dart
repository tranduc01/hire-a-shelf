import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/models/account.dart';
import 'package:grocery_app/widgets/category_item_card_widget.dart';

import '../models/campaign.dart';

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
    with SingleTickerProviderStateMixin {
  final storage = new FlutterSecureStorage();
  String _jwt = "";
  Account? account;
  // Animation controller
  late AnimationController animationController;

  // This is used to animate the icon of the main FAB
  late Animation<double> buttonAnimatedIcon;

  // This is used for the child FABs
  Animation<double>? translateButton;

  // This variable determnies whether the child FABs are visible or not
  bool _isExpanded = false;

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
    getAccount();
    super.initState();
  }

  // dispose the animation controller
  @override
  dispose() {
    animationController.dispose();
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
      var accId = int.parse(id!);
      var acc = await fetchAccountById(accId);
      setState(() {
        _jwt = jwt;
        account = acc;
      });
    } else {
      setState(() {
        _jwt = "";
      });
    }
  }

  @override
  void didUpdateWidget(covariant MyCampaignScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    getAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: getFloatingButton(_jwt),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: getGridViewItem(_jwt, context),
              ),
            ],
          ),
        ));
  }

  Widget getStaggeredGridView() {
    return FutureBuilder<List<Campaign>>(
      future: fetchCampaigns(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Campaign> campaigns = snapshot.data as List<Campaign>;
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            itemCount: campaigns.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: CategoryItemCardWidget(
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

  getGridViewItem(String jwt, BuildContext context) {
    if (jwt != "") {
      if (account!.brand != null) {
        return getStaggeredGridView();
      } else if (account!.store != null) {
        return Text("This is My Campaign Screen for store!");
      } else {
        return Text("You are admin");
      }
    } else {
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
  }
}
