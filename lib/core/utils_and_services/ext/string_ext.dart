extension StringNullExt on String? {
  String? get pureValue => this==null? null: this!.isEmpty?null:this;
}