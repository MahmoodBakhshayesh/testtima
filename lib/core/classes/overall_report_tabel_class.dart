class OverallReportTable {
  final TableStyle tableStyle;
  final List<List<String>> data;

  OverallReportTable({required this.tableStyle, required this.data});

  OverallReportTable copyWith({TableStyle? tableStyle, List<List<String>>? data}) => OverallReportTable(tableStyle: tableStyle ?? this.tableStyle, data: data ?? this.data);

  factory OverallReportTable.fromJson(Map<String, dynamic> json) =>
      OverallReportTable(tableStyle: TableStyle.fromJson(json["tableStyle"]), data: List<List<String>>.from(json["data"].map((x) => List<String>.from(x.map((x) => x)))));

  Map<String, dynamic> toJson() => {"tableStyle": tableStyle.toJson(), "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x))))};
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

  TableColumn copyWith({String? text, String? fontColor, int? width}) => TableColumn(text: text ?? this.text, fontColor: fontColor ?? this.fontColor, width: width ?? this.width, alignment: alignment,fontColorValue: fontColorValue);

  factory TableColumn.fromJson(Map<String, dynamic> json) => TableColumn(text: json["text"], fontColor: json["fontColor"], fontColorValue:json["fontColorValue"]?? json["fontColor"], width: json["width"], alignment: json["alignment"]==null?TableAlignment.center():TableAlignment.fromJson(json["alignment"]));

  Map<String, dynamic> toJson() => {"text": text, "fontColor": fontColor,"fontColorValue": fontColorValue, "width": width,"alignment":alignment.toJson()};
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
