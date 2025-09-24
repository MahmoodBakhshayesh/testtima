class SupportedLanguage {
  final String? country;
  final List<Language>? languages;

  SupportedLanguage({
    this.country,
    this.languages,
  });

  SupportedLanguage copyWith({
    String? country,
    List<Language>? languages,
  }) =>
      SupportedLanguage(
        country: country ?? this.country,
        languages: languages ?? this.languages,
      );

  factory SupportedLanguage.fromJson(Map<String, dynamic> json) => SupportedLanguage(
    country: json["country"],
    languages: json["languages"] == null ? [] : List<Language>.from(json["languages"]!.map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x.toJson())),
  };
}

class Language {
  final String? title;
  final String? name;
  final String? language;

  Language({
    this.title,
    this.name,
    this.language,
  });

  Language copyWith({
    String? title,
    String? name,
    String? language,
  }) =>
      Language(
        title: title ?? this.title,
        name: name ?? this.name,
        language: language ?? this.language,
      );

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    title: json["title"],
    name: json["name"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "name": name,
    "language": language,
  };
}