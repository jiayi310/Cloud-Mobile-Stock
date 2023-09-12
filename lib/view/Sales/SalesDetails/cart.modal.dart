import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../../models/Product.dart';

class AddToCartModal extends StatefulWidget {
  final Product product;
  AddToCartModal({Key? key, required this.product}) : super(key: key);

  @override
  State<AddToCartModal> createState() => _AddToCartModalState(product: product);
}

class _AddToCartModalState extends State<AddToCartModal> {
  _AddToCartModalState({required this.product});

  List uom = ["PCS", "PC", "BOX"];
  final Product product;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
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
                          color: Color.fromARGB(255, 223, 221, 221),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(height: 20),
                    Text(
                      product.title.toString(),
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
                        SizedBox(
                          width: 30,
                        ),
                        for (int i = 0; i < uom.length; i++)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Color(0xFFF7F8FA),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(uom[i]),
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Color:",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        for (int i = 0; i < uom.length; i++)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Color(0xFFF7F8FA),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(uom[i]),
                          ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.indigo,
                                ),
                                onPressed: () {
                                  setState(() {
                                    quantity--;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 50,
                                child: TextField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  textAlign: TextAlign.center,
                                  controller: _controller,
                                  style: TextStyle(
                                      color: GlobalColors.mainColor,
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
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFF7F8FA),
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Icon(
                        //     CupertinoIcons.minus,
                        //     size: 25,
                        //     color: GlobalColors.mainColor,
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // Text(
                        //   "01",
                        //   style: TextStyle(
                        //       fontSize: 20, fontWeight: FontWeight.w400),
                        // ),
                        // SizedBox(height: 10),
                        // Container(
                        //   padding: EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFF7F8FA),
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Icon(
                        //     CupertinoIcons.add,
                        //     size: 25,
                        //     color: GlobalColors.mainColor,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "RM" + product.price.toString(),
                          style: TextStyle(
                              color: GlobalColors.mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return AddToCartModal(
                                product: product,
                              );
                            });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 100),
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
                )),
          ),
        ),
      ],
    );
  }

  TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Step 2 <- SEE HERE
    _controller.text = quantity.toString();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _controller.text = quantity.toString();
  }
}
