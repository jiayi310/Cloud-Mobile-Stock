import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobilestock/view/Sales/product.card.dart';
import 'package:mobilestock/view/Sales/section.title.dart';

import '../../models/Stock.dart';
import '../../size.config.dart';
import 'SalesDetails/details.screen.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: SectionTitle(
            title: "Featured",
            pressSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              demo_product.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  stockcode: demo_product[index].desc2.toString(),
                  title: demo_product[index].desc2.toString(),
                  uom: demo_product[index].desc2.toString(),
                  image: Base64Decoder()
                      .convert(demo_product[index].desc2.toString()),
                  price: demo_product[index].baseUOMPrice1 ?? 0.00,
                  bgColor: Color(0xfff),
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                              stockid: demo_product[index].stockID!),
                        ));
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
