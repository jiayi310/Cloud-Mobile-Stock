import 'package:flutter/material.dart';
import 'package:mobilestock/models/Collection.dart';

class ListingDetails extends StatefulWidget {
  ListingDetails({Key? key, required this.collection}) : super(key: key);
  Collection collection;

  @override
  State<ListingDetails> createState() => _ListingDetails(
        collection: collection,
      );
}

class _ListingDetails extends State<ListingDetails> {
  _ListingDetails({required this.collection});
  Collection collection;

  List<Map> _books = [
    {'#': 1, 'InvoiceNo': 'IN-912823', 'Total': '1200.00'},
    {'#': 2, 'InvoiceNo': 'IN-912823', 'Total': '100.00'},
    {'#': 3, 'InvoiceNo': 'IN-912823', 'Total': '123.00'},
    {'#': 4, 'InvoiceNo': 'IN-912823', 'Total': '145.00'},
    {'#': 5, 'InvoiceNo': 'IN-912823', 'Total': '133.00'},
  ];

  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DataTable(
        horizontalMargin: 10,
        columnSpacing: 10,
        headingRowHeight: 30,
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor:
            MaterialStateProperty.resolveWith((states) => Colors.black),
        dataTextStyle: TextStyle(fontSize: 11, color: Colors.black),
        columns: _createColumns(),
        rows: _createRows(),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isSortAsc,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text('#'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              _books.sort((a, b) => b['#'].compareTo(a['#']));
            } else {
              _books.sort((a, b) => a['#'].compareTo(b['#']));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      DataColumn(label: Text('Invoice No')),
      DataColumn(
          label: Expanded(
              child: Text(
        'Total',
        textAlign: TextAlign.right,
      ))),
    ];
  }

  List<DataRow> _createRows() {
    return _books
        .map((book) => DataRow(cells: [
              DataCell(Text(book['#'].toString())),
              DataCell(Text(book['InvoiceNo'])),
              DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(book['Total']))),
            ]))
        .toList();
  }
}
