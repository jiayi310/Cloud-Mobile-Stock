import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/models/Picking.dart';
import 'package:mobilestock/view/WMS/Picking/picking.pickStock.itemEdit.dart';
import 'package:mobilestock/view/WMS/Picking/picking.pickStock.details.dart';
import '../../../utils/global.colors.dart';

class ItemStockTake extends StatefulWidget {
  ItemStockTake(
      {Key? key, required this.picking, required this.refreshMainPage})
      : super(key: key);

  final Picking picking;
  final Function refreshMainPage;

  List<PickingDetails> pickedItemsWithStorage = [];

  @override
  State<ItemStockTake> createState() => _ItemStockTakeState();
}

class _ItemStockTakeState extends State<ItemStockTake> {
  Map<int, bool> _openedItems = {};

  void _toggleSlidable(int index) {
    setState(() {
      _openedItems[index] = !(_openedItems[index] ?? false);
    });
  }

  void _handleDelete(PickingDetails detail) {
    setState(() {
      widget.picking.pickingDetails
          ?.remove(detail); // Remove the item from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.picking.pickingItems?.length ?? 0,
      itemBuilder: (BuildContext context, int i) {
        final item = widget.picking.pickingItems![i];
        final itemCode = item.stockCode;
        final batchNo = item.batchNo ?? '';
        final itemDescription = item.description ?? '';
        final uom = item.uom;
        final quantity = item.qty;

        final pickedQuantity = widget.picking.pickingDetails
                ?.where((detail) => detail.stockID == item.stockID)
                .fold(0.0, (sum, detail) => sum + (detail.qty ?? 0.0)) ??
            0.0;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$itemCode',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'x ${item.qty?.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.mainColor),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                '$itemDescription',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$batchNo',
                  ),
                  Text(
                    '$uom',
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Picked Quantity: ${pickedQuantity.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPickingItems(
                              pickingItem: item,
                              refreshMainPage: widget.refreshMainPage,
                            ),
                          ),
                        );

                        if (result != null) {
                          final resultData = result as Map<String, dynamic>;

                          final stockBatchID = resultData['stockBatchID'];
                          final batchNo = resultData['batchNo'];
                          final batchExpiryDate = resultData['batchExpiryDate'];
                          final locationID = resultData['locationID'];
                          final location = resultData['location'];
                          final storageID = resultData['storageID'];
                          final storageCode = resultData['storageCode'];
                          final pickedQuantity =
                              (resultData['pickedQuantity'] as num).toDouble();

                          setState(() {
                            if (widget.picking.pickingDetails == null) {
                              widget.picking.pickingDetails = [];
                            }

                            widget.picking.pickingDetails!.add(PickingDetails(
                              stockID: item.stockID,
                              stockBatchID: stockBatchID,
                              batchNo: batchNo,
                              stockCode: item.stockCode,
                              description: item.description,
                              uom: item.uom,
                              qty: pickedQuantity,
                              locationID: locationID,
                              location: location,
                              storageID: storageID,
                              storageCode: storageCode,
                            ));

                            widget.refreshMainPage();
                          });
                        }
                      },
                      child: Text('Pick Stock'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize:
                            Size(double.infinity, 40), // Set minimum size
                      ),
                    ),
                  ),
                  SizedBox(width: 5), // Add a small space between the buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPickedDetailPage(
                              picking: widget.picking,
                              itemCode: item.stockCode ?? 'Unknown',
                              onDelete: _handleDelete,
                            ),
                          ),
                        );
                      },
                      child: Text('View Details'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        minimumSize:
                            Size(double.infinity, 40), // Set minimum size
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
