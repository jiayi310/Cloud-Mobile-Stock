import 'package:flutter/material.dart';

class ItemStockTransfer extends StatefulWidget {
  const ItemStockTransfer({Key? key}) : super(key: key);

  @override
  State<ItemStockTransfer> createState() => _ItemStockTransferState();
}

class _ItemStockTransferState extends State<ItemStockTransfer> {
  String description = 'Description Absheyewd, sdnwdnwdwdwdwdwd';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)), // Adjust the radius as needed
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ST001',
                        style: TextStyle(
                          fontSize: 14, // Adjust font size as needed
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Change text color as needed
                        ),
                      ),
                      Text(
                        description.length > 35
                            ? description.substring(0, 30) + '...'
                            : description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black, // Change text color as needed
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'UOM',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black, // Change text color as needed
                        ),
                      ),
                      Text(
                        'BatchNo',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black, // Change text color as needed
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(
                                  10)), // Adjust the radius as needed
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Colors.black, // Change text color as needed
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Storage',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Colors.black, // Change text color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 24, // Set the desired width here
                        child: Icon(Icons.arrow_forward_ios_sharp),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(
                                  10)), // Adjust the radius as needed
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Colors.black, // Change text color as needed
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Storage',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Colors.black, // Change text color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Qty: 10",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
