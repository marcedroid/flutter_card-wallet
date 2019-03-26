import 'dart:async';

class Validators {

  final validateCardHolderName = StreamTransformer<String, String>.fromHandlers(
    handleData: (cardHolderName, sink) {
      RegExp(r'[a-zA-Z]').hasMatch(cardHolderName)?
          sink.add(cardHolderName):
          sink.addError("Enter a valid name");
    }
  );

  final validateCardNumber = StreamTransformer<String, String>.fromHandlers(
    handleData:  (cardNumber, sink) {
      RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$')
          .hasMatch(cardNumber)?
          sink.add(cardNumber):
          sink.addError("Enter a valid card number");
    }
  );

  final validateCardMonth = StreamTransformer<String, String>.fromHandlers(
    handleData: (cardMonth, sink) {
      cardMonth.isNotEmpty && int.parse(cardMonth)>0 && int.parse(cardMonth)<13?
          sink.add(cardMonth):
          sink.addError("Err Month");
    }
  );

  final validateCardYear = StreamTransformer<String, String>.fromHandlers(
    handleData: (cardYear, sink) {
      cardYear.isNotEmpty && int.parse(cardYear)>2000 && int.parse(cardYear)<2028?
          sink.add(cardYear):
          sink.addError("Err Year");
    }
  );

  final validateCardCvv = StreamTransformer<String, String>.fromHandlers(
    handleData: (cardCvv, sink) {
      cardCvv.length>2 && cardCvv.length<5?
          sink.add(cardCvv):
          sink.addError("Invalid Cvv");
    }
  );

}