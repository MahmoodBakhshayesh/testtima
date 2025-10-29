import 'package:abds/core/utils_and_services/cupps_util.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/barcode_reader/barcode_reader_controller.dart';
import 'package:abds/screens/cupps/cupps_state.dart';
import 'package:artemis_acps/artemis_acps.dart';
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

  Future<(String?, String?)> loadAirlineAirport() async {
    String? airport = await sharedPref.getVariable(key: "acpsAirport");
    String? airline = await sharedPref.getVariable(key: "acpsAirline");
    return (airport,airline);
  }

  void initAcps(String airport,String airline) {
    ArtemisAcps acps = ArtemisAcps(baseUrl: "https://printlayerapi.abomis.com", airport: airport, airline: airline);
    acps.controller.setDataListener((data){
      if(data.deviceType.toUpperCase() == "OC"){
        CuppsUtils.ocDataHandlerText(data.data);
      }else if(data.deviceType.toUpperCase() == "BC"){
        getIt<BarcodeReaderController>().onBarcodeRead(data.data,shouldPop: false);
      }
    });
    ref.read(acpsProvider.notifier).update((s)=>acps);
    sharedPref.setVariable(key: "acpsAirport", value: airport);
    sharedPref.setVariable(key: "acpsAirline", value: airline);
  }

}
