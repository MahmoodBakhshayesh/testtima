import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../home_view_phone.dart';

class LockedDocumentItemRow extends StatelessWidget {
  final DocumentDetail d;
  final Color tileColor;

  const LockedDocumentItemRow({super.key, required this.d, required this.tileColor});

  Widget countryBuilder(dynamic a) => Row(
    children: [
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
      const SizedBox(width: 2),
      Text("$a"),
    ],
  );

  Widget countryPrefixBuilder(String? a) {
    if (a != null) {
      return Row(
        children: [
          const SizedBox(width: 4),
          SizedBox(
            width: 15,
            height: 10,
            child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode(a, width: 22, height: 16)),
          ),
          const SizedBox(width: 4),
          Text(a, style: TextStyle(fontSize: 12)),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: tileColor),
      padding: EdgeInsets.all(12),
      child: Column(
        spacing: 12,
        children: [
          LockedFieldWidget(label: null, value: Text(BasicClass.constData.data.documentCode.firstWhereOrNull((a)=>a.code == d.documentCode?.code)?.toString()??'',style: TextStyle(fontSize: 12,height: 1),)),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: LockedFieldWidget(half: true, label: "Issued In", value: countryPrefixBuilder(d.documentIssueCountry?.code3)),
              ),
              Expanded(
                child: LockedFieldWidget(half: true, label: "Nationality", value: countryPrefixBuilder(d.nationality?.code3)),
              ),
            ],
          ),
          ?d.documentExpiryDate!=null?LockedFieldWidget(
            label: "Expiry Date",
            value: Row(
              children: [
                Expanded(child: Text(DateFormat("dd MMM yyyy").format(d.documentExpiryDate!))),
                Icon(expiryValidationIcon(d.documentExpiryDate), size: 10, color: expiryValidationColor(d.documentExpiryDate)),
                Text(expiryValidator("", d.documentExpiryDate) ?? '', style: TextStyle(fontSize: 10, color: expiryValidationColor(d.documentExpiryDate))),
              ],
            ),
          ):null,
          ?d.birthDate!=null?LockedFieldWidget(
            label: "Birth Date",
            value: Row(
              children: [
                Expanded(child: Text(DateFormat("dd MMM yyyy").format(d.birthDate!))),
                Icon(Icons.date_range, size: 10, color: birthDateValidationColor(d.birthDate)),
                Text(birthDateValidator("", d.birthDate) ?? '', style: TextStyle(fontSize: 10, color: birthDateValidationColor(d.birthDate))),
              ],
            ),
          ):null,
          ?(d.documentNumber??'').isNotEmpty?LockedFieldWidget(label: "Document #", value: Text(d.documentNumber ?? '')):null,
        ],
      ),
    );
  }
}

class LockedFieldWidget extends StatelessWidget {
  final String? label;
  final bool half;
  final Widget value;

  const LockedFieldWidget({super.key, required this.label, required this.value, this.half = false});

  @override
  Widget build(BuildContext context) {
    final headerBg = Color(0xffFFFFFF);
    final bodyBg = Color(0xffF0F2Fa);
    const height = 40.0;
    return Container(
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),

      child: Row(
        children: [
          label == null
              ? SizedBox()
              : Expanded(
                  flex: half ? 5 : 12,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                      color: Colors.white.withOpacity(0.48),
                    ),

                    padding: EdgeInsets.only(left: 8, top: 6, bottom: 6),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(label!, style: TextStyle(fontSize: 11)),
                    ),
                  ),
                ),
          const SizedBox(width: 1.5, height: 40),
          Expanded(
            flex: half ? 4 : 33,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(right: Radius.circular(5),left:  label == null?Radius.circular(5):Radius.zero),
                color: Colors.white.withOpacity(0.48),
              ),
              padding: EdgeInsets.only(left: 4, right: 8, top: 6, bottom: 6),
              child: Align(alignment: Alignment.centerLeft, child: value),
            ),
          ),
        ],
      ),
    );
  }
}
