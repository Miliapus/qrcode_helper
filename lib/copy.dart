import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

MethodChannel copyChannel = MethodChannel("com.xja.qrcode_helper/copy");

Future<void> copy(RenderRepaintBoundary renderRepaintBoundary) async {
  final image = await renderRepaintBoundary.toImage(),
      byteData = await image.toByteData(),
      sendData = Uint8List.view(byteData!.buffer);
  copyChannel.invokeMethod("copyImageData", sendData);
}
