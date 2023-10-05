import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Stock/StockDetails/details.view.dart';
import 'package:mobilestock/view/home.phone.view.dart';
import 'package:mobilestock/view/home.tablet.view.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../api/base.client.dart';
import 'SalesWorkflow/sales.workflow.dart';
import 'Settings/settings.screen.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final storage = new FlutterSecureStorage();
  double containerheight = 0;
  List menu = [];
  String deviceType = "Phone";

  _initData() {
    DefaultAssetBundle.of(context)
        .loadString("assets/home_menu.json")
        .then((value) {
      setState(() {
        menu = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //_initData();
    _getDeviceType();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    containerheight = ((MediaQuery.of(context).size.width - 90) / 2) + 20;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
                ));
            setState(() {
              if (res is String) {
                if (res != null)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockDetails(product: res)));
              }
            });
          },
          child: Icon(Icons.qr_code_scanner),
          backgroundColor: GlobalColors.mainColor,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 1)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back,',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Jainul Arafa',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '23 Jan, 2023',
                                ),
                              ],
                            ),
                            //Logout
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                updateMobileRemember();
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.logout,
                                  color: GlobalColors.mainColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        //searchbar
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                    offset: Offset(5, 5))
                              ]),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Search',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          isScrollable: true,
                          unselectedLabelColor: Colors.grey,
                          indicator: CircleTabIndicator(
                              color: GlobalColors.mainColor, radius: 4),
                          tabs: [
                            Tab(
                              text: "Sales Ordering",
                            ),
                            Tab(
                              text: "Warehouse Management",
                            ),
                            Tab(text: "Others")
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.maxFinite,
                      height:
                          MediaQuery.of(context).size.height + containerheight,
                      child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            _tabController1(),
                            Container(
                              width: double.maxFinite,
                              height: 300,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 300,
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _tabController1() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Today task",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 110,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: CupertinoColors.activeBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "Job Task 1",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "6:00PM - 10:00PM",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "Job Description 123........",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (deviceType == "Phone") PhoneView(),
        if (deviceType == "Tablet") TabletView()
      ],
    );
  }

  int _getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    if (data.size.shortestSide < 600) {
      //phone
      deviceType = "Phone";
      return (menu.length.toDouble() / 2).toInt();
    } else {
      //tablet
      deviceType = "Tablet";
      return (menu.length.toDouble() / 4).toInt();
    }
  }

  void updateMobileRemember() async {
    String? email = await storage.read(key: "email");
    await BaseClient()
        .get('/UpdateMobileRemember?email=' + email! + '&grant=0');
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;

    final Offset circleOffset = offset +
        Offset(
            configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
