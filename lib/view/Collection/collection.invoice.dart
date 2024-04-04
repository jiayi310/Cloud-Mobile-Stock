import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';
import '../../models/Collection.dart';
import 'CollectionProvider.dart';

class InvoiceCollection extends StatefulWidget {
  InvoiceCollection(
      {Key? key, required this.collectionItems, required this.refreshMainPage})
      : super(key: key);
  List<CollectMappings> collectionItems;
  final Function refreshMainPage;

  @override
  State<InvoiceCollection> createState() => _InvoiceCollectionState();
}

class _InvoiceCollectionState extends State<InvoiceCollection> {
  _InvoiceCollectionState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.collectionItems.length,
          itemBuilder: (BuildContext context, int i) {
            final item = widget.collectionItems[i].salesDocID;
            return Slidable(
              key: Key(item.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final collectionProvider =
                              CollectionProvider.of(context);
                          if (collectionProvider != null) {
                            collectionProvider.collection.removeItem(item!);
                            widget.refreshMainPage();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Icon(
                        Icons.delete,
                      ))
                ],
              ),
              child: Container(
                height: 110,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.collectionItems[i].salesDocNo.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              "Remarks",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "RM " +
                                widget.collectionItems[i].paymentAmt.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
