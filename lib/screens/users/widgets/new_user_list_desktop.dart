import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/people_class.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:flutter/material.dart';

// class UserRowItem {
//   final String userName; // e.g. JOHN DOE
//   final String employeeId; // e.g. 6772891
//   final String type; // e.g. ADMIN
//   final String station; // e.g. MAN
//   final bool active;
//   final String? subtitle; // optional (e.g. @PICKT)
//   final Color? borderColor;
//
//   const UserRowItem({
//     required this.userName,
//     required this.employeeId,
//     required this.type,
//     required this.station,
//     required this.active,
//     this.subtitle,
//     this.borderColor,
//   });
//
//   UserRowItem copyWith({bool? active}) => UserRowItem(
//     userName: userName,
//     employeeId: employeeId,
//     type: type,
//     station: station,
//     active: active ?? this.active,
//     subtitle: subtitle,
//     borderColor: borderColor,
//   );
// }

class SimplePagedUserListView extends StatefulWidget {
  const SimplePagedUserListView({
    super.key,
    required this.items,
    this.initialPageSize = 12,
    this.pageSizeOptions = const [8, 12, 24, 50, 100],
    this.onToggleActive,
    this.onActionTap,
    this.borderColor,
    this.emptyText = "No users",
    this.rowHeight = 45,
  });

  final List<People> items;
  final Color? borderColor;

  /// Default: 12 / Page (like screenshot)
  final int initialPageSize;
  final List<int> pageSizeOptions;

  /// Called when user toggles Active switch
  final void Function(int absoluteIndex, bool active)? onToggleActive;

  /// Called when user taps the (...) action on a row
  final void Function(int absoluteIndex, People item)? onActionTap;

  final String emptyText;

  /// Match screenshot spacing
  final double rowHeight;

  @override
  State<SimplePagedUserListView> createState() => _SimplePagedUserListViewState();
}

class _SimplePagedUserListViewState extends State<SimplePagedUserListView> {
  late int _pageSize = widget.initialPageSize;
  int _pageIndex = 0; // 0-based

  int get _total => widget.items.length;

  int get _pageCount {
    if (_total == 0) return 1;
    final pages = (_total / _pageSize).ceil();
    return pages.clamp(1, 1 << 30);
  }

  bool get _canPrev => _pageIndex > 0;
  bool get _canNext => _pageIndex < _pageCount - 1;

  List<People> get _pageItems {
    if (_total == 0) return const [];
    final start = _pageIndex * _pageSize;
    final end = (start + _pageSize).clamp(0, _total);
    if (start >= _total) return const [];
    return widget.items.sublist(start, end);
  }

  void _goFirst() => setState(() => _pageIndex = 0);
  void _goPrev() => setState(() => _pageIndex = (_pageIndex - 1).clamp(0, _pageCount - 1));
  void _goNext() => setState(() => _pageIndex = (_pageIndex + 1).clamp(0, _pageCount - 1));
  void _goLast() => setState(() => _pageIndex = _pageCount - 1);

  @override
  void didUpdateWidget(covariant SimplePagedUserListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final maxIndex = _pageCount - 1;
    if (_pageIndex > maxIndex) _pageIndex = maxIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderColor =
        widget.borderColor ?? theme.colorScheme.outlineVariant.withOpacity(0.65);
    final surface = theme.colorScheme.surface;
    final headerBg = theme.colorScheme.surfaceVariant.withOpacity(0.35);

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _HeaderRow(
            background: headerBg,
            borderColor: borderColor,
          ),

          // body
          if (_total == 0)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.emptyText, style: theme.textTheme.bodyMedium),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: _pageItems.length,
                separatorBuilder: (_, __) => Divider(height: 1, thickness: 1, color: borderColor),
                itemBuilder: (context, i) {
                  final item = _pageItems[i];
                  final absoluteIndex = _pageIndex * _pageSize + i;

                  return SizedBox(
                    height: widget.rowHeight,
                    child: _DataRowTile(
                      backgroundColor: Colors.black.withOpacity(i.isEven?0:0.02),
                      index: absoluteIndex + 1,
                      item: item,
                      borderColor: borderColor,
                      onToggle: (v) => widget.onToggleActive?.call(absoluteIndex, v),
                      onAction: () => widget.onActionTap?.call(absoluteIndex, item),
                    ),
                  );
                },
              ),
            ),

          Divider(height: 1, thickness: 1, color: borderColor),
          _BottomPagerBar(
            pageSize: _pageSize,
            pageSizeOptions: widget.pageSizeOptions,
            onPageSizeChanged: (v) {
              if (v == null) return;
              setState(() {
                _pageSize = v;
                _pageIndex = 0;
              });
            },
            canPrev: _canPrev,
            canNext: _canNext,
            pageNumberHuman: _pageIndex + 1,
            onFirst: _goFirst,
            onPrev: _goPrev,
            onNext: _goNext,
            onLast: _goLast,
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.background,
    required this.borderColor,
  });

  final Color background;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    Widget headerCell(
        String text, {
          required double flex,
          required bool showRightBorder,
          TextAlign align = TextAlign.left,
          EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        }) {
      return Expanded(
        flex: (flex * 1000).toInt(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: showRightBorder ? BorderSide(color: borderColor, width: 1) : BorderSide.none,
            ),
          ),
          padding: padding,
          child: Text(
            text,
            textAlign: align,
            style: t.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: t.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        border: Border(
          bottom: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          headerCell('#', flex: 0.45, showRightBorder: true),
          headerCell('USER', flex: 2.0, showRightBorder: true),
          headerCell('EMPLOYEE ID', flex: 2.0, showRightBorder: true),
          headerCell('TYPE', flex: 2.0, showRightBorder: true),
          headerCell('STATION', flex: 2.0, showRightBorder: true),
          headerCell('ACTIVE',
              flex: 0.9, showRightBorder: true, align: TextAlign.center),

          // actions col (no right border; table outer border already exists)
          SizedBox(
            width: 44,
            child: Center(
              child: Text(
                '',
                style: t.textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataRowTile extends StatelessWidget {
  const _DataRowTile({
    required this.index,
    required this.item,
    required this.borderColor,
    this.backgroundColor,
    required this.onToggle,
    required this.onAction,
  });

  final int index;
  final People item;
  final Color borderColor;
  final Color? backgroundColor;
  final ValueChanged<bool> onToggle;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    Widget cell({
      required Widget child,
      required double flex,
      required bool showRightBorder,
      Alignment align = Alignment.centerLeft,
      EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    }) {
      return Expanded(
        flex: (flex * 1000).toInt(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: showRightBorder ? BorderSide(color: borderColor, width: 1) : BorderSide.none,
            ),
            color: backgroundColor
          ),
          child: Align(
            alignment: align,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      );
    }
    Color dataColor = item.enable?Colors.black:Colors.black26;

    return Row(
      children: [
        cell(
          flex: 0.45,
          showRightBorder: true,
          child: Text(
            index.toString(),
            style: t.textTheme.bodyMedium?.copyWith(
              color: t.colorScheme.onSurface.withOpacity(0.65),
            ),
          ),
        ),
        // USER cell (avatar + name/subtitle)
        cell(
          flex: 2.0,
          showRightBorder: true,
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: t.colorScheme.surfaceVariant.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                // child: Icon(Icons.person, size: 18, color: t.colorScheme.onSurface.withOpacity(0.55)),
                child: IcomoonLayeredCss.user_square(colors: [Colors.black12,Colors.black,Colors.black],size: 32),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (item.username??'').toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: t.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300,color: dataColor,height: 1),
                    ),
                    if (item.name!.trim().isNotEmpty)
                      Text(
                        item.name!,
                        overflow: TextOverflow.ellipsis,
                        style: t.textTheme.bodySmall?.copyWith(
                          height: 1,
                          color: t.colorScheme.onSurface.withOpacity(0.55),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        cell(
          flex: 2.0,
          showRightBorder: true,
          child: Text("${item.employeeId??''}", style: t.textTheme.bodyMedium?.copyWith(color: dataColor)),
        ),
        cell(
          flex: 2.0,
          showRightBorder: true,
          child: Text("${item.userType}", style: t.textTheme.bodyMedium?.copyWith(color: dataColor)),
        ),
        cell(
          flex: 2.0,
          showRightBorder: true,
          child: Text("${item.station}", style: t.textTheme.bodyMedium?.copyWith(color: dataColor)),
        ),

        // ACTIVE switch centered
        cell(
          flex: 0.9,
          showRightBorder: true,
          align: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),

          child: Transform.scale(
            scale: 0.9,
            child: Switch(
              value: item.enable,
              onChanged: onToggle,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.black12,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),

        // Actions ( ... ) last column, no right border
        SizedBox(
          width: 44,
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onAction,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: t.colorScheme.surfaceVariant.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.more_horiz, size: 18, color: t.colorScheme.onSurface.withOpacity(0.6)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomPagerBar extends StatelessWidget {
  const _BottomPagerBar({
    required this.pageSize,
    required this.pageSizeOptions,
    required this.onPageSizeChanged,
    required this.canPrev,
    required this.canNext,
    required this.pageNumberHuman,
    required this.onFirst,
    required this.onPrev,
    required this.onNext,
    required this.onLast,
  });

  final int pageSize;
  final List<int> pageSizeOptions;
  final ValueChanged<int?> onPageSizeChanged;

  final bool canPrev;
  final bool canNext;
  final int pageNumberHuman;

  final VoidCallback onFirst;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onLast;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    Widget navIcon(IconData icon, {required bool enabled, required VoidCallback onTap}) {
      return IconButton(
        onPressed: enabled ? onTap : null,
        icon: Icon(icon),
        iconSize: 18,
        splashRadius: 18,
        color: t.colorScheme.onSurface.withOpacity(enabled ? 0.85 : 0.3),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          // left: "12 / Page" dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: t.colorScheme.surfaceVariant.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: t.colorScheme.outlineVariant.withOpacity(0.6)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                dropdownColor: t.colorScheme.surface,
                value: pageSize,
                isDense: true,
                borderRadius: BorderRadius.circular(12),
                items: pageSizeOptions
                    .map(
                      (v) => DropdownMenuItem(
                    value: v,
                    child: Text("$v / Page", style: t.textTheme.bodyMedium),
                  ),
                )
                    .toList(),
                onChanged: onPageSizeChanged,
              ),
            ),
          ),

          const Spacer(),

          // right: pagination like screenshot
          navIcon(Icons.chevron_left, enabled: canPrev, onTap: onPrev),
          navIcon(Icons.keyboard_double_arrow_left, enabled: canPrev, onTap: onFirst),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: t.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$pageNumberHuman",
              style: t.textTheme.bodyMedium?.copyWith(
                color: t.colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          navIcon(Icons.keyboard_double_arrow_right, enabled: canNext, onTap: onLast),
          navIcon(Icons.chevron_right, enabled: canNext, onTap: onNext),
        ],
      ),
    );
  }
}
