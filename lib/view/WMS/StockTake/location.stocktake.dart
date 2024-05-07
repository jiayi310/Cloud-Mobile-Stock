import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';
import 'package:mobilestock/view/Quotation/QuotationProvider.dart';

import '../../../models/Location.dart';
import '../../General/Location/location.home.dart';
import 'StockTakeProvider.dart';

class LocStockTake extends StatefulWidget {
  const LocStockTake({Key? key}) : super(key: key);

  @override
  State<LocStockTake> createState() => _LocStockTake();
}

class _LocStockTake extends State<LocStockTake> {
  Location? location;
  @override
  Widget build(BuildContext context) {
    final stockTakeProvider = StockTakeProvider.of(context);
    if (stockTakeProvider != null &&
        stockTakeProvider.stockTake.locationID != null &&
        location == null) {
      location = new Location();
      location!.locationID = stockTakeProvider.stockTake.locationID!;
      location!.location = stockTakeProvider.stockTake.location!;
    }
    return InkWell(
      onTap: () {
        _navigateTolocationScreen(context);
      },
      child: Column(
        children: [
          if (location != null)
            Builder(builder: (context) {
              stockTakeProvider!.stockTake.locationID = location!.locationID;
              stockTakeProvider!.stockTake.location =
                  location!.location.toString();

              return Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location!.location.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
          if (location == null)
            Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose a location',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        color: Colors.red,
                      )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _navigateTolocationScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationHomeScreen(
                  FromSource: "StockTake",
                )));

    setState(() {
      location = result;
    });
  }
}
