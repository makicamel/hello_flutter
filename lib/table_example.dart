import 'package:flutter/material.dart';

class TableExample extends StatefulWidget {
  @override
  State<TableExample> createState() => _TableExampleState();
}

Map<String, String> informationLabel = {
  'nickname': '名前',
  'age': '年齢!',
  'residence': '住所',
};

class _TableExampleState extends State<TableExample> {
  Map<String, String> informationValue = {
    'nickname': '高橋二生',
    'ages': '35歳',
    'residence': '東京',
    'job': 'work',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: informationTable(informationValue, onPress: () {}),
      ),
    );
  }
}

class informationTable extends Table {
  informationTable(Map<String, String> list, {VoidCallback onPress = null})
      : super(
            border: TableBorder(bottom: BorderSide()),
            children: tableRows(list, onPress: onPress));

  static List tableRows(Map<String, String> list,
      {VoidCallback onPress = null}) {
    Map newList = {};
    informationLabel.forEach((key, value) {
      if (list.containsKey(key)) {
        newList[value] = list[key];
      } else {
        // throw AssertionError();
      }
    });

    List<TableRow> result = [];

    newList.forEach((key, value) {
      result.add(TableRow(
          children: [
        TableCell(child: AppText(key)),
        TableCell(child: AppText(value)),
        onPress == null ? null : TableCell(child: Icon(Icons.edit)),
      ].where((cell) => cell != null).toList()));
    });
    return result;
  }
}

class AppText extends Text {
  AppText(String value) : super(value, style: TextStyle(fontSize: 20));
}
