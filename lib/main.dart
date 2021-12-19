import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
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
  final TextEditingController _controller = TextEditingController();
  final imageKey = GlobalKey<State<QrImage>>();

  RenderRepaintBoundary get body =>
      imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  void _share() async {
    final path = (await getTemporaryDirectory()).path,
        file = File('$path/shareImage.png'),
        data = await body.toData(format: ImageByteFormat.png);
    await file.writeAsBytes(data, flush: true);
    Share.shareFiles([file.path]);
  }

  @override
  Widget build(BuildContext context) {
    final clearIcon = IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _controller.clear();
            });
          },
        ),
        copyIcon = IconButton(
          icon: Icon(Icons.copy),
          onPressed: () async {
            copy(body);
          },
        ),
        shareIcon = IconButton(
          icon: Icon(Icons.share),
          onPressed: _share,
        ),
        copyAndClearIcons = Row(
          children: [
            Offstage(
              offstage: !Platform.isWindows,
              child: copyIcon,
            ),
            clearIcon
          ],
        ),
        inputField = TextField(
          onChanged: (String text) {
            setState(() {

            });
          },
          controller: _controller,
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
            RepaintBoundary(
              key: imageKey,
              child: QrImage(
                backgroundColor: Colors.white,
                data: _controller.text,
                size: 200,
                padding: EdgeInsets.all(0),
              ),
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
                  child: copyAndClearIcons,
                  flex: 1,
                ),
              ],
            ),
            //小屏幕放不下两个按钮，所以放在下面
            Offstage(
              offstage: !(Platform.isAndroid || Platform.isIOS),
              child: shareIcon,
            ),
          ],
        ),
      ),
    );
  }
}
