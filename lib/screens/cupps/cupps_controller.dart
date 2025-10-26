import 'package:abds/core/utils_and_services/cupps_util.dart';
import 'package:artemis_cupps/artemis_cupps.dart';
import 'package:logging/logging.dart';
import '../../core/interfaces/controller_int.dart';


class CuppsController extends ControllerInterface {

  Future<void> connectCupps(String ip, String port) async {
    if(ip.isEmpty && port.isEmpty) {
      ip = "192.168.43.103";
      port = "7535";
    }
    await CuppsUtils.initCupps(ip: ip, port: port);
  }

  Future<(String?, String?)> loadIpPort() {
    return CuppsUtils.loadIpPort();
  }

}
