// Export the right implementation automatically.
export 'adaptive_image_path_stub.dart'
if (dart.library.io) 'adaptive_image_path_io.dart'
if (dart.library.html) 'adaptive_image_path_web.dart';
