import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Analysis/analysis.view.dart';
import 'package:mobilestock/view/Sales/home.sales.dart';
import 'package:mobilestock/view/SalesWorkflow/sales.workflow.dart';

import '../api/base.client.dart';
import 'Customer/customer.home.dart';
import 'Quotation/quotation.view.dart';
import 'Settings/settings.screen.dart';
import 'Stock/stock.home.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  //Creating sales modules in lists
  List modulesList = ["Customer", "Stock", "Quotation", "Sales", "Analysis"];

  List<Color> modulesColor = [
    Color(0xFFFFCF2F),
    Color(0xFF6FE08D),
    Color(0xFF61BDFD),
    Color(0xFFFC7F7F),
    Color(0xFF0062FF),
  ];

  List<Icon> modulesIcon = [
    Icon(Icons.group, color: Colors.white, size: 30),
    Icon(Icons.indeterminate_check_box, color: Colors.white, size: 30),
    Icon(Icons.book, color: Colors.white, size: 30),
    Icon(Icons.list_alt, color: Colors.white, size: 30),
    Icon(Icons.auto_graph, color: Colors.white, size: 30)
  ];

  //Creating others in lists
  List othersList = [
    //"Backup",
    "Customer", "Stock",
    "About"
  ];

  List<Color> othersColor = [
    //Color(0xFFCB84FB),
    Color(0xFFFFCF2F),
    Color(0xFF6FE08D),
    Color(0xFF61BDFD),
  ];

  List<Icon> othersIcon = [
    // Icon(Icons.backup, color: Colors.white, size: 30),
    Icon(Icons.group, color: Colors.white, size: 30),
    Icon(Icons.indeterminate_check_box, color: Colors.white, size: 30),
    Icon(Icons.info_outline, color: Colors.white, size: 30),
  ];

  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.qr_code_scanner),
          backgroundColor: GlobalColors.mainColor,
        ),
        backgroundColor: GlobalColors.mainColor,
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
        body: SafeArea(
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
                                'Hi Admin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '23 Jan, 2023',
                                style: TextStyle(color: Colors.blue[200]),
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
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      //searchbar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[500],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1000,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  padding: EdgeInsets.all(25),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Choose an action',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SalesWorkFlowPage()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                height:
                                    MediaQuery.of(context).size.width / 2.3 -
                                        40,
                                width: MediaQuery.of(context).size.width / 2.3 -
                                    40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(5.0, 5.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 2.0),
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0)
                                    ]),
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/images/pos-terminal.png'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Sales",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  height:
                                      MediaQuery.of(context).size.width / 2.3 -
                                          40,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3 -
                                          40,
                                  decoration: BoxDecoration(
                                      color: Color(0xD3F3F3F3),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(5.0, 5.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0),
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0)
                                      ]),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/warehouse.png'),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "WMS",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 15,
                                  right: 15,
                                  child: Image.asset("assets/images/lock.png"),
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'General',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 0, right: 0),
                          child: Column(
                            children: [
                              GridView.builder(
                                  itemCount: othersList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            600
                                        ? 3
                                        : 5,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (index == 0) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerHomeScreen()));
                                        } else if (index == 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StockHomeScreen()));
                                        }
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: othersColor[index],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: othersIcon[index],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              othersList[index],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void updateMobileRemember() async {
    String? email = await storage.read(key: "email");
    await BaseClient()
        .get('/UpdateMobileRemember?email=' + email! + '&grant=0');
  }
}
