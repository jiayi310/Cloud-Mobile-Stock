import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../../api/base.client.dart';
import '../../../models/Stock.dart';
import '../../../size.config.dart';
import '../SalesProvider.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.stockid}) : super(key: key);

  final int stockid;
  StockDetail stock = new StockDetail();

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Map<String, String>> uom = [];
  TextEditingController _controller = TextEditingController();
  int quantity = 1;
  String selectedUOM = "";

  @override
  void initState() {
    super.initState();
    getData();
    _controller.text = quantity.toString();
    selectedUOM = widget.stock.baseUOM.toString();
  }

  @override
  Widget build(BuildContext context) {
    String remark = "";

    List<bool> selectedUOMList = List.generate(
        uom.length, (index) => uom[index]["uom"] == widget.stock.baseUOM);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.stock.stockCode.toString() +
              " " +
              widget.stock.description.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FutureBuilder<Uint8List>(
                          future: widget.stock.image != null
                              ? decodeImage(widget.stock.image!)
                              : null,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // Display the image using Image.memory
                              if (snapshot.data != null &&
                                  snapshot.data!.length > 0) {
                                return Image.memory(
                                  snapshot.data!,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                // Handle the case when snapshot.data is null or empty
                                return Image.asset(
                                  "assets/images/no-image.png",
                                  width: 100,
                                );
                              }
                            } else if (snapshot.hasError) {
                              // Handle errors during the Future execution
                              return Placeholder(); // Replace with an appropriate widget for error handling
                            } else {
                              // Display a loading indicator or placeholder while the Future is running
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 1.5),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(defaultBorderRadius * 3),
                            topRight: Radius.circular(defaultBorderRadius * 3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (widget.stock.description.toString() !=
                                    "null")
                                  Expanded(
                                    child: Text(
                                      widget.stock.description.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                const SizedBox(width: defaultPadding),
                                Text(widget.stock.baseUOM.toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20)),
                              ],
                            ),
                            if (widget.stock.desc2.toString() != "null")
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: Text(
                                  widget.stock.desc2.toString(),
                                ),
                              ),
                            if (widget.stock != null &&
                                widget.stock.stockGroup != null &&
                                widget.stock.stockGroup!.description != null)
                              Text(
                                "Group: " +
                                    widget.stock.stockGroup!.description!
                                        .toString(),
                              ),
                            if (widget.stock != null &&
                                widget.stock.stockType != null &&
                                widget.stock.stockType!.description != null)
                              Text(
                                "Type: " +
                                    widget.stock.stockType!.description!
                                        .toString(),
                              ),
                            if (widget.stock != null &&
                                widget.stock.stockCategory != null &&
                                widget.stock.stockCategory!.description != null)
                              Text(
                                "Category: " +
                                    widget.stock.stockCategory!.description!
                                        .toString(),
                              ),
                            const SizedBox(height: defaultPadding / 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
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
            Text(
              "RM " + widget.stock.baseUOMPrice1.toString(),
              style: TextStyle(
                  color: GlobalColors.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            InkWell(
              onTap: () {
                selectedUOM = widget.stock.baseUOM.toString();
                quantity = 1;
                updateTotalPrice();
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 50),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 223, 221, 221),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        widget.stock.description.toString(),
                                        style: TextStyle(
                                          color: GlobalColors.mainColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Text(
                                            "UOM:",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          for (int i = 0; i < uom.length; i++)
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  // Toggle the current one to true and others to false
                                                  for (int j = 0;
                                                      j <
                                                          selectedUOMList
                                                              .length;
                                                      j++) {
                                                    selectedUOMList[j] =
                                                        (j == i);

                                                    selectedUOM = uom[i]["uom"]
                                                        .toString();
                                                  }

                                                  updateTotalPrice();
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: selectedUOMList[i]
                                                      ? Colors.blue
                                                      : Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  uom[i]["uom"].toString(),
                                                  style: TextStyle(
                                                    color: selectedUOMList[i]
                                                        ? Colors.grey.shade50
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Qty:",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 50),
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
                                                    color: Colors.indigo,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (quantity > 1)
                                                        quantity--;
                                                      _controller.text =
                                                          quantity.toString();
                                                    });
                                                    updateTotalPrice();
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                                    textAlign: TextAlign.center,
                                                    controller: _controller,
                                                    style: TextStyle(
                                                        color: GlobalColors
                                                            .mainColor,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.indigo,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      quantity++;
                                                      _controller.text =
                                                          quantity.toString();
                                                    });
                                                    updateTotalPrice();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      GestureDetector(
                                        onTap: () async {
                                          String enteredRemark =
                                              await _showRemarkDialog(context);
                                          if (enteredRemark != null) {
                                            setState(() {
                                              remark = enteredRemark;
                                            });
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Remark:",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Icon(Icons.chevron_right)
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            remark,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 80),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total:",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "RM" +
                                                widget.stock.baseUOMPrice1
                                                    .toString(),
                                            style: TextStyle(
                                                color: GlobalColors.mainColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 40),
                                      InkWell(
                                        onTap: () async {
                                          final salesProvider =
                                              SalesProvider.of(context);
                                          if (salesProvider != null) {
                                            Uint8List? decodedImage =
                                                await decodeImage(
                                                    widget.stock.image);
                                            salesProvider.sales.addItem(
                                              stockID: widget.stock.stockID
                                                  .toString(),
                                              stockCode: widget.stock.stockCode
                                                  .toString(),
                                              description: widget
                                                  .stock.description
                                                  .toString(),
                                              uom: selectedUOM,
                                              quantity: quantity,
                                              discount: 0,
                                              taxrate: 0,
                                              total: 0,
                                              taxAmt: 0,
                                              taxableAmount: 0,
                                              price:
                                                  widget.stock.baseUOMPrice1!,
                                              image: decodedImage,
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Item added to cart')),
                                            );
                                            // Close the modal
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 100),
                                          decoration: BoxDecoration(
                                              color: GlobalColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Text(
                                            "Add to Cart",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> decodeImage(base64String) async {
    try {
      return base64Decode(base64String);
    } catch (e) {
      print('Error decoding Base64 image: $e');
      rethrow;
    }
  }

  Future<void> getData() async {
    if (widget.stockid != null) {
      final response = await BaseClient()
          .get('/Stock/GetStock?stockId=' + widget.stockid.toString());

      StockDetail _productlist = StockDetail.fromJson(jsonDecode(response));

      setState(() {
        widget.stock = _productlist;

        for (var item in _productlist.stockUOMDtoList!) {
          if (item.uom != null && item.price != null) {
            uom.add({"uom": item.uom!, "price": item.price!.toString()});
          }
        }
      });
    }
  }

  void updateTotalPrice() {
    double pricePerUnit = getPriceBasedOnUOM(selectedUOM);
    double totalPrice = quantity * pricePerUnit;

    setState(() {
      widget.stock.baseUOMPrice1 = totalPrice;
    });
  }

  double getPriceBasedOnUOM(String uom_) {
    for (var priceInfo in uom) {
      if (priceInfo["uom"] == uom_) {
        return double.parse(priceInfo["price"]!);
      }
    }
    return 0.0;
  }
}

Future<Uint8List?> decodeImage(String? base64String) async {
  try {
    if (base64String != null) {
      return base64Decode(base64String);
    } else {
      return null; // or return an appropriate default image
    }
  } catch (e) {
    print('Error decoding Base64 image: $e');
    return null;
  }
}

Future<String> _showRemarkDialog(BuildContext context) async {
  String enteredRemark = "";
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enter Remark"),
        content: TextField(
          onChanged: (value) {
            enteredRemark = value;
          },
          decoration: InputDecoration(
            hintText: "Type your remark here",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(null); // Close the dialog without saving
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(enteredRemark); // Save and close the dialog
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
  return enteredRemark;
}
