import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilestock/view/Settings/settings.constant.dart';

import '../../../models/Sales.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../CheckOut/checkout.view.dart';
import '../SalesProvider.dart';

class CartList extends StatefulWidget {
  CartList({Key? key, required this.isEdit}) : super(key: key);
  bool isEdit;

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  bool deleteButton = false;
  List<SalesDetails> salesItems = [];
  double totalPrice = 0;
  int totalQuantity = 0;
  Set<int> selectedIndexes = {}; // Keep track of selected item indexes

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access context and salesProvider here
    final salesProvider = SalesProvider.of(context);
    salesItems = salesProvider?.sales.salesDetails ?? [];

    // Initialize selectedIndexes with all item indexes
    selectedIndexes = Set<int>.from(Iterable<int>.generate(salesItems.length));

    recalculateTotal();
  }

  void recalculateTotal() {
    totalQuantity = 0;
    totalPrice = 0;

    for (var i in selectedIndexes) {
      if (i >= 0 && i < salesItems.length) {
        totalQuantity++;
        totalPrice += (salesItems.elementAt(i).unitPrice ?? 0) *
            (salesItems.elementAt(i).qty ?? 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(
            left: defaultPadding, right: defaultPadding, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  activeColor: GlobalColors.mainColor,
                  value: selectedIndexes.length == salesItems.length,
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        // If the checkbox is checked, select all items
                        selectedIndexes = Set<int>.from(
                          Iterable<int>.generate(salesItems.length),
                        );
                      } else {
                        // If the checkbox is unchecked, clear the selection
                        selectedIndexes.clear();
                      }
                      recalculateTotal();
                    });
                  },
                ),
                Text(
                  "ALL",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "RM ${totalPrice!.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "$totalQuantity Selected",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    if (salesItems.length > 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutPage(
                                  isEdit: widget.isEdit,
                                )),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "No items to check out",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                        color: GlobalColors.mainColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Check Out",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                )
              ],
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     showModalBottomSheet(
            //         backgroundColor: Colors.transparent,
            //         context: context,
            //         builder: (context) {
            //           return AddToCartModal();
            //         });
            //   },
            //   style: ElevatedButton.styleFrom(primary: GlobalColors.mainColor),
            //   child: const Text("Add to Cart"),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            //Header
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: GlobalColors.mainColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: GlobalSize.headerSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Column(
                    children: <Widget>[
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: salesItems.length,
                        itemBuilder: (BuildContext context, int i) {
                          final item = salesItems[i].description;
                          return Slidable(
                              key: Key(item.toString()),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _confirmDelete(i);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      child: Icon(
                                        Icons.delete,
                                      ))
                                ],
                              ),
                              child: Container(
                                height: 110,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      activeColor: GlobalColors.mainColor,
                                      value: selectedIndexes.contains(i),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value!) {
                                            // If the checkbox is checked, add to selection
                                            selectedIndexes.add(i);
                                          } else {
                                            // If the checkbox is unchecked, remove from selection
                                            selectedIndexes.remove(i);
                                          }
                                          recalculateTotal();
                                        });
                                      },
                                    ),
                                    if (salesItems[i].image != null &&
                                        salesItems[i].image!.length > 0)
                                      Container(
                                        height: 70,
                                        width: 70,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 224, 224, 244),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.memory(
                                            salesItems[i].image ??
                                                Uint8List(0)),
                                      ),
                                    if (salesItems[i].image != null &&
                                        salesItems[i].image!.length <= 0)
                                      Container(
                                        height: 70,
                                        width: 70,
                                        margin: EdgeInsets.only(right: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                          "assets/images/no-image.png",
                                          width: 100,
                                        ),
                                      ),
                                    Expanded(
                                      child: Container(
                                        width: 200,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              salesItems[i]
                                                  .stockCode
                                                  .toString(),
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            Text(
                                              salesItems[i]
                                                  .description
                                                  .toString(),
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            Text(
                                              salesItems[i].uom.toString(),
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                              ),
                                            ),
                                            Text(
                                              "RM " +
                                                  salesItems[i]
                                                      .unitPrice!
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: GlobalColors.mainColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // AddCartButtonCart(
                                          //   salesItem: salesItems[i],
                                          // ),

                                          Container(
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: kprimaryColor,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      final salesProvider =
                                                          SalesProvider.of(
                                                              context);
                                                      if (salesItems[i].qty ==
                                                          1) {
                                                        // Prompt confirmation dialog before decrementing or deleting
                                                        _confirmDecrementOrDelete(
                                                            i);
                                                      } else {
                                                        if (salesProvider !=
                                                            null) {
                                                          salesProvider.sales
                                                              .updateItemQuantity(
                                                            salesItems[i]
                                                                .stockCode!,
                                                            (salesItems[i]
                                                                        .qty ??
                                                                    0.0) -
                                                                1.0,
                                                          );
                                                        }
                                                      }
                                                      recalculateTotal();
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  salesItems[i]
                                                      .qty!
                                                      .toStringAsFixed(0),
                                                  style: TextStyle(
                                                      color: GlobalColors
                                                          .mainColor),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: kprimaryColor,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      final salesProvider =
                                                          SalesProvider.of(
                                                              context);
                                                      if (salesProvider !=
                                                          null) {
                                                        salesProvider.sales
                                                            .updateItemQuantity(
                                                                salesItems[i]
                                                                    .stockCode!,
                                                                salesItems[i]
                                                                        .qty =
                                                                    (salesItems[i].qty ??
                                                                            0) +
                                                                        1);
                                                      }

                                                      recalculateTotal();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> _confirmDelete(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (index >= 0 && index < salesItems.length) {
                    salesItems.removeAt(index);

                    // Update the selectedIndexes after removing the item
                    selectedIndexes.remove(index);
                    Set<int> updatedIndexes = {};
                    for (var i in selectedIndexes) {
                      if (i > index) {
                        updatedIndexes.add(i - 1);
                      } else {
                        updatedIndexes.add(i);
                      }
                    }
                    selectedIndexes = updatedIndexes;

                    recalculateTotal();
                  }
                  Navigator.of(context).pop();
                });
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDecrementOrDelete(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Action"),
          content: Text("Do you want to remove this item from the cart?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  salesItems.removeAt(index);
                  Navigator.of(context).pop();
                });
              },
              child: Text("Remove"),
            ),
          ],
        );
      },
    );
  }
}
