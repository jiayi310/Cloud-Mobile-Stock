import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Sales/CheckOut/checkout.item.dart';
import 'package:mobilestock/view/Sales/CheckOut/checkout.price.dart';
import 'package:mobilestock/view/Sales/CheckOut/customer.checkout.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

import '../../../utils/global.colors.dart';
import 'checkout.bottom.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<SfSignaturePadState> _signaturePadState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CheckOutBottomBar(),
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
                      'IV-00001',
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
                  ItemCheckout(),
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
}
