import 'package:flutter/material.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/view/Analysis/analysis.view.dart';
import 'package:mobilestock/view/ClockIn/clockin.view.dart';
import 'package:mobilestock/view/Collection/collection.view.dart';
import 'package:mobilestock/view/Customer/customer.home.dart';
import 'package:mobilestock/view/Quotation/quotation.view.dart';
import 'package:mobilestock/view/Sales/home.sales.dart';
import 'package:mobilestock/view/SalesWorkflow/sales.workflow.dart';
import 'package:mobilestock/view/Stock/stock.home.dart';

class Menu {
  String? title, img, color;
  WidgetBuilder? nav;

  Menu(this.title, this.img, this.color, this.nav);

  Menu.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    img = json["img"];
    color = json["color"];
    nav = json["nav"];
  }
}

final List<Menu> menu_list = [
  Menu("Workflows", "assets/images/salesflow.png", "FFFADD",
      (context) => SalesWorkFlowPage()),
  Menu("Customer", "assets/images/customer.png", "FFFFFF",
      (context) => CustomerHomeScreen()),
  Menu("Stock", "assets/images/inventory.png", "FFFFFF",
      (context) => StockHomeScreen()),
  // Menu("ClockIn", "assets/images/clock.png", "FFFFFF",
  //     (context) => ClockInHomeScreen()),
  Menu("Quotation", "assets/images/quotation.png", "FFFFFF",
      (context) => QuotationHomeScreen()),
  Menu(
      "Sales",
      "assets/images/sales.png",
      "FFFFFF",
      (context) => HomeSalesScreen(
            isEdit: false,
            sales: new Sales(),
          )),
  Menu("Collection", "assets/images/collection.png", "FFFFFF",
      (context) => CollectionHomeScreen()),
  Menu("Analysis", "assets/images/analysis.png", "FFFFFF",
      (context) => AnalysisScreen()),
];

final List<Menu> warehouse_menu_list = [
  Menu("Workflows", "assets/images/warehouse.png", "FFFADD",
      (context) => SalesWorkFlowPage()),
  Menu("Receiving", "assets/images/receiving.png", "FFFFFF",
      (context) => CustomerHomeScreen()),
  Menu("Putaway", "assets/images/putaway.png", "FFFFFF",
      (context) => StockHomeScreen()),
  Menu("Storage", "assets/images/storage.png", "FFFFFF",
      (context) => ClockInHomeScreen()),
  Menu("Picking", "assets/images/picking.png", "FFFFFF",
      (context) => QuotationHomeScreen()),
  Menu(
      "Shipping",
      "assets/images/shipping.png",
      "FFFFFF",
      (context) => HomeSalesScreen(
            isEdit: false,
            sales: new Sales(),
          )),
  Menu("Stock Take", "assets/images/stocktake.png", "FFFFFF",
      (context) => CollectionHomeScreen()),
  Menu("Transfer", "assets/images/transfer.png", "FFFFFF",
      (context) => AnalysisScreen()),
  Menu("Barcode", "assets/images/barcode.png", "FFFFFF",
      (context) => AnalysisScreen()),
];
