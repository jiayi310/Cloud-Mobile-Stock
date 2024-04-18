import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';

import '../../../models/Customer.dart';
import '../Customer/customer.home.dart';

class CusCollection extends StatefulWidget {
  CusCollection({Key? key}) : super(key: key);

  @override
  State<CusCollection> createState() => _CusCollection();
}

class _CusCollection extends State<CusCollection> {
  Customer? customer;

  @override
  Widget build(BuildContext context) {
    final collectProvider = CollectionProvider.of(context);
    if (collectProvider != null &&
        collectProvider.collection.customerID != null &&
        customer == null) {
      customer = new Customer();
      customer!.customerID = collectProvider.collection.customerID!;
      customer!.customerCode = collectProvider.collection.customerCode!;
      customer!.name = collectProvider.collection.customerName!;
      customer!.salesAgent = new SalesAgent(
          salesAgent: collectProvider.collection.salesAgent.toString());
    }

    return InkWell(
      onTap: () {
        _navigateToCustomerScreen(context);
      },
      child: Column(
        children: [
          if (customer != null)
            Builder(builder: (context) {
              if (customer != null) {
                collectProvider!.collection.customerID = customer!.customerID;
                collectProvider!.collection.customerCode =
                    customer!.customerCode.toString();
                collectProvider!.collection.customerName =
                    customer!.name.toString();
                collectProvider!.collection.salesAgent =
                    customer!.salesAgent.salesAgent.toString();
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
                        customer!.customerCode.toString() +
                            " " +
                            customer!.name.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          (customer!.address1 != null
                                  ? customer!.address1.toString() + " "
                                  : "") +
                              (customer!.address2 != null
                                  ? customer!.address2.toString() + " "
                                  : "") +
                              (customer!.address3 != null
                                  ? customer!.address3.toString() + " "
                                  : "") +
                              (customer!.address4 != null
                                  ? customer!.address4.toString() + " "
                                  : ""),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        (customer!.phone1 != null
                            ? customer!.phone1.toString() + " "
                            : ""),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            customer!.salesAgent.salesAgent.toString(),
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Icon(
                            CupertinoIcons.right_chevron,
                            color: GlobalColors.mainColor,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Container(); // Return an empty container or some loading indicator
              }
            }),
          if (customer == null)
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
                        'Select a Customer',
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

  Future<void> _navigateToCustomerScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomerHomeScreen(
                  FromSource: "Collection",
                )));

    setState(() {
      customer = result;
    });
  }
}
