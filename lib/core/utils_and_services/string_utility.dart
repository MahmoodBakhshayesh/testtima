import 'dart:developer';

class StringUtility {
  static String getDurationDetailsString (DateTime dt,{bool justValue = false,bool longStr = false}){
    Duration d = DateTime.now().difference(dt);
    int allDays = d.inDays.abs();
    int years = (allDays/365).floor();
    int months =((allDays-(years*365))/30).floor();
    int days = allDays - (years*365) - (months*30);
    String duStr = "";
    //String result = '';
    if(years==0){
      if(months ==0){
        if(days==0) {
          duStr ="Today";
        }else {
          duStr = "$days D";
        }
      }else{
        if(days==0){
          duStr = "${months}M";
        }else{
          duStr = "${months}M, ${days}D";
        }
      }
    }else{
      if(months==0){
        duStr = "${years}Y";
      }else{
        duStr = "${years}Y, ${months}M";
      }

    }
    if(longStr){
      duStr = duStr.replaceAll("M", "Mounts").replaceAll("D", "Days").replaceAll("Y", "Years").replaceAll(",", " &");
    }
    if(justValue)return duStr;
    if(!d.isNegative && d.inDays>0){
      return 'Expired\n$duStr Ago';
    }else{
      return 'Expires\n $duStr';
    }
  }

  static String formatDaysToYearsMonths(int? days) {
    if (days == null) return '';
    if (days < 0) return "0D";

    final years = days ~/ 365;
    final remAfterYears = days % 365;
    final months = remAfterYears ~/ 30;
    final leftoverDays = remAfterYears % 30;

    final parts = <String>[];
    if (years > 0) parts.add("${years}Y");
    if (months > 0) parts.add("${months}M");
    if (leftoverDays > 0) parts.add("${leftoverDays}D");

    final result = parts.join(' ');
    // debug log
    // import 'dart:developer'; to use log
    // log("age days $days => ${result.isEmpty ? (days == 0 ? 'today' : '${days}D') : result}");

    if (result.isEmpty) {
      // fallback when y and m are zero
      if (days == 0) return 'today';
      return "${days}D";
    }
    return result;
  }

  static String formatDaysToAge(int? days) {
    if (days == null) return '';
    if (days < 0) return "0D";

    final years = days ~/ 365;
    final remAfterYears = days % 365;
    final months = remAfterYears ~/ 30;
    final leftoverDays = remAfterYears % 30;

    final parts = <String>[];
    if (years > 0) parts.add("${years}Y");
    if (months > 0) parts.add("${months}M");
    if (leftoverDays > 0) parts.add("${leftoverDays}D");

    final result = parts.join(' ');
    // debug log
    // import 'dart:developer'; to use log
    // log("age days $days => ${result.isEmpty ? (days == 0 ? 'today' : '${days}D') : result}");

    if (result.isEmpty) {
      // fallback when y and m are zero
      if (days == 0) return 'today';
      return "${days}D";
    }
    return result;
  }

}