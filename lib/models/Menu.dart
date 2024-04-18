import 'package:flutter/material.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/view/Analysis/analysis.view.dart';
import 'package:mobilestock/view/ClockIn/clockin.view.dart';
import 'package:mobilestock/view/Collection/HistoryListing/collection.view.dart';
import 'package:mobilestock/view/Customer/customer.home.dart';
import 'package:mobilestock/view/General/Location/location.home.dart';
import 'package:mobilestock/view/Quotation/HistoryListing/quotation.view.dart';
import 'package:mobilestock/view/Sales/home.sales.dart';
import 'package:mobilestock/view/SalesWorkflow/sales.workflow.dart';
import 'package:mobilestock/view/Stock/stock.home.dart';
import 'package:mobilestock/view/WMS/Pack&Ship/HistoryListing/pack.view.dart';
import 'package:mobilestock/view/WMS/Receiving/HistoryListing/receiving.view.dart';
import 'package:mobilestock/view/WMS/StockTransfer/HistoryListing/stocktransfer.view.dart';

import '../view/WMS/Picking/HistoryListing/picking.view.dart';
import '../view/WMS/Putaway/HistoryListing/putaway.view.dart';
import '../view/WMS/StockTake/HistoryListing/stocktake.view.dart';
import '../view/WMS/Supplier/supplier.home.dart';

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
  Menu("Supplier", "assets/images/supplier.png", "FFFFFF",
      (context) => SupplierHomeScreen()),
  Menu("Receiving", "assets/images/receiving.png", "FFFFFF",
      (context) => ReceivingHomeScreen()),
  Menu("Putaway", "assets/images/putaway.png", "FFFFFF",
      (context) => PutAwayHomeScreen()),
  // Menu("Storage", "assets/images/storage.png", "FFFFFF",
  //     (context) => ClockInHomeScreen()),
  Menu("Picking", "assets/images/picking.png", "FFFFFF",
      (context) => PickingHomeScreen()),
  Menu("Pack & Ship", "assets/images/shipping.png", "FFFFFF",
      (context) => PackingHomeScreen()),
  Menu("Stock Take", "assets/images/stocktake.png", "FFFFFF",
      (context) => StockTakeHomeScreen()),
  Menu("Transfer", "assets/images/transfer.png", "FFFFFF",
      (context) => StockTransferHomeScreen()),
  // Menu("Barcode", "assets/images/barcode.png", "FFFFFF",
  //     (context) => AnalysisScreen()),
];

final List<Menu> general_list = [
  Menu("Location", "assets/images/location.png", "FFFADD",
      (context) => LocationHomeScreen()),
];
