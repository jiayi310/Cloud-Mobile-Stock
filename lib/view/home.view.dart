import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../api/base.client.dart';
import '../models/Menu.dart';
import 'Settings/settings.screen.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final storage = new FlutterSecureStorage();
  double containerheight = 0;
  String? username;

  @override
  void initState() {
    super.initState();
    // _initData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
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
              // if (res is String) {
              //   if (res != null)
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => StockDetails(id: res)));
              // }
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
                                'Welcome back,',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                username.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                DateFormat('dd MMM, yyyy')
                                    .format(DateTime.now()),
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
                        padding: EdgeInsets.only(top: 5),
                        child: TypeAheadField<Menu>(
                            hideSuggestionsOnKeyboardHide: true,
                            textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    hintText: 'Search')),
                            suggestionsCallback: getMenuSuggestions,
                            itemBuilder: (context, Menu suggestion) {
                              final menu = suggestion;

                              return ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    menu.img.toString(),
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                                title: Text(menu.title.toString()),
                              );
                            },
                            onSuggestionSelected: (Menu suggestions) {
                              final _menu = suggestions;

                              if (_menu.title != "ClockIn")
                                Navigator.push(context,
                                    MaterialPageRoute(builder: _menu.nav!));
                              else
                                Fluttertoast.showToast(
                                  msg: "Coming Soon.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
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
                        ]),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [_tabController1(), _tabController2()],
                      ),
                    ),

                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   width: double.maxFinite,
                    //   height:
                    //       MediaQuery.of(context).size.height + containerheight,
                    //   child: TabBarView(
                    //       controller: _tabController,
                    //       children: <Widget>[
                    //         _tabController1(),
                    //         _tabController2(),
                    //         Container(
                    //           width: double.maxFinite,
                    //           height: 300,
                    //         ),
                    //       ]),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _tabController1() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.extent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 11,
        mainAxisSpacing: 11,
        childAspectRatio: (1 / 1),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          for (int i = 0; i < menu_list.length; i++)
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: menu_list[i].nav!));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: HexColor(menu_list[i].color!),
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
                    Image.asset(menu_list[i].img!),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      menu_list[i].title!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  _tabController2() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.extent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 11,
        mainAxisSpacing: 11,
        childAspectRatio: (1 / 1),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          for (int i = 0; i < warehouse_menu_list.length; i++)
            InkWell(
              onTap: () {
                Fluttertoast.showToast(
                  msg: "Coming Soon.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: warehouse_menu_list[i].nav!));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: HexColor(warehouse_menu_list[i].color!),
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
                      warehouse_menu_list[i].img!,
                      width: 110,
                      height: 110,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      warehouse_menu_list[i].title!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<List<Menu>> getMenuSuggestions(String query) async {
    List<Menu> menulist = new List.from(menu_list)..addAll(warehouse_menu_list);
    if (query.length > 0) {
      return menulist.where((menutitle) {
        final nameLower = menutitle.title.toString().toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else
      return List.empty();
  }

  void updateMobileRemember() async {
    String? email = await storage.read(key: "email");
    await BaseClient()
        .get('/UpdateMobileRemember?email=' + email! + '&grant=0');
  }

  Future<void> getData() async {
    String? _username2 = await storage.read(key: "username");

    setState(() {
      username = _username2;
    });
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
