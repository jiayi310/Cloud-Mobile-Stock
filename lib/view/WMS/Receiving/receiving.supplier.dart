import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/Supplier.dart';
import '../Supplier/supplier.home.dart';
import 'ReceivingProvider.dart';

class SupReceiving extends StatefulWidget {
  const SupReceiving({Key? key}) : super(key: key);

  @override
  State<SupReceiving> createState() => _SupReceiving();
}

class _SupReceiving extends State<SupReceiving> {
  Supplier? supplier;
  @override
  Widget build(BuildContext context) {
    final receivingProvider = ReceivingProvider.of(context);
    if (receivingProvider != null &&
        receivingProvider.receiving.supplierID != null &&
        supplier == null) {
      supplier = new Supplier();
      supplier!.supplierID = receivingProvider.receiving.supplierID!;
      supplier!.supplierCode = receivingProvider.receiving.supplierCode!;
      supplier!.name = receivingProvider.receiving.supplierName!;
      supplier?.address1 = receivingProvider?.receiving?.address1;
      supplier?.address2 = receivingProvider?.receiving?.address2;
      supplier?.address3 = receivingProvider?.receiving?.address3;
      supplier?.address4 = receivingProvider?.receiving?.address4;
      supplier?.phone1 = receivingProvider?.receiving?.phone!;
      supplier?.email = receivingProvider?.receiving?.email!;
    }
    return InkWell(
      onTap: () {
        _navigateToSupplierScreen(context);
      },
      child: Column(
        children: [
          if (supplier != null)
            Builder(builder: (context) {
              receivingProvider!.receiving.supplierID = supplier!.supplierID;
              receivingProvider!.receiving.supplierCode =
                  supplier!.supplierCode.toString();
              receivingProvider!.receiving.supplierName =
                  supplier!.name.toString();
              receivingProvider!.receiving.address1 =
                  supplier!.address1.toString();
              receivingProvider!.receiving.address2 =
                  supplier!.address2.toString();
              receivingProvider!.receiving.address3 =
                  supplier!.address3.toString();
              receivingProvider!.receiving.address4 =
                  supplier!.address4.toString();
              receivingProvider!.receiving.phone = supplier!.phone1.toString();
              receivingProvider!.receiving.email = supplier!.email.toString();
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
                      supplier!.supplierCode.toString() +
                          " " +
                          supplier!.name.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        (supplier!.address1 != null
                                ? supplier!.address1.toString() + " "
                                : "") +
                            " " +
                            (supplier!.address2 != null
                                ? supplier!.address2.toString() + " "
                                : "") +
                            " " +
                            (supplier!.address3 != null
                                ? supplier!.address3.toString() + " "
                                : "") +
                            " " +
                            (supplier!.address4 != null
                                ? supplier!.address4.toString() + " "
                                : ""),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      (supplier!.phone1 != null
                          ? supplier!.phone1.toString() + " "
                          : ""),
                    ),
                  ],
                ),
              );
            }),
          if (supplier == null)
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
                        'Select a Supplier',
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

  Future<void> _navigateToSupplierScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SupplierHomeScreen(
                  FromSource: "receiving",
                )));

    setState(() {
      supplier = result;
    });
  }
}
