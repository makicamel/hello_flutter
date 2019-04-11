import 'package:flutter/material.dart';

class TableExample extends StatefulWidget {
  @override
  State<TableExample> createState() => _TableExampleState();
}

class _TableExampleState extends State<TableExample> {
  Map<String, String> informationList = {
    '名前': '高橋一生',
    '年齢': '35歳',
    '職業': '俳優',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: informationTable(informationList),
      ),
    );
  }
}

class informationTable extends Table {
  informationTable(Map<String, String> list)
      : super(
            border: TableBorder(bottom: BorderSide()),
            children: tableRows(list));

  static List tableRows(Map<String, String> list) {
    List<TableRow> result = [];

    list.forEach((key, value) {
      result.add(TableRow(children: [
        TableCell(child: AppText(key)),
        TableCell(child: AppText(value)),
      ]));
    });
    return result;
  }
}

class AppText extends Text {
  AppText(String value) : super(value, style: TextStyle(fontSize: 20));
}
