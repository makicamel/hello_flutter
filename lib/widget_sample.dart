import 'package:flutter/material.dart';

class WidgetSample extends StatefulWidget {
  final String title = 'Widget Samples';
  @override
  State<StatefulWidget> createState() => WidgetSampleState();
}

class WidgetSampleState extends State<WidgetSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
      // body: Builder(builder: (BuildContext context) {
      //   return ListView(
      //     scrollDirection: Axis.vertical,
      //     children: <Widget>[
      //       _EmailPasswordForm(),
      //       _GoogleSignInSection(),
      //       _PhoneSignInSection(Scaffold.of(context)),
      //       _OtherProvidersSignInSection(),
      //     ],
      //   );
      // }),
    );
  }
}
