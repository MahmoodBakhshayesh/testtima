
import 'package:flutter/material.dart';

import '../core/classes/basic_class.dart';
import '../core/utils_and_services/time_picker/ui_permission.dart';
class CheckPermission extends StatelessWidget {
  final UiPermission permission;
  final List<UiPermission> otherPermission;
  final Widget child;
  final bool saveSpace;
  const CheckPermission({super.key, required this.permission, required this.child,this.saveSpace = true,this.otherPermission = const []});
  bool validatePermission() {
    final per = BasicClass.validatePermission(permission);
    return per;
  }
  bool validateOtherPermissions() {
    return otherPermission.any((a)=>BasicClass.validatePermission(a));
  }
  @override
  Widget build(BuildContext context) {
    if(saveSpace){
      return IndexedStack(
        index: validatePermission()?1:0,
        children: [
          SizedBox(),
          child
        ],
      );
    }
    if(validatePermission()){
      return child;
    }
    if(validateOtherPermissions()){
      return child;
    }
    return SizedBox();

  }
}
