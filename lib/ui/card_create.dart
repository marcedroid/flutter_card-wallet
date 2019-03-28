import 'package:flutter/material.dart';
import 'package:card_wallet/ui/widgets/my_appbar.dart';
import 'package:card_wallet/ui/widgets/flip_card.dart';
import 'package:card_wallet/ui/widgets/card_front.dart';
import 'package:card_wallet/ui/widgets/card_back.dart';
import 'package:card_wallet/helpers/card_colors.dart';
import 'package:card_wallet/helpers/formatters.dart';
import 'package:card_wallet/blocs/card_bloc.dart';
import 'package:card_wallet/blocs/bloc_provider.dart';
import 'package:card_wallet/models/card_color_model.dart';
import 'card_wallet.dart';

class CardCreate extends StatefulWidget {
  @override
  _CardCreateState createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(_focusNodeListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final _creditCard = Padding(
      padding: EdgeInsets.only(
        top:60
      ),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.only(
          left: 15.0,
          top: 2.0,
          right: 15.0
        ),
        child: FlipCard(
          front: CardFront(rotateTurnValues: 0,),
          back: CardBack()
        ),
      ),
    );

    final _cardHolderName = StreamBuilder<String>(
      stream: bloc.cardHolderName,
      builder: (context, snapshot){
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: bloc.changeCardHolderNAme,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hintText: 'Cardholder name',
            errorText: snapshot.error
          ),
        );
      },
    );

    final _cardNumber = Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: StreamBuilder<String>(
        stream: bloc.cardNumber,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeCardNumber,
            keyboardType: TextInputType.number,
            maxLength: 19,
            maxLengthEnforced: true,
            inputFormatters: [
              MaskedTextInputFormatter(
                mask: 'xxxx xxxx xxxx xxxx',
                separator: ' '
              )
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Card Number',
              counterText: '',
              errorText: snapshot.error
            ),
          );
        }
      ),
    );

    final _cardMonth = StreamBuilder<String>(
      stream: bloc.cardMonth,
      builder: (context, snapshot){
        return Container(
          width: 85.0,
          child: TextField(
            onChanged: bloc.changeCardMonth,
            keyboardType: TextInputType.number,
            maxLength: 2,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'MM',
              counterText: '',
              errorText: snapshot.error
            ),
          ),
        );
      },
    );

    final _cardYear = StreamBuilder<String>(
      stream: bloc.cardYear,
      builder: (context, snapshot){
        return Container(
          width: 120.0,
          child: TextField(
            onChanged: bloc.changeCardYear,
            keyboardType: TextInputType.number,
            maxLength: 4,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'YYYY',
              counterText: '',
              errorText: snapshot.error
            ),
          ),
        );
      },
    );

    final _cardVerificationNumber = StreamBuilder<String>(
      stream: bloc.cardCvv,
      builder: (context, snapshot){
        return Container(
          width: 85.0,
          child: TextField(
            focusNode: _focusNode,
            onChanged: bloc.changeCardCvv,
            keyboardType: TextInputType.number,
            maxLength: 3,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              counterText: '',
              hintText: 'CVV',
              errorText: snapshot.error
            ),
          ),
        );
      },
    );

    final _saveCard = StreamBuilder<bool>(
      stream: bloc.saveCardValid,
      builder: (context, snapshot){
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            color: Colors.blue,
            child: Text(
              'Save Card',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: snapshot.hasData?
              (){
                var blockProvideCardWallet = BlocProvider(
                  child: CardWallet(),
                  bloc: bloc
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => blockProvideCardWallet)
                );
              }:
              null
          ),
        );
      },
    );

    return Scaffold(
      appBar: MyAppBar(
        appBarTitle: 'Create Card',
        leadingIcon: Icons.arrow_back,
        context: context,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        itemExtent: 750.0,
        padding: EdgeInsets.only(
          top: 10.0
        ),
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: _creditCard,
              ),

              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 8.0,),
                      _cardHolderName,
                      _cardNumber,
                      SizedBox(height: 8.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _cardMonth,
                          SizedBox(width: 16.0,),
                          _cardYear,
                          SizedBox(width: 16.0,),
                          _cardVerificationNumber
                        ],
                      ),
                      SizedBox(height: 20.0,),
                      _cardColors(bloc),
                      SizedBox(height: 50.0,),
                      _saveCard
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _cardColors(CardBloc bloc){
    final dotSize = (MediaQuery.of(context).size.width - 220) / CardColor.baseColors.length;
    List<Widget> dotList = List<Widget>();

    for(var i=0; i<CardColor.baseColors.length; i++){
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorList,
          builder: (context, snapshot){
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0
              ),
              child: GestureDetector(
                onTap: () => bloc.selectCardColor(i),
                child: Container(
                  child: snapshot.hasData?
                    snapshot.data[i].isSelected?
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.0,
                      )
                    : Container()
                  :Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: CardColor.baseColors[i],
                    shape: BoxShape.circle
                  ),
                ),
              ),
            );
          },
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
  }//_cardColors
}
