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
    if(days == null) return "";
    if (days <= 0) return "0m";

    // Rough conversion (not accounting leap years or exact month lengths)
    int years = days ~/ 365;
    int months = (days % 365) ~/ 30;

    String result = "";
    if (years > 0) result += "${years}y ";
    if (months > 0) result += "${months}m";

    return result.trim();
  }
}