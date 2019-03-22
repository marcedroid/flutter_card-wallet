import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:card_wallet/models/card_model.dart';
import 'dart:convert';
import 'package:card_wallet/helpers/card_colors.dart';

class CardListBloc {
  BehaviorSubject<List<CardResults>> _cardsCollection = BehaviorSubject<List<CardResults>>();

  List<CardResults> _cardResults;

  //Retrieve data from stream
  Stream<List<CardResults>> get cardsList => _cardsCollection.stream;

  void initialData() async {
    var initialData = await rootBundle.loadString('data/initialData.json');
    var decodeJson = jsonDecode(initialData);
    _cardResults = CardModel.fromJson(decodeJson).results;

    for(var i = 0; i < _cardResults.length ; i++) {
      _cardResults[i].cardColor = CardColors.baseColors[i];
    }

    _cardsCollection.sink.add(_cardResults);
  }

  CardListBloc(){
    initialData();
  }

  void dispose(){
    _cardsCollection.close();
  }
}

final cardListBloc = CardListBloc();