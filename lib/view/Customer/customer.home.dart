import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Customer/customer.add.dart';

import '../../api/base.client.dart';
import '../../models/Customer.dart';
import '../../utils/loading.dart';
import 'customer.details.dart';

class CustomerHomeScreen extends StatefulWidget {
  CustomerHomeScreen({Key? key, this.FromSource}) : super(key: key);
  String? FromSource;

  @override
  State<CustomerHomeScreen> createState() =>
      _CustomerHomeScreen(FromSource: FromSource);
}

class _CustomerHomeScreen extends State<CustomerHomeScreen> {
  String? FromSource;
  _CustomerHomeScreen({Key? key, this.FromSource});
  bool shouldShowFB = true;
  bool _visible = false;
  List<Customer> customerlist = [];
  List<Customer> customerlist_search = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Customer> userFromJson(String str) =>
      List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

  late final Future myfuture;

  @override
  void initState() {
    super.initState();
    myfuture = getCustomerData();
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
                    builder: (context) => NewCustomer(
                          isEdit: false,
                          customer: Customer(),
                        ))).then((value) {
              if (value == "Done") getCustomerData();
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
          "Customer",
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
                          itemCount: customerlist.length,
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
                                        deleteCustomer(customerlist[i]);
                                      },
                                      content: Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                "Are you sure want to delete " +
                                                    customerlist[i]
                                                        .customerCode
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
                                if (FromSource != null) {
                                  Navigator.pop(context, customerlist[i]);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CustomerDetails(
                                            customerid:
                                                customerlist[i].customerID!),
                                      )).then((value) => getCustomerData());
                                }
                              },
                              child: Container(
                                height: 120,
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
                                                        customerlist[i].name ??
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
                                                                .circular(30)),
                                                    child: Text(
                                                      customerlist[i]
                                                          .customerCode
                                                          .toString(),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        customerlist[i].name2 ??
                                                            "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  if (customerlist[i].email !=
                                                      null)
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.pinkAccent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Text(
                                                        customerlist[i]
                                                            .email
                                                            .toString(),
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        customerlist[i]
                                                            .salesAgent
                                                            .salesAgent
                                                            .toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (customerlist[i].phone1 !=
                                                      null)
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Text(
                                                        customerlist[i]
                                                            .phone1
                                                            .toString(),
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

  Future<List<Customer>> getCustomerData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Customer/GetCustomerList?companyid=' + companyid);
      List<Customer> _customerlist = userFromJson(response);

      setState(() {
        customerlist_search = _customerlist;
        customerlist = _customerlist;
      });
    }
    return customerlist;
  }

  void searchQuery(String query) {
    final suggestions = customerlist_search.where((cus) {
      final cusCode = cus.customerCode?.toString().toLowerCase() ?? "";
      final cusName = cus.name!.toString().toLowerCase() ?? "";
      final salesAgent = cus.salesAgent.toString().toLowerCase();
      final cusName2 = cus.name2.toString().toLowerCase();
      final email = cus.email.toString().toLowerCase();
      final phone = cus.phone1.toString().toLowerCase();
      final input = query.toLowerCase();

      return cusName.contains(input) ||
          cusCode.contains(input) ||
          cusName2.contains(input) ||
          email.contains(input) ||
          phone.contains(input) ||
          salesAgent.contains(input);
    }).toList();

    setState(() {
      customerlist = suggestions;
    });
  }

  Future<void> deleteCustomer(Customer customer) async {
    String response = await BaseClient().post(
        '/Customer/DeleteCustomer',
        jsonEncode({
          "customerID": customer.customerID.toString(),
          "customerCode": customer.customerCode.toString(),
          "name": customer.name.toString(),
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
      await getCustomerData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer deleted successfully')),
      );
    } else {}
  }
}
