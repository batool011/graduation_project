import 'package:career/features/saving_money/data/models/saving_card_model.dart';
import 'package:get/get.dart';
// import 'package:test/features/saving_money/data/models/saving_card_model.dart';


class SavingsController extends GetxController {
  var selectedType = "all".obs;
  var paymentType = "monthly".obs;

  var cards = <SavingCardModel>[
    // SavingCardModel(name: "البطاقة البيضاء", monthlyAmount: "10,000 ر.س شهرياً", type: "white"),
    SavingCardModel(name: "البطاقة الفضية", monthlyAmount: "20,000 ر.س شهرياً", type: "silver"),
    SavingCardModel(name: "البطاقة البرونزية", monthlyAmount: "30,000 ر.س شهرياً", type: "bronze"),
    SavingCardModel(name: "البطاقة الذهبية", monthlyAmount: "60,000 ر.س شهرياً", type: "gold"),
  ].obs;

  void changeType(String type) {
    selectedType.value = type;
  }

  List<SavingCardModel> get filteredCards {
    if (selectedType.value == "all") return cards;
    return cards.where((c) => c.type == selectedType.value).toList();
  }
}
