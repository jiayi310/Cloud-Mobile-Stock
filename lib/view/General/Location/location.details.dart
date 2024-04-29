import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/models/Location.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

import '../../../api/base.client.dart';
import '../../../utils/global.colors.dart';
import 'location.add.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({Key? key, required this.locationid}) : super(key: key);
  final int locationid;

  @override
  State<LocationDetails> createState() =>
      _LocationDetailsState(locationid: locationid);
}

class _LocationDetailsState extends State<LocationDetails> {
  final int locationid;
  _LocationDetailsState({Key? key, required this.locationid});
  String companyid = "";
  final storage = new FlutterSecureStorage();
  Location location = new Location();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          location.location.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewLocation(
                              isEdit: true,
                              location: location,
                            ))).then((value) => getLocationData());
              },
              child: Icon(
                Icons.edit,
                size: 25,
                color: GlobalColors.mainColor,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Show CircularProgressIndicator while loading
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          location.location.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          location.phone1 ?? "",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40, left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () =>
                                launch("tel://" + location.phone1.toString()),
                            icon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                          ),
                          Icon(
                            Icons.message,
                            color: Colors.blue,
                          ),
                          Icon(
                            Icons.email,
                            color: Colors.orange,
                          ),
                          IconButton(
                            onPressed: () => MapUtils.openMap(
                                location.address1.toString() +
                                    location.address2.toString() +
                                    "" +
                                    location.address3.toString() +
                                    "" +
                                    location.address4.toString() +
                                    ""),
                            icon: Icon(
                              Icons.map,
                              color: Colors.pinkAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            //Address
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.address1 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.address2 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.address3 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.address4 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "PostCode",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.postCode ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            //Phone2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone 2",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.phone2 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            //Fax
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fax",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.fax1 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            //Fax2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fax2",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location.fax2 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            size: 20,
            color: Colors.white,
          ),
        ),
      );

  Future<void> getLocationData() async {
    String response = await BaseClient()
        .get('/Location/GetLocation?Locationid=' + locationid.toString());

    if (response != null) {
      Location _location = Location.fromJson(jsonDecode(response));

      setState(() {
        location = _location;
        _isLoading = false;
      });
    }
  }
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        child: child,
        color: color,
        padding: EdgeInsets.all(all),
      ),
    );

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String addr) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$addr';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
