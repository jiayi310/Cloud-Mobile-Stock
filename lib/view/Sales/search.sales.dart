import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const SearchWidget({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
  }) : super(key: key);

  Future<void> scanBarcode(BuildContext context) async {
    try {
      var result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        searchController.text = result.rawContent;
        onSearchChanged(result.rawContent);
      }
    } catch (e) {
      // Handle exception or error during barcode scanning
      print("Error during barcode scanning: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: GlobalColors.mainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            width: MediaQuery.of(context).size.width - 118,
            child: TextFormField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
              ),
            ),
          ),
          InkWell(
            onTap: () => scanBarcode(context),
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}
