import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/models/Picking.dart';
import 'package:mobilestock/view/WMS/Picking/picking.pickStock.itemEdit.dart';
import 'package:mobilestock/view/WMS/Picking/picking.pickStock.details.dart';
import '../../../utils/global.colors.dart';

class ItemPicking extends StatefulWidget {
  ItemPicking({Key? key, required this.picking, required this.refreshMainPage})
      : super(key: key);

  final Picking picking;
  final Function refreshMainPage;

  List<PickingDetails> pickedItemsWithStorage = [];

  @override
  State<ItemPicking> createState() => _ItemPickingState();
}

class _ItemPickingState extends State<ItemPicking> {
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
                    'x ${quantity?.toStringAsFixed(2)}',
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
            ],
          ),
        );
      },
    );
  }
}
