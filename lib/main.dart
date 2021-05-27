import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        url: "www.hao123.com",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.url})
      : super(key: key);
  final String title;
  final String url;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Align(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 25),
                      child: QrImage(
                        data: url,
                        size: 200,
                        padding: EdgeInsets.all(0),
                      ),
                    ),
                  heightFactor: 1,
                ),
                Positioned(
                  child: MaterialButton(child: Text("复制"), onPressed: () {},),
                  right: 16,
                  bottom: 0,
                )
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                TextField(
                  onChanged: (String text) {
                    setState(() {
                      url = text;
                    });
                  },
                  textAlign: TextAlign.center,
                  autofocus: true,
                ),
                Positioned(child: Icon(Icons.delete),
                  right: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
