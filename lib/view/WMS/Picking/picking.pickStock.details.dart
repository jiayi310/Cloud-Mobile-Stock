import 'package:flutter/material.dart';
import 'package:mobilestock/models/Picking.dart';

import '../../../utils/global.colors.dart';

class ViewPickedDetailPage extends StatelessWidget {
  final Picking picking;
  final String itemCode;
  final Function(PickingDetails) onDelete;

  ViewPickedDetailPage(
      {required this.picking, required this.itemCode, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    // Filter pickingDetails based on the provided itemCode
    final filteredDetails = (picking.pickingDetails ?? [])
        .where((detail) => detail.stockCode == itemCode)
        .toList();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Picked Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: filteredDetails.map((detail) {
          return ListTile(
            title: Text('Location: ${detail.storageCode ?? 'N/A'}'),
            subtitle: Text(
                'Picked Quantity: ${detail.qty?.toStringAsFixed(2) ?? '0.00'}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                onDelete(detail);
                Navigator.pop(context);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
