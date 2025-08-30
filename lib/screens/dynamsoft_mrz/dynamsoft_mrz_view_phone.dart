import 'package:dynamsoft_mrz_scanner_bundle_flutter/dynamsoft_mrz_scanner_bundle_flutter.dart';
import 'package:flutter/material.dart';
import 'dynamsoft_mrz_controller.dart';
import 'dynamsoft_mrz_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class DynamsoftMrzViewPhone extends StatefulWidget {
  static DynamsoftMrzController myDynamsoftMrzController = getIt<DynamsoftMrzController>();

  const DynamsoftMrzViewPhone({super.key});

  @override
  State<DynamsoftMrzViewPhone> createState() => _DynamsoftMrzViewPhoneState();
}

class _DynamsoftMrzViewPhoneState extends State<DynamsoftMrzViewPhone> {
  @override
  void initState() {
    // initMrz();
    super.initState();
  }

  // initMrz() async {
  //   var config = MRZScannerConfig(license: '<YOUR_LICENSE_KEY>');
  //   MRZScanResult mrzScanResult = await MRZScanner.launch(config);
  //   if (mrzScanResult.status == EnumResultStatus.finished) {
  //     // handle the result
  //   }
  // }
  String _displayString = "";


  void _launchMrzScanner() async {
    var config = MRZScannerConfig(
      license: "DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9",
    );
    MRZScanResult mrzScanResult = await MRZScanner.launch(config);

    setState(() {
      if(mrzScanResult.status == EnumResultStatus.canceled) {
        _displayString = "Scan canceled";
      } else if(mrzScanResult.status == EnumResultStatus.exception) {
        _displayString = "ErrorCode: ${mrzScanResult.errorCode}\n\nErrorString: ${mrzScanResult.errorMessage}";
      } else { //EnumResultStatus.finished
        MRZData data = mrzScanResult.mrzData!;
        _displayString = "Name:\t${data.firstName} ${data.lastName}\n\n"
            "Sex: ${data.sex.substring(0,1).toUpperCase() + data.sex.substring(1)}\n\n"
            "Age: ${data.age}\n\n"
            "Document Type: ${data.documentType}\n\n"
            "Document Number: ${data.documentNumber}\n\n"
            "Issuing State: ${data.issuingState}\n\n"
            "Nationality: ${data.nationality}\n\n"
            "Date of Birth(YYYY-MM-DD): ${data.dateOfBirth}\n\n"
            "Date of Expiry(YYYY-MM-DD): ${data.dateOfExpire}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DynamsoftMrzAppBar(),
      body: Column(children: [

        Text(
          _displayString,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 20), // Add a spacing of 20
        TextButton(
          onPressed: _launchMrzScanner,
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          child: const Text("Scan an MRZ"),
        ),
      ]),
    );
  }
}

class DynamsoftMrzAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  static DynamsoftMrzController myDynamsoftMrzController = getIt<DynamsoftMrzController>();

  const DynamsoftMrzAppBar({super.key, this.actions = const []});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      BackButton(),
                      Text("Dynamsoft Reader", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      ...actions,
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
