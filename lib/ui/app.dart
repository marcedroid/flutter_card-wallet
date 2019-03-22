import 'package:flutter/material.dart';
import 'package:card_wallet/ui/widgets/card_list.dart';
import 'package:card_wallet/ui/card_type.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: (){}
        ),
        title: Text(
          "Wallet",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CardType(),
              ));
            },
          )
        ],
      ),

      body: Container(
        child: CardList(),
      ),
    );
  }
}
