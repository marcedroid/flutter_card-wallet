import 'package:flutter/material.dart';
import 'package:card_wallet/ui/widgets/my_appbar.dart';

class CardType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _buidTextInfo = Padding(
      padding: EdgeInsets.only(
        left: 10.0,
        top: 20.0,
        right: 10.0
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "You can now add gift cards with a specific balance into wallet. When the card hits \$0.0 it will automatically disappear. Want to know if your gif card will link? ",
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700]
          ),
          children: <TextSpan>[
            TextSpan(
              text: "Learn more",
              style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold
              )
            )
          ]
        )
      ),
    );

    return Scaffold(
      appBar: MyAppBar(
        appBarTitle: "Select Type",
        leadingIcon: Icons.clear,
        context:context,
      ),

      body: Container(
        padding: EdgeInsets.only(
          left: 20.0,
          top: 30.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildRaisedButton(
              buttonColor: Colors.lightBlue,
              buttonText: "Credit Card",
              textColor: Colors.white,
              context: context
            ),

            _buildRaisedButton(
              buttonColor: Colors.white,
              buttonText: "Debit card",
              textColor: Colors.grey[600],
              context: context
            ),

            _buildRaisedButton(
              buttonColor: Colors.white,
              buttonText: "Gif Card",
              textColor: Colors.grey[600],
              context: context
            ),

            _buidTextInfo
          ],
        ),
      ),
    );
  }

  Widget _buildRaisedButton({
    Color buttonColor,
    String buttonText,
    Color textColor,
    BuildContext context
  }){
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5.0
      ),
      child: RaisedButton(
        elevation: 1.0,
        color: buttonColor,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor
          ),
        ),
        onPressed: (){

        }
      ),
    );
  }//_buildRaisedButton
}
