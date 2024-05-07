import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/models/Quotation.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';
import 'package:mobilestock/view/Collection/HistoryListing/collection.view.dart';
import 'package:mobilestock/view/Quotation/QuotationProvider.dart';
import 'package:mobilestock/view/Sales/SalesProvider.dart';
import 'package:mobilestock/view/WMS/Receiving/ReceivingProvider.dart';
import 'package:mobilestock/view/WMS/StockTake/StockTakeProvider.dart';
import 'package:mobilestock/view/splash.view.dart';

import 'models/Receiving.dart';
import 'models/Sales.dart';
import 'models/StockTake.dart';

void main() {
  runApp(
    SalesProvider(
      sales: Sales(),
      child: CollectionProvider(
        // Provide your Collection data initialization here
        collection: Collection(paymentTotal: 0.00),
        child: QuotationProvider(
          quotation: Quotation(),
          child: ReceivingProvider(
            receiving: Receiving(),
            child: StockTakeProvider(
              stockTake: StockTake(),
              child: MyApp(),
            ),
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
