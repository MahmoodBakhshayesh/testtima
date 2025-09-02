import 'package:abds/core/classes/mrz_agg_class.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/orc_mrz_log_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../mrz_reader_repository.dart';

class SendLogsUseCase extends UseCase<SendLogsResponse,SendLogsRequest> {
  SendLogsUseCase();

  @override
  Future<Result<SendLogsResponse>> call({required SendLogsRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    MrzReaderRepository repository = MrzReaderRepository();
    return repository.sendLogs(request);
  }

}

class SendLogsRequest extends RequestInterface {
  final List<OcrMrzLog> current;
  // final OcrMrzResult? improving;
  final OcrMrzConsensus? consensus;
  final String? base64;
  SendLogsRequest({required this.current, required this.consensus,required this.base64});

  @override
  Map<String, dynamic> toJson() =>{
    "logs":current.map((a)=>a.toJson()).toList(),
    "improving": consensus?.toResult().toJson(),
    "consensus":consensus?.toJson(includeHistograms: true),
    "base64":base64
  };

  Failure? validate(){
    return null;
  }
}


class SendLogsResponse extends ResponseInterface {
  final String msg;
  SendLogsResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {
          },
        );

    factory SendLogsResponse.fromResponse(ResponseInterface res) => SendLogsResponse(
        status: res.status,
        message: res.message,
        msg:res.message
      );

}

