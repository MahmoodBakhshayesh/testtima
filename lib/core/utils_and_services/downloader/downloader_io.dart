import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DownloaderUtil {
  static Future<String?> downloadSaveAndOpen(
      String url, {
        String? fileName,
        String subDir = 'downloads',
        void Function(int received, int total)? onProgress,
        Map<String, String>? headers,
      }) async {
    final name = fileName ?? _inferFileName(url);
    final dir = await _getDir(subDir);
    final path = '${dir.path}${Platform.pathSeparator}$name';

    final dio = Dio(BaseOptions(headers: headers));

    await dio.download(
      url,
      path,
      onReceiveProgress: (r, t) => onProgress?.call(r, t),
    );

    await OpenFilex.open(path);
    return path;
  }

  static Future<Directory> _getDir(String subDir) async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}${Platform.pathSeparator}$subDir');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static String _inferFileName(String url) {
    final uri = Uri.tryParse(url);
    return uri?.pathSegments.isNotEmpty == true
        ? uri!.pathSegments.last
        : 'file';
  }
}
