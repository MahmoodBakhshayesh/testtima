class VersionCheck {
  final bool? success;
  final int? errorCode;
  final String? message;
  final bool isForce;
  final List<DownloadLink>? downloadLink;

  VersionCheck({
    this.success,
    this.errorCode,
    this.message,
    this.isForce = false,
    this.downloadLink,
  });

  factory VersionCheck.fromJson(Map<String, dynamic> json) => VersionCheck(
    success: json["success"],
    errorCode: json["errorCode"],
    message: json["message"],
    isForce: json["isForce"]??false,
    downloadLink: json["downloadLink"] == null ? [] : List<DownloadLink>.from(json["downloadLink"]!.map((x) => DownloadLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "errorCode": errorCode,
    "message": message,
    "isForce": isForce,
    "downloadLink": downloadLink == null ? [] : List<dynamic>.from(downloadLink!.map((x) => x.toJson())),
  };
}

class DownloadLink {
  final String? name;
  final String? url;

  DownloadLink({
    this.name,
    this.url,
  });

  factory DownloadLink.fromJson(Map<String, dynamic> json) => DownloadLink(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}