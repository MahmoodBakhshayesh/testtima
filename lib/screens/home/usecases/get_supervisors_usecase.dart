import 'package:flutter/material.dart';
import '../../../core/classes/supervisor_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class GetSupervisorsUseCase extends UseCase<GetSupervisorsResponse,GetSupervisorsRequest> {
  GetSupervisorsUseCase();

  @override
  Future<Result<GetSupervisorsResponse>> call({required GetSupervisorsRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.getSupervisors(request);
  }

}

class GetSupervisorsRequest extends RequestInterface {
  GetSupervisorsRequest();

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetSupervisors",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}



class GetSupervisorsResponse extends ResponseInterface {
  final List<Supervisor> supervisors;

  GetSupervisorsResponse({required super.status, required super.message, required this.supervisors})
      : super(body:{"allUserRole": supervisors.map((e)=>e.toJson()).toList()});

  factory GetSupervisorsResponse.fromResponse(ResponseInterface res) => GetSupervisorsResponse(
        status: res.status,
        message: res.message,
        supervisors: List<Supervisor>.from(res.body["allUserRole"].map((x) => Supervisor.fromJson(x))),
      );
}
