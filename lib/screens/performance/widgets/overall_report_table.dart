import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/constants/ui.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/performance/performance_controller.dart';
import 'package:abds/widgets/MyExpansionTile.dart';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/classes/overall_report_tabel_class.dart';

/// ===== WIDGET: ListView-style, header fixed, body scrolls =====
class OverallReportListView extends StatefulWidget {
  final OverallReportTable? model;
  final DateTime? fromDate;
  final DateTime? toDate;
  final EdgeInsetsGeometry cellPadding;
  final List<ExpansibleController>? expansibleControllers;
  final bool enableHorizontalScroll; // if true, side-scroll when too many columns

  const OverallReportListView({super.key,
    required this.fromDate,
    required this.toDate,
    this.expansibleControllers,
    required this.model, this.cellPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10), this.enableHorizontalScroll = true});

  @override
  State<OverallReportListView> createState() => _OverallReportListViewState();
}

class _OverallReportListViewState extends State<OverallReportListView> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.model == null) return SizedBox();
    final header = widget.model!.tableStyle.header;
    final rowStyle = widget.model!.tableStyle.row;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Compute pixel widths from ratio weights.
        final contentWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 1200.0;
        final widthsPx = _computeWidths(contentWidth - 2, header.column);

        Widget content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: _RowStrip(
                fromDate: widget.toDate,
                toDate: widget.toDate,
                isHeader: true,
                texts: header.column.map((c) => c.text).toList(),
                queries: header.column.map((c) => '').toList(),
                widthsPx: widthsPx,
                bg: _hex(header.color),
                fgList: header.column.map((c) => _hex(c.fontColor)).toList(),
                ratio: header.column.map((c) => c.width).toList(),
                alignments: header.column.map((c) => c.alignment).toList(),
                fontSize: header.fontSize.toDouble(),
                fontWeight: FontWeight.w700,
                padding: widget.cellPadding,
              ),
            ),

            // Body (scrolls vertically; no explicit height needed)
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  padding: EdgeInsets.only(right: 5),
                  controller: scrollController,
                  itemCount: widget.model!.sections.length,
                  primary: false,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    final isEven = index % 2 == 0;
                    final stripe = isEven ? rowStyle.even : rowStyle.odd;
                    final section = widget.model!.sections[index];
                    final sectionRows = section.data;

                    // Per-cell text colors follow the stripe's fg
                    final fg = List<Color>.filled(header.column.length, _hex(stripe.fontColor));
                    final fgD = header.column.map((a) => _hex(a.fontColorValue)).toList();
                    final headerData = header.column.map((h)=>h.text).toList();
                    final sectionHeader =section.header;
                    final sectionHeaderValues = sectionHeader.values.map((a) => a["value"].toString()).toList();
                    final sectionHeaderQueries = sectionHeader.values.map((a) => a["q"].toString()).toList();
                    return MyExpansionTile(
                      initiallyExpanded: true,
                      // collapsedBackgroundColor: Colors.red,
                      // backgroundColor: Colors.red,
                      tilePadding: EdgeInsets.zero,
                      showFooter: false,
                      title: _RowStrip(
                        fromDate: widget.toDate,
                        toDate: widget.toDate,
                        texts: sectionHeaderValues,
                        queries: sectionHeaderQueries,
                        widthsPx: widthsPx,
                        ratio: header.column.map((a) => a.width).toList(),
                        alignments: header.column.map((a) => a.alignment).toList(),
                        bg: _hex(header.color),
                        fgList: fg,
                        fontSize: rowStyle.fontSize.toDouble(),
                        fontWeight: FontWeight.w500,
                        padding: widget.cellPadding,
                      ),
                      children: [
                        ...sectionRows.map((r) {
                          final int i = sectionRows.indexOf(r);
                          final row = r.values.map((a) => a["value"].toString()).toList();
                          final rowQueries = r.values.map((a) => a["q"].toString()).toList();
                          final rowIsEven = i % 2 == 0;
                          final rowStripe = rowIsEven ? rowStyle.even : rowStyle.odd;
                          return _RowStrip(
                            fromDate: widget.toDate,
                            toDate: widget.toDate,
                            texts: List.generate(header.column.length, (i) => i < row.length ? (row[i] ?? '') : ''),
                            queries: rowQueries,
                            widthsPx: widthsPx,
                            ratio: header.column.map((a) => a.width).toList(),
                            alignments: header.column.map((a) => a.alignment).toList(),
                            bg: _hex(rowStripe.color),

                            fgList: fg,
                            fontSize: rowStyle.fontSize.toDouble(),
                            fontWeight: FontWeight.w500,
                            padding: widget.cellPadding,
                          );
                        }),
                      ],
                    );

                  },
                ),
              ),
            ),
          ],
        );

        if (widget.enableHorizontalScroll) {
          final total = widthsPx.fold<double>(0, (a, b) => a + b);
          final needsHScroll = total > contentWidth;
          if (needsHScroll) {
            content = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: total),
                child: content,
              ),
            );
          }
        }

        return content;
      },
    );
  }

  List<double> _computeWidths(double totalWidth, List<TableColumn> cols) {
    final totalWeight = cols.fold<int>(0, (a, c) => a + (c.width <= 0 ? 1 : c.width));
    return cols.map((c) => ((c.width <= 0 ? 1 : c.width) / totalWeight) * totalWidth).toList(growable: false);
  }
}

/// Renders one strip (header or data row) using exact pixel widths (keeps alignment).
class _RowStrip extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final List<String> texts;
  final List<String> queries;
  final List<double> widthsPx;
  final List<int> ratio;
  final List<TableAlignment> alignments;
  final Color bg;
  final List<Color> fgList;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final bool isHeader;

  const _RowStrip({
    required this.fromDate,
    required this.toDate,
    required this.texts,
    required this.queries,
    required this.widthsPx,
    required this.alignments,
    required this.ratio,
    required this.bg,
    required this.fgList,
    required this.fontSize,
    required this.fontWeight,
    required this.padding,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: isHeader ? BorderRadius.vertical(top: Radius.circular(10)) : null,
        border: Border.all(color: ArtemisColors.lineColor, width: 1),
      ),

      child: Row(
        children: List.generate(widthsPx.length, (i) {
          String query = queries[i];
          return Expanded(
            flex: ratio[i],
            child: GestureDetector(
              onTap:query=="null"?null: (){
                if(query.trim().isEmpty){
                  log("no query");
                }else {
                  getIt<PerformanceController>().getOverallPerformances(additionalQuery: query);
                  log("query => ${query}");
                }
              },
              child: Container(
                alignment: Alignment(alignments[i].x.toDouble(), alignments[i].y.toDouble()),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black)
                  border: Border(right: BorderSide(color: MyColors.lineColor, width: 0.5)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Text(
                    i < texts.length ? texts[i] : '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: GoogleFonts.chivoMono(fontSize: fontSize, fontWeight: fontWeight, color: i < fgList.length ? fgList[i] : Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// === helpers ===
Color _hex(String hex) {
  var s = hex.trim();
  if (s.startsWith('#')) s = s.substring(1);
  if (s.length == 3) s = s.split('').map((c) => '$c$c').join();
  if (s.length == 6) s = 'FF$s';
  return Color(int.tryParse(s, radix: 16) ?? 0xFF2D2D2D);
}
