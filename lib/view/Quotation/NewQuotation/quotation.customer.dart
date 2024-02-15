import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../../models/Customer.dart';
import '../../Customer/customer.home.dart';

class CusQuotation extends StatefulWidget {
  const CusQuotation({Key? key}) : super(key: key);

  @override
  State<CusQuotation> createState() => _CusQuotation();
}

class _CusQuotation extends State<CusQuotation> {
  Customer? customer;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToCustomerScreen(context);
      },
      child: Column(
        children: [
          if (customer != null)
            Container(
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
            ),
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
