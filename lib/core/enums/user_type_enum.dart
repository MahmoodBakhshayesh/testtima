import 'package:get/get.dart';

enum UserType {
  supervisor,
  agent,
  share;

  @override
  toString(){
    return name.capitalizeFirst!;
  }
}