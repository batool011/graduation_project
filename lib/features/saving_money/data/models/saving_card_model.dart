class SavingCardModel {
  final String name;
  final String monthlyAmount;
  final String type;

  SavingCardModel({
    required this.name,
    required this.monthlyAmount,
    required this.type,
  });
String get imagePath => "assets/images/${type}_card.jpg";

}
