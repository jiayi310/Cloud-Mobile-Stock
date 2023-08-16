import 'package:flutter/material.dart';
import 'package:mobilestock/models/Sales.dart';

import '../../../models/Sales.dart';

class ListingSalesDetails extends StatefulWidget {
  ListingSalesDetails({Key? key, required this.sales}) : super(key: key);
  Sales sales;

  @override
  State<ListingSalesDetails> createState() => _ListingSalesDetails(
        sales: sales,
      );
}

class _ListingSalesDetails extends State<ListingSalesDetails> {
  _ListingSalesDetails({Key? key, required this.sales});
  Sales sales;

  List<Map> _books = [
    {
      '#': 1,
      'ItemCode': 'Flutter Basics',
      'Desc':
          'David John David John David John David John David John David John David John David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '1200.00'
    },
    {
      '#': 2,
      'ItemCode': 'Git and GitHub',
      'Desc': 'Merlin Nick',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
    {
      '#': 3,
      'ItemCode': 'Flutter Basics',
      'Desc': 'David John',
      'UOM': 'UNIT',
      'Qty': '1',
      'Total': '100.00'
    },
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
      DataColumn(label: Text('ItemCode')),
      DataColumn(
          label: Text(
        'Desc',
      )),
      DataColumn(
          label: Expanded(
        child: Text(
          'UOM',
          textAlign: TextAlign.center,
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Text(
          'Qty',
          textAlign: TextAlign.center,
        ),
      )),
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
              DataCell(Text(book['ItemCode'])),
              DataCell(ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 4),
                  child: Text(
                    book['Desc'],
                    overflow: TextOverflow.ellipsis,
                  ))),
              DataCell(Center(child: Text(book['UOM']))),
              DataCell(Center(child: Text(book['Qty']))),
              DataCell(Align(
                  alignment: Alignment.centerRight,
                  child: Text(book['Total']))),
            ]))
        .toList();
  }
}
