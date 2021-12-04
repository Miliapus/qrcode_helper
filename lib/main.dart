import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'copy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Helper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'QR Code Helper',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  String url = "";

  @override
  Widget build(BuildContext context) {
    final imageKey = GlobalKey<State<QrImage>>();
    RenderRepaintBoundary targetRenderRepaintBoundary() =>
        imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final deleteIcon = IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              controller.clear();
            });
          },
        ),
        copyIcon = IconButton(
          icon: Icon(Icons.copy),
          onPressed: () async {
            copy(targetRenderRepaintBoundary());
          },
        ),
        icons = Row(
          children: [
            Offstage(
              offstage: !Platform.isWindows,
              child: copyIcon,
            ),
            deleteIcon
          ],
        ),
        inputField = TextField(
          onChanged: (String text) {
            setState(() {});
          },
          controller: controller,
          textAlign: TextAlign.center,
          autofocus: true,
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              child: Container(
                child: RepaintBoundary(
                  key: imageKey,
                  child: QrImage(
                    backgroundColor: Colors.white,
                    data: controller.text,
                    size: 200,
                    padding: EdgeInsets.all(0),
                  ),
                ),
              ),
              heightFactor: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: inputField,
                  flex: 3,
                ),
                // inputField,
                Expanded(
                  child: icons,
                  flex: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
