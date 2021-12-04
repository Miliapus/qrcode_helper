import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

MethodChannel copyChannel = MethodChannel("com.xja.qrcode_helper/copy");

extension read on RenderRepaintBoundary {
  Future<Uint8List> toData(
      {ImageByteFormat format = ImageByteFormat.rawRgba}) async {
    final image = await this.toImage(),
        byteData = await image.toByteData(format: format),
        sendData = byteData!.buffer.asUint8List();
    return sendData;
  }
}

Future<void> copyImageData(Uint8List data) async {
  await copyChannel.invokeMethod("copyImageData", data);
}

Future<void> copy(RenderRepaintBoundary renderRepaintBoundary) async {
  final data = await renderRepaintBoundary.toData();
  copyImageData(data);
}
