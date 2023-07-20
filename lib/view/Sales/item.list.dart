import 'package:flutter/material.dart';
import 'package:mobilestock/view/Sales/product.card.dart';
import 'package:mobilestock/view/Sales/section.title.dart';

import '../../models/Product.dart';
import '../../size.config.dart';
import 'SalesDetails/details.screen.dart';

class ItemsGridWidget extends StatelessWidget {
  const ItemsGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: SectionTitle(
          title: "Popular",
          pressSeeAll: () {},
        ),
      ),
      GridView.builder(
          shrinkWrap: true,
          itemCount: demo_product.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).size.shortestSide < 600 ? 2 : 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 230),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ProductCard(
                title: demo_product[index].title,
                image: demo_product[index].image,
                price: demo_product[index].price,
                bgColor: demo_product[index].bgColor,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(product: demo_product[index]),
                      ));
                });
          })
    ]);

    // (index) => Padding(
    //   padding: const EdgeInsets.only(
    //       bottom: defaultPadding, right: defaultPadding),
    //   child: ProductCard(
    //     title: demo_product[index].title,
    //     image: demo_product[index].image,
    //     price: demo_product[index].price,
    //     bgColor: demo_product[index].bgColor,
    //     press: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) =>
    //                 DetailsScreen(product: demo_product[index]),
    //           ));
    //     },
    //   ),
    // ),
    //   ),
    // )
    // ],
  }
}
