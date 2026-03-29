class CountryModel {
  final String code;
  final String en;
  final String ar;

  CountryModel({required this.code, required this.en, required this.ar});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'] ?? '',
      en: json['en'] ?? '',
      ar: json['ar'] ?? '',
    );
  }
}
