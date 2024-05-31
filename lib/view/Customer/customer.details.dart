import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilestock/models/Customer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

import '../../api/base.client.dart';
import '../../utils/global.colors.dart';
import 'customer.add.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({Key? key, required this.customerid}) : super(key: key);
  final int customerid;

  @override
  State<CustomerDetails> createState() =>
      _CustomerDetailsState(customerid: customerid);
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final int customerid;
  _CustomerDetailsState({Key? key, required this.customerid});
  String companyid = "";
  final storage = new FlutterSecureStorage();
  Customer customer = new Customer();
  bool _isLoading = true;
  String address = "";

  @override
  void initState() {
    // TODO: implement initState
    getCustomerData();
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
          customer.customerCode.toString(),
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
                        builder: (context) => NewCustomer(
                              isEdit: true,
                              customer: customer,
                            ))).then((value) => getCustomerData());
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
                    // Center(
                    //   child: Stack(children: [
                    //     ClipOval(
                    //       child: Image.asset(
                    //         "assets/images/agiliti_logo_blue.png",
                    //         width: 120,
                    //         height: 120,
                    //       ),
                    //     ),
                    //     Positioned(
                    //         bottom: 0, right: 0, child: buildEditIcon(Colors.blue)),
                    //   ]),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          customer.name.toString(),
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
                          customer.phone1 ?? "",
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
                                launch("tel://" + customer.phone1.toString()),
                            icon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                          ),
                          Icon(
                            Icons.message,
                            color: Colors.blue,
                          ),
                          IconButton(
                            onPressed: () {
                              if (customer.email != null &&
                                  customer.email!.isNotEmpty) {
                                _sendEmail(customer.email!);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Email is empty",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.email,
                              color: Colors.orange,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (address.isNotEmpty) {
                                MapUtils.openMap(address);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Address is empty",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
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
                            //Desc2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Desc 2",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  customer.name2 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                                  customer.address1 ?? "",
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
                                  customer.address2 ?? "",
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
                                  customer.address3 ?? "",
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
                                  customer.address4 ?? "",
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
                                  customer.deliverAddr4 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            //Deliver Address
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Deliver Address",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  customer.deliverAddr1 ?? "",
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
                                  customer.deliverAddr2 ?? "",
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
                                  customer.deliverAddr3 ?? "",
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
                                  customer.deliverAddr4 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Deliver PostCode",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  customer.deliverPostCode ?? "",
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
                                  customer.phone2 ?? "",
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
                                  customer.fax1 ?? "",
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
                                  customer.fax2 ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            //Agent
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Agent",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  customer.salesAgent.salesAgent ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  customer.email ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Attention",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  customer.attention ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       color: Colors.grey.withOpacity(0.1),
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(20.0),
                    //     child: Column(
                    //       children: [
                    //         //Type & Area
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "Type",
                    //                   style: TextStyle(
                    //                       fontSize: 13, fontWeight: FontWeight.bold),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "Wholesales",
                    //                   style: TextStyle(fontSize: 13),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(width: 10),
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "Area",
                    //                   style: TextStyle(
                    //                       fontSize: 13, fontWeight: FontWeight.bold),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "Puchong",
                    //                   style: TextStyle(fontSize: 13),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 10),
                    //         //Terms & tax Code
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "Terms",
                    //                   style: TextStyle(
                    //                       fontSize: 13, fontWeight: FontWeight.bold),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "C.O.D",
                    //                   style: TextStyle(fontSize: 13),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(width: 10),
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "Currency",
                    //                   style: TextStyle(
                    //                       fontSize: 13, fontWeight: FontWeight.bold),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               flex: 1,
                    //               child: Container(
                    //                 child: Text(
                    //                   "RM",
                    //                   style: TextStyle(fontSize: 13),
                    //                   overflow: TextOverflow.ellipsis,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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

  Future<void> getCustomerData() async {
    String response = await BaseClient()
        .get('/Customer/GetCustomer?customerid=' + customerid.toString());

    if (response != null) {
      Customer _customer = Customer.fromJson(jsonDecode(response));

      setState(() {
        customer = _customer;
        address = [
          customer.address1,
          customer.address2,
          customer.address3,
          customer.address4,
        ].where((part) => part != null && part!.isNotEmpty).join(', ');

        _isLoading = false;
      });
    }
  }
}

void _sendEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters(<String, String>{
      'subject': '',
      'body': '',
    }),
  );

  if (await canLaunch(emailUri.toString())) {
    await launch(emailUri.toString());
  } else {
    Fluttertoast.showToast(
      msg: "Could not send email",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
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
    String encodedAddress = Uri.encodeComponent(addr);
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
