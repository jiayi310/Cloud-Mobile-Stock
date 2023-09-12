import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../../models/Product.dart';
import '../../../size.config.dart';
import 'details.bottom.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          product.title.toString(),
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
                        child: Image.asset(
                          product.image.toString(),
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.cover,
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
                                Expanded(
                                  child: Text(
                                    product.title.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                const SizedBox(width: defaultPadding),
                                Text("UOM",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20)),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: Text(
                                "A Henley shirt is a collarless pullover shirt, by a round neckline and a placket about 3 to 5 inches (8 to 13 cm) long and usually having 2–5 buttons.",
                              ),
                            ),
                            Text(
                              "Description 2",
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
      bottomNavigationBar: ItemBottomBar(
        product: product,
      ),
    );
  }
}
