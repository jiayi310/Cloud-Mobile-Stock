import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../models/Collection.dart';
import 'collection.listing.dart';

class CollectionCard extends StatelessWidget {
  CollectionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < demo_collection.length; i++)
          InkWell(
            onLongPress: () {
              Get.defaultDialog(
                  cancelTextColor: GlobalColors.mainColor,
                  confirmTextColor: Colors.white,
                  buttonColor: GlobalColors.mainColor,
                  titlePadding: EdgeInsets.only(top: 20),
                  title: "Warning",
                  content: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Are you sure want to delete " +
                                demo_collection[i].DocNo,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  textConfirm: "Confirm",
                  textCancel: "Cancel");
            },
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CollectionListingScreen(
                      collection: demo_collection[i],
                    ),
                  ));
            },
            child: Container(
              height: 130,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: GlobalColors.mainColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            demo_collection[i].DocNo,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          demo_collection[i].DocDate,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            demo_collection[i].DebtorCode,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Approved",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            demo_collection[i].DebtorName,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            demo_collection[i].Agent,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "RM" + demo_collection[i].Total.toString(),
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
