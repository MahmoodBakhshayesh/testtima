import 'dart:html' as html;

class DownloaderUtil {
  static Future<String?> downloadSaveAndOpen(
      String url, {
        String? fileName,
        String subDir = 'downloads',
        void Function(int received, int total)? onProgress,
        Map<String, String>? headers,
      }) async {
    final anchor = html.AnchorElement(href: url)
      ..download = fileName ?? ''
      ..target = '_blank'
      ..style.display = 'none';

    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();

    // Browsers control file saving → no path
    return null;
  }
}
