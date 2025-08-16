
enum UiPermissionGroup {
  user,
}



abstract class UiPermission {
  String getLabel();
}


class UserUiPermission extends UiPermission {
  final int flag;
  final String label;
  final UiPermissionGroup group;
  UserUiPermission(this.group,this.flag,this.label);

  factory UserUiPermission.add() => UserUiPermission(UiPermissionGroup.user,1,"Add");
  factory UserUiPermission.edit() => UserUiPermission(UiPermissionGroup.user,2,"Edit");
  factory UserUiPermission.activeDeactive() => UserUiPermission(UiPermissionGroup.user,4,"Active / De Active");
  factory UserUiPermission.delete() => UserUiPermission(UiPermissionGroup.user,8,"Delete");

  @override
  String getLabel() => label;
}




