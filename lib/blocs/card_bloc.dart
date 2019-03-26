import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:card_wallet/models/card_color_model.dart';
import 'package:card_wallet/helpers/card_colors.dart';

class CardBloc {
  BehaviorSubject<String> _cardHolderName = BehaviorSubject<String>();
  BehaviorSubject<String> _cardNumber = BehaviorSubject<String>();
  BehaviorSubject<String> _cardMonth = BehaviorSubject<String>();
  BehaviorSubject<String> _cardYear = BehaviorSubject<String>();
  BehaviorSubject<String> _cardCvv = BehaviorSubject<String>();
  BehaviorSubject<String> _cartType = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected = BehaviorSubject<int>(seedValue:0);
  final _cardColors = BehaviorSubject<List<CardColorModel>>();

  //Add data stream
  Function(String) get changeCardHolderNAme => _cardHolderName.sink.add;
  Function(String) get changeCardNumber => _cardNumber.sink.add;
  Function(String) get changeCardMonth => _cardMonth.sink.add;
  Function(String) get changeCardYear => _cardYear.sink.add;
  Function(String) get changeCardCvv => _cardCvv.sink.add;
  Function(String) get selectCardType => _cartType.sink.add;

  //Retrieve data from stream
  Stream<String> get cardHolderName => _cardHolderName.stream.transform(validateCardHolderName);
  Stream<String> get cardNumber => _cardNumber.stream.transform(validateCardNumber);
  Stream<String> get cardMonth => _cardMonth.stream.transform(validateCardMonth);
  Stream<String> get cardYear => _cardYear.stream.transform(validateCardYear);
  Stream<String> get cardCvv => _cardCvv.stream.transform(validateCardCvv);
  Stream<String> get cardType => _cartType.stream;
  Stream<int> get cardColorIndexSelected => _cardColorIndexSelected.stream;
  Stream<List<CardColorModel>> get cardColorList => _cardColors.stream;

  void selectCardColor(int colorIndex) {
    CardColor.cardColors.forEach((element) => element.isSelected = false);
    CardColor.cardColors[colorIndex].isSelected = true;
    _cardColors.sink.add(CardColor.cardColors);
    _cardColorIndexSelected.add(colorIndex);
  }

  void dispose(){
    _cartType.close();
    _cardHolderName.close();
    _cardNumber.close();
    _cardMonth.close();
    _cardYear.close();
    _cardCvv.close();
    _cardColorIndexSelected.close();
    _cardColors.close();
  }
}