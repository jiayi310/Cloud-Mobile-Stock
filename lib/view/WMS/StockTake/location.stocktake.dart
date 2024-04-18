import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';
import 'package:mobilestock/view/Quotation/QuotationProvider.dart';

import '../../../models/Location.dart';

class LocStockTake extends StatefulWidget {
  const LocStockTake({Key? key}) : super(key: key);

  @override
  State<LocStockTake> createState() => _LocStockTake();
}

class _LocStockTake extends State<LocStockTake> {
  Location? location;
  @override
  Widget build(BuildContext context) {
    // final quotationProvider = QuotationProvider.of(context);
    // if (quotationProvider != null &&
    //     quotationProvider.quotation.locationID != null &&
    //     location == null) {
    //   location = new location();
    //   location!.locationID = quotationProvider.quotation.locationID!;
    //   location!.locationCode = quotationProvider.quotation.locationCode!;
    //   location!.name = quotationProvider.quotation.locationName!;
    //   location?.address1 = quotationProvider?.quotation?.address1;
    //   location?.address2 = quotationProvider?.quotation?.address2;
    //   location?.address3 = quotationProvider?.quotation?.address3;
    //   location?.address4 = quotationProvider?.quotation?.address4;
    //   location?.phone1 = quotationProvider?.quotation?.phone!;
    //   location?.email = quotationProvider?.quotation?.email!;
    //   location!.salesAgent = new SalesAgent(
    //       salesAgent: quotationProvider.quotation.salesAgent.toString());
    // }
    return InkWell(
      onTap: () {
        _navigateTolocationScreen(context);
      },
      child: Column(
        children: [
          if (location != null)
            Builder(builder: (context) {
              // quotationProvider!.quotation.locationID = location!.locationID;
              // quotationProvider!.quotation.locationCode =
              //     location!.locationCode.toString();

              return Container(
                height: 110,
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
    // final result = await Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => locationHomeScreen()));

    setState(() {
      //location = result;
    });
  }
}
