import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../../models/Customer.dart';
import '../../Customer/customer.home.dart';
import '../SalesProvider.dart';

class CusCheckOut extends StatefulWidget {
  const CusCheckOut({Key? key}) : super(key: key);

  @override
  State<CusCheckOut> createState() => _CusCheckOutState();
}

class _CusCheckOutState extends State<CusCheckOut> {
  Customer? customer;

  @override
  Widget build(BuildContext context) {
    final salesProvider = SalesProvider.of(context);
    if (salesProvider != null &&
        salesProvider.sales.customerID != null &&
        customer == null) {
      customer = new Customer();
      customer!.customerID = salesProvider.sales.customerID!;
      customer!.customerCode = salesProvider.sales.customerCode!;
      customer!.name = salesProvider.sales.customerName!;
      customer!.address1 = salesProvider.sales.address1!;
      customer!.address2 = salesProvider.sales.address2!;
      customer!.address3 = salesProvider.sales.address3!;
      customer!.address4 = salesProvider.sales.address4!;
      customer!.phone1 = salesProvider.sales.phone!;
      customer!.email = salesProvider.sales.email!;
      customer!.salesAgent =
          new SalesAgent(salesAgent: salesProvider.sales.salesAgent.toString());
    }
    return InkWell(
      onTap: () {
        _navigateToCustomerScreen(context);
      },
      child: Column(
        children: [
          if (customer != null)
            Builder(builder: (context) {
              salesProvider!.sales.customerCode =
                  customer!.customerCode.toString();
              salesProvider.sales.customerID = customer!.customerID!;
              salesProvider!.sales.customerName = customer!.name ?? null;
              salesProvider!.sales.address1 = customer!.address1 ?? null;
              salesProvider!.sales.address2 = customer!.address2 ?? null;
              salesProvider!.sales.address3 = customer!.address3 ?? null;
              salesProvider!.sales.address4 = customer!.address4 ?? null;
              salesProvider!.sales.salesAgent =
                  customer!.salesAgent.salesAgent.toString();
              salesProvider!.sales.phone = customer!.phone1.toString();
              salesProvider!.sales.email = customer!.email.toString();
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
                            " " +
                            (customer!.address2 != null
                                ? customer!.address2.toString() + " "
                                : "") +
                            " " +
                            (customer!.address3 != null
                                ? customer!.address3.toString() + " "
                                : "") +
                            " " +
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
                  FromSource: "Quotation",
                )));

    setState(() {
      customer = result;
    });
  }
}
