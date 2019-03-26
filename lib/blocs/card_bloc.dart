import 'dart:async';
import 'package:card_wallet/models/card_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:card_wallet/models/card_color_model.dart';
import 'package:card_wallet/helpers/card_colors.dart';
import 'validators.dart';
import 'package:card_wallet/blocs/bloc_provider.dart';
import 'package:card_wallet/blocs/card_list_bloc.dart';

class CardBloc with Validators implements BlocBase{
  BehaviorSubject<String> _cardHolderName = BehaviorSubject<String>();
  BehaviorSubject<String> _cardNumber = BehaviorSubject<String>();
  BehaviorSubject<String> _cardMonth = BehaviorSubject<String>();
  BehaviorSubject<String> _cardYear = BehaviorSubject<String>();
  BehaviorSubject<String> _cardCvv = BehaviorSubject<String>();
  BehaviorSubject<String> _cartType = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected = BehaviorSubject<int>();
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
  Stream<bool> get saveCardValid => Observable.combineLatest5(
      cardHolderName, cardNumber, cardMonth, cardYear, cardCvv, (ch,cn,cm,cy,cc) => true
  );

  void saveCard() {
    final newCard = CardResults(
      cardHolderName: _cardHolderName.value,
      cardNumber: _cardNumber.value.replaceAll(RegExp(r'\s+\b|\b\s'), ""),
      cardMonth: _cardMonth.value,
      cardYear: _cardYear.value,
      cardCvv: _cardCvv.value,
      cardColor: CardColor.baseColors[_cardColorIndexSelected.value],
      cardType: _cartType.value
    );

    cardListBloc.addCardToList(newCard);
  }

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