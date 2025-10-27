class OverallReportTable {
  final TableStyle tableStyle;

  // final List<List<String>> data;
  final List<TableSection> sections;

  OverallReportTable({required this.tableStyle, required this.sections});

  OverallReportTable copyWith({TableStyle? tableStyle, List<TableSection>? sections}) => OverallReportTable(tableStyle: tableStyle ?? this.tableStyle, sections: sections ?? this.sections);

  factory OverallReportTable.fromJson(Map<String, dynamic> json) => OverallReportTable(tableStyle: TableStyle.fromJson(json["tableStyle"]), sections: List<TableSection>.from(json["data"].map((x) => TableSection.fromJson(x))));

  Map<String, dynamic> toJson() => {"tableStyle": tableStyle.toJson(), "data": List<dynamic>.from(sections.map((x) => x.toJson()))};
}

class TableStyle {
  final Header header;
  final TableRow row;

  TableStyle({required this.header, required this.row});

  TableStyle copyWith({Header? header, TableRow? row}) => TableStyle(header: header ?? this.header, row: row ?? this.row);

  factory TableStyle.fromJson(Map<String, dynamic> json) => TableStyle(header: Header.fromJson(json["header"]), row: TableRow.fromJson(json["row"]));

  Map<String, dynamic> toJson() => {"header": header.toJson(), "row": row.toJson()};
}

class Header {
  final String color;
  final int fontSize;
  final List<TableColumn> column;

  Header({required this.color, required this.fontSize, required this.column});

  Header copyWith({String? color, int? fontSize, List<TableColumn>? column}) => Header(color: color ?? this.color, fontSize: fontSize ?? this.fontSize, column: column ?? this.column);

  factory Header.fromJson(Map<String, dynamic> json) => Header(color: json["color"], fontSize: json["fontSize"], column: List<TableColumn>.from(json["column"].map((x) => TableColumn.fromJson(x))));

  Map<String, dynamic> toJson() => {"color": color, "fontSize": fontSize, "column": List<dynamic>.from(column.map((x) => x.toJson()))};
}

class TableColumn {
  final String text;
  final String fontColor;
  final String fontColorValue;
  final int width;
  final TableAlignment alignment;

  TableColumn({required this.text, required this.fontColor, required this.width, required this.alignment, required this.fontColorValue});

  TableColumn copyWith({String? text, String? fontColor, int? width}) =>
      TableColumn(text: text ?? this.text, fontColor: fontColor ?? this.fontColor, width: width ?? this.width, alignment: alignment, fontColorValue: fontColorValue);

  factory TableColumn.fromJson(Map<String, dynamic> json) => TableColumn(
    text: json["text"],
    fontColor: json["fontColor"],
    fontColorValue: json["fontColorValue"] ?? json["fontColor"],
    width: json["width"],
    alignment: json["alignment"] == null ? TableAlignment.center() : TableAlignment.fromJson(json["alignment"]),
  );

  Map<String, dynamic> toJson() => {"text": text, "fontColor": fontColor, "fontColorValue": fontColorValue, "width": width, "alignment": alignment.toJson()};
}

class TableAlignment {
  final int x;
  final int y;

  TableAlignment({required this.x, required this.y});

  TableAlignment copyWith({int? x, int? y}) => TableAlignment(x: x ?? this.x, y: y ?? this.y);

  factory TableAlignment.fromJson(Map<String, dynamic> json) => TableAlignment(x: json["x"], y: json["y"]);

  factory TableAlignment.center() => TableAlignment(x: -1, y: 0);

  Map<String, dynamic> toJson() => {"x": x, "y": y};
}

class TableRow {
  final int fontSize;
  final Even odd;
  final Even even;

  TableRow({required this.fontSize, required this.odd, required this.even});

  TableRow copyWith({int? fontSize, Even? odd, Even? even}) => TableRow(fontSize: fontSize ?? this.fontSize, odd: odd ?? this.odd, even: even ?? this.even);

  factory TableRow.fromJson(Map<String, dynamic> json) => TableRow(fontSize: json["fontSize"], odd: Even.fromJson(json["odd"]), even: Even.fromJson(json["even"]));

  Map<String, dynamic> toJson() => {"fontSize": fontSize, "odd": odd.toJson(), "even": even.toJson()};
}

class Even {
  final String color;
  final String fontColor;

  Even({required this.color, required this.fontColor});

  Even copyWith({String? color, String? fontColor}) => Even(color: color ?? this.color, fontColor: fontColor ?? this.fontColor);

  factory Even.fromJson(Map<String, dynamic> json) => Even(color: json["color"], fontColor: json["fontColor"]);

  Map<String, dynamic> toJson() => {"color": color, "fontColor": fontColor};
}

class TableSection {
  final TableSectionHeader header;
  final List<Datum> data;

  TableSection({required this.header, required this.data});

  TableSection copyWith({TableSectionHeader? header, List<Datum>? data}) => TableSection(header: header ?? this.header, data: data ?? this.data);

  factory TableSection.fromJson(Map<String, dynamic> json) => TableSection(header: TableSectionHeader.fromJson(json["header"]), data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() => {"header": header.toJson(), "data": List<dynamic>.from(data.map((x) => x.toJson()))};
}

class Datum {
  final DatumFln from;
  final DatumFln fln;
  final DatumCheck check;
  final DatumCheck okTb;
  final DatumCheck noGo;
  final DatumCheck unknown;
  final DatumCheck force;

  Datum({required this.from, required this.fln, required this.check, required this.okTb, required this.noGo, required this.unknown, required this.force});

  Datum copyWith({DatumFln? from, DatumFln? fln, DatumCheck? check, DatumCheck? okTb, DatumCheck? noGo, DatumCheck? unknown, DatumCheck? force}) =>
      Datum(from: from ?? this.from, fln: fln ?? this.fln, check: check ?? this.check, okTb: okTb ?? this.okTb, noGo: noGo ?? this.noGo, unknown: unknown ?? this.unknown, force: force ?? this.force);

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    from: DatumFln.fromJson(json["from"]),
    fln: DatumFln.fromJson(json["FLN"]),
    check: DatumCheck.fromJson(json["Check"]),
    okTb: DatumCheck.fromJson(json["OK_TB"]),
    noGo: DatumCheck.fromJson(json["NO_GO"]),
    unknown: DatumCheck.fromJson(json["Unknown"]),
    force: DatumCheck.fromJson(json["Force"]),
  );

  Map<String, dynamic> toJson() => {"from": from.toJson(), "FLN": fln.toJson(), "Check": check.toJson(), "OK_TB": okTb.toJson(), "NO_GO": noGo.toJson(), "Unknown": unknown.toJson(), "Force": force.toJson()};
}

class DatumCheck {
  final int value;
  final String q;

  DatumCheck({required this.value, required this.q});

  DatumCheck copyWith({int? value, String? q}) => DatumCheck(value: value ?? this.value, q: q ?? this.q);

  factory DatumCheck.fromJson(Map<String, dynamic> json) => DatumCheck(value: json["value"], q: json["q"]);

  Map<String, dynamic> toJson() => {"value": value, "q": q};
}

class DatumFln {
  final String value;
  final String q;

  DatumFln({required this.value, required this.q});

  DatumFln copyWith({String? value, String? q}) => DatumFln(value: value ?? this.value, q: q ?? this.q);

  factory DatumFln.fromJson(Map<String, dynamic> json) => DatumFln(value: json["value"], q: json["q"]);

  Map<String, dynamic> toJson() => {"value": value, "q": q};
}

class TableSectionHeader {
  final HeaderFln from;
  final HeaderFln fln;
  final HeaderCheck check;
  final HeaderCheck okTb;
  final HeaderCheck noGo;
  final HeaderCheck unknown;
  final HeaderCheck force;

  TableSectionHeader({required this.from, required this.fln, required this.check, required this.okTb, required this.noGo, required this.unknown, required this.force});

  TableSectionHeader copyWith({HeaderFln? from, HeaderFln? fln, HeaderCheck? check, HeaderCheck? okTb, HeaderCheck? noGo, HeaderCheck? unknown, HeaderCheck? force}) =>
      TableSectionHeader(from: from ?? this.from, fln: fln ?? this.fln, check: check ?? this.check, okTb: okTb ?? this.okTb, noGo: noGo ?? this.noGo, unknown: unknown ?? this.unknown, force: force ?? this.force);

  factory TableSectionHeader.fromJson(Map<String, dynamic> json) => TableSectionHeader(
    from: HeaderFln.fromJson(json["from"]),
    fln: HeaderFln.fromJson(json["FLN"]),
    check: HeaderCheck.fromJson(json["Check"]),
    okTb: HeaderCheck.fromJson(json["OK_TB"]),
    noGo: HeaderCheck.fromJson(json["NO_GO"]),
    unknown: HeaderCheck.fromJson(json["Unknown"]),
    force: HeaderCheck.fromJson(json["Force"]),
  );

  Map<String, dynamic> toJson() => {"from": from.toJson(), "FLN": fln.toJson(), "Check": check.toJson(), "OK_TB": okTb.toJson(), "NO_GO": noGo.toJson(), "Unknown": unknown.toJson(), "Force": force.toJson()};
}

class HeaderCheck {
  final int value;

  HeaderCheck({required this.value});

  HeaderCheck copyWith({int? value}) => HeaderCheck(value: value ?? this.value);

  factory HeaderCheck.fromJson(Map<String, dynamic> json) => HeaderCheck(value: json["value"]);

  Map<String, dynamic> toJson() => {"value": value};
}

class HeaderFln {
  final String value;

  HeaderFln({required this.value});

  HeaderFln copyWith({String? value}) => HeaderFln(value: value ?? this.value);

  factory HeaderFln.fromJson(Map<String, dynamic> json) => HeaderFln(value: json["value"]);

  Map<String, dynamic> toJson() => {"value": value};
}
