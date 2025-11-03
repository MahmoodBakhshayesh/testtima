import 'package:flutter/foundation.dart';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/material.dart';

Widget buildImage({io.File? file, Uint8List? bytes, String? url}) {
  if (kIsWeb) {
    if (bytes != null) return Image.memory(bytes);
    if (url != null) return Image.network(url);
    return const Placeholder();
  } else {
    if (file != null) return Image.file(file);
    if (url != null) return Image.network(url);
    return const Placeholder();
  }
}
