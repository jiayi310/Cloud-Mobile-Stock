import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/General/Location/location.add.dart';

import '../../../api/base.client.dart';
import '../../../models/Location.dart';
import '../../../utils/loading.dart';

class LocationHomeScreen extends StatefulWidget {
  LocationHomeScreen({Key? key, this.FromSource}) : super(key: key);
  String? FromSource;

  @override
  State<LocationHomeScreen> createState() =>
      _LocationHomeScreen(FromSource: FromSource);
}

class _LocationHomeScreen extends State<LocationHomeScreen> {
  String? FromSource;
  _LocationHomeScreen({Key? key, this.FromSource});
  bool shouldShowFB = true;
  bool _visible = false;
  List<Location> locationList = [];
  List<Location> locationList_search = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Location> userFromJson(String str) =>
      List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

  late final Future myfuture;

  @override
  void initState() {
    super.initState();
    myfuture = getLocationData();
    if (FromSource != null) {
      shouldShowFB = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: shouldShowFB,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewLocation(
                          isEdit: false,
                          location: Location(),
                        ))).then((value) {
              if (value == "Done") getLocationData();
            });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pinkAccent,
        ),
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Location",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                _toggle();
              },
              child: Icon(
                Icons.search,
                size: 25,
                color: GlobalColors.mainColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Visibility(
                visible: _visible,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: GlobalColors.mainColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
                          width: MediaQuery.of(context).size.width - 118,
                          child: TextFormField(
                            onChanged: searchQuery,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Search"),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.camera_alt)),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: myfuture,
                  builder: (context, snapshort) {
                    if (snapshort.hasData) {
                      return ListView.builder(
                          itemCount: locationList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                              onLongPress: () {
                                if (FromSource == null)
                                  Get.defaultDialog(
                                      cancelTextColor: GlobalColors.mainColor,
                                      confirmTextColor: Colors.white,
                                      buttonColor: GlobalColors.mainColor,
                                      titlePadding: EdgeInsets.only(top: 20),
                                      title: "Warning",
                                      onConfirm: () {
                                        deleteLocation(locationList[i]);
                                      },
                                      content: Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                "Are you sure want to delete " +
                                                    locationList[i]
                                                        .location
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      textConfirm: "Confirm",
                                      textCancel: "Cancel");
                              },
                              onTap: () {
                                // if (FromSource != null) {
                                //   Navigator.pop(context, locationList[i]);
                                // } else {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => LocationDetails(
                                //             Locationid:
                                //                 locationList[i].LocationID!),
                                //       ));
                                // }
                              },
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        locationList[i]
                                                                .location ??
                                                            "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  if (locationList[i].phone1 !=
                                                      null)
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: GlobalColors
                                                              .mainColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Text(
                                                        locationList[i]
                                                                .phone1 ??
                                                            "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else
                      return const LoadingPage();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<List<Location>> getLocationData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Location/GetLocationList?companyid=' + companyid);
      List<Location> _locationList = userFromJson(response);

      setState(() {
        locationList_search = _locationList;
        locationList = _locationList;
      });
    }
    return locationList;
  }

  void searchQuery(String query) {
    final suggestions = locationList_search.where((cus) {
      final locCode = cus.locationID?.toString().toLowerCase() ?? "";
      final locName = cus.location!.toString().toLowerCase() ?? "";
      final phone = cus.phone1.toString().toLowerCase();
      final input = query.toLowerCase();

      return locName.contains(input) ||
          locCode.contains(input) ||
          phone.contains(input);
    }).toList();

    setState(() {
      locationList = suggestions;
    });
  }

  Future<void> deleteLocation(Location Location) async {
    String response = await BaseClient().post(
        '/Location/DeleteLocation',
        jsonEncode({
          "LocationID": Location.locationID.toString(),
          "LocationCode": Location.location.toString(),
          "companyID": companyid
        }));

    if (response != null) {
      Fluttertoast.showToast(
        msg: 'Deleted successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      await getLocationData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location deleted successfully')),
      );
    } else {}
  }
}
