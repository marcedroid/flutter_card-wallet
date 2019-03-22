import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CardBloc {
  BehaviorSubject<String> _cartType = BehaviorSubject<String>();

  //Add data stream
  Function(String) get selectCardType => _cartType.sink.add;

  //Retrieve data from stream
  Stream<String> get cardType => _cartType.stream;

  void dispose(){
    _cartType.close();
  }
}