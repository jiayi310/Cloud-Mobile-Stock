import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/models/Stock.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';

import '../../api/base.client.dart';

class CollectionInvoiceList extends StatefulWidget {
  CollectionInvoiceList({Key? key, required this.customerid}) : super(key: key);
  int customerid;

  @override
  State<CollectionInvoiceList> createState() => _CollectionInvoiceListState();
}

class _CollectionInvoiceListState extends State<CollectionInvoiceList> {
  List<Sales> sales = [];
  List<Sales> selectedSales = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Sales> salesFromJson(String str) =>
      List<Sales>.from(json.decode(str).map((x) => Sales.fromJson(x)));
  double totalSelected = 0.00;

  @override
  void initState() {
    // TODO: implement initState
    getCollectionList();
  }

  @override
  Widget build(BuildContext context) {
    final collectionProvider = CollectionProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Text("Collection List"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CollectionItem(
                          sales[index].docNo.toString(),
                          sales[index].docDate.toString(),
                          sales[index].finalTotal!.toDouble(),
                          sales[index].outstanding!.toDouble(),
                          sales[index].isSelected,
                          index);
                    }),
              ),
              selectedSales.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: ',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: GlobalColors.mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                totalSelected.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: GlobalColors.mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  print("CONFIRMED");
                                  Navigator.of(context).pop(collectionProvider!
                                      .collection.collectionDetails);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: GlobalColors
                                      .mainColor, // Change the color here
                                ),
                                child: Text("Confirm"),
                              )),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget CollectionItem(String docNo, String date, double total,
      double outstanding, bool isSelected, int index) {
    final collectionProvider = CollectionProvider.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: GlobalColors.mainColor,
        child: Icon(
          Icons.book_rounded,
          color: Colors.white,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            docNo,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(date.toString().substring(0, 10)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: ${total.toStringAsFixed(2)}'),
              Text(
                'Outstanding: ${outstanding.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: GlobalColors.mainColor,
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          sales[index].isSelected = !sales[index].isSelected;
          if (sales[index].isSelected) {
            selectedSales.add(sales[index]);
            totalSelected += sales[index].finalTotal!;

            if (collectionProvider != null) {
              collectionProvider.collection.addItem(
                  salesDocID: sales[index].docID,
                  paymentAmt: sales[index].outstanding,
                  sales: sales[index]);
            }
          } else {
            selectedSales
                .removeWhere((element) => element.docNo == sales[index].docNo);
            totalSelected -= sales[index].finalTotal!;

            if (collectionProvider != null) {
              collectionProvider.collection.removeItem(sales[index].docID!);
            }
          }
        });
      },
    );
  }

  void getCollectionList() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      var body = json.encode([2025]);

      try {
        final response = await BaseClient().post(
          '/Sales/GetSalesListAvailableForCollect?companyId=' +
              companyid +
              '&customerId=' +
              widget.customerid.toString() +
              '&collectForm=0',
          body,
        );

        // Check the status code of the response
        if (response != null) {
          List<Sales> _saleslist = salesFromJson(response);

          setState(() {
            sales = _saleslist;
          });
          print('API request successful');
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
    }
  }
}
