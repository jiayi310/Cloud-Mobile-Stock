import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/view/Sales/CheckOut/checkout.item.dart';
import 'package:mobilestock/view/Sales/CheckOut/checkout.price.dart';
import 'package:mobilestock/view/Sales/CheckOut/customer.checkout.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:open_file/open_file.dart';

import '../../../api/base.client.dart';
import '../../../models/Sales.dart';
import '../../../models/Stock.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../SalesProvider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<SfSignaturePadState> _signaturePadState = GlobalKey();

  List<SalesItem> salesItems = [];
  String docNo = "";
  String companyid = "";
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    myfuture = getDocNo();
  }

  late final Future<String> myfuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access context and salesProvider here
    final salesProvider = SalesProvider.of(context);
    salesItems = salesProvider?.sales.items ?? [];
  }

  @override
  Widget build(BuildContext context) {
    Sales? sales = SalesProvider.of(context)?.sales;

    if (sales == null) {
      // Handle the case where Sales is not available
      return Text('Sales data not available');
    }

    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(
            left: defaultPadding, right: defaultPadding, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Total (" + salesItems.length.toString() + "): ",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Text(
                  "RM " + '${sales.calculateTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                MaterialPageRoute(builder: (context) => CheckOutPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     showModalBottomSheet(
            //         backgroundColor: Colors.transparent,
            //         context: context,
            //         builder: (context) {
            //           return AddToCartModal();
            //         });
            //   },
            //   style: ElevatedButton.styleFrom(primary: GlobalColors.mainColor),
            //   child: const Text("Add to Cart"),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            //Header
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: GlobalColors.mainColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      docNo,
                      style: TextStyle(
                        fontSize: GlobalSize.headerSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        dialogPopUp("Signature");
                      },
                      child: Icon(CupertinoIcons.pen),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  CusCheckOut(),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      for (int i = 0; i < salesItems.length; i++)
                        Container(
                          height: 110,
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              if (salesItems[i].image!.length > 0)
                                Container(
                                  height: 70,
                                  width: 70,
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 224, 224, 244),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.memory(
                                      salesItems[i].image ?? Uint8List(0)),
                                ),
                              if (salesItems[i].image!.length <= 0)
                                Container(
                                  height: 70,
                                  width: 70,
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/images/no-image.png",
                                    width: 100,
                                  ),
                                ),
                              Expanded(
                                child: Container(
                                  width: 200,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        salesItems[i].stockCode.toString(),
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        salesItems[i].description.toString(),
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        salesItems[i].uom.toString(),
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "RM " +
                                          (salesItems[i].unitprice! *
                                                  salesItems[i].quantity)
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: GlobalColors.mainColor,
                                      ),
                                    ),
                                    // AddCartButtonCart(
                                    //   quantity: 2,
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PriceCheckOut(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void dialogPopUp(String s) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStateForDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              scrollable: true,
              title: Text(
                s,
                textAlign: TextAlign.center,
              ),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                children: [
                  SfSignaturePad(
                    key: _signaturePadState,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            _signaturePadState.currentState!.clear();
                          },
                          child: Text(
                            "CLEAR",
                            style: TextStyle(color: GlobalColors.mainColor),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalColors.mainColor),
                          onPressed: () async {
                            Navigator.of(context, rootNavigator: true).pop();
                            ui.Image image = await _signaturePadState
                                .currentState!
                                .toImage(pixelRatio: 2.0);

                            final byteData = await image.toByteData(
                                format: ui.ImageByteFormat.png);
                            final Uint8List imageBytes = byteData!.buffer
                                .asUint8List(byteData.offsetInBytes,
                                    byteData.lengthInBytes);

                            // if(kIsWeb){
                            //   AnchorElement(href: 'data.application/octet-stream;charset=utf-16le;base64,${base64.encode(imageBytes)}')
                            //       ..setAttribute('download', 'Signature.png')
                            //       ..click();
                            // }else {
                            final String path =
                                (await getApplicationSupportDirectory()).path;
                            final String fileName = '$path/Signature.png';
                            final File file = File(fileName);
                            await file.writeAsBytes(imageBytes, flush: true);
                            OpenFile.open(fileName);

                            //}
                          },
                          child: Text("OK"))
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<String> getDocNo() async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      if (companyid != null) {
        String response = await BaseClient()
            .get('/Sales/GetNewSalesDoc?companyid=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }

      return docNo;
    } catch (error) {
      print('Error fetching data: $error');
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }
}
