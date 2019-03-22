import 'package:flutter/material.dart';
import 'package:card_wallet/ui/app.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: true,
    title: "Card Wallet",
    theme: ThemeData(
        primaryColor: Colors.blue,
        backgroundColor: Colors.red
    ),
    home: App(),
  )
);
