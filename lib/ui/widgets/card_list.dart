import 'package:flutter/material.dart';
import 'package:card_wallet/models/card_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:card_wallet/blocs/card_list_bloc.dart';
import 'package:card_wallet/ui/widgets/card_chip.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<CardResults>>(
      stream: cardListBloc.cardsList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: !snapshot.hasData ?
              _circularProgress() :
              SizedBox(
                child: Swiper(
                  itemCount: snapshot.data.length,
                  itemWidth: _screenSize.width * 0.7,
                  itemHeight: _screenSize.height * 0.5,
                  layout: SwiperLayout.STACK,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return CardFrontList(
                      cardModel: snapshot.data[index],
                    );
                  },
                ),
              )
        );
      },
    );
  }

  Widget _circularProgress(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }//_circularProgress
}

class CardFrontList extends StatelessWidget {
  final CardResults cardModel;

  CardFrontList({this.cardModel});

  @override
  Widget build(BuildContext context) {
    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 25.0,
            right: 52.0
          ),
          child: Image(
            image: AssetImage('assets/visa_logo.png'),
            width: 65.0,
            height: 32.0,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            right: 52.0
          ),
          child: Text(
            cardModel.cardType,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400
            ),
          ),
        )
      ],
    );

    final _cardNumber = Padding(
      padding: EdgeInsets.only(
        top: 15.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildDots()
        ],
      ),
    );

    final _cardLastNumber = Padding(
      padding: EdgeInsets.only(
        top: 1.0,
        left: 55.0
      ),
      child: Text(
        cardModel.cardNumber.substring(12),
        style: TextStyle(
          color: Colors.white,
          fontSize: 8.0
        ),
      ),
    );

    final _cardValidThru = Padding(
      padding: EdgeInsets.only(
        top: 8.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "VALID\nTHRU",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8.0
            ),
          ),

          SizedBox(width: 5.0,),

          Text(
            "${cardModel.cardMonth}/${cardModel.cardYear.substring(2)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
            ),
          )
        ],
      ),
    );

    final _cardOwner = Padding(
      padding: EdgeInsets.only(
        top: 15.0,
        left: 50.0
      ),
      child: Text(
        cardModel.cardHolderName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: cardModel.cardColor
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cardLogo,
            CardChip(),
            _cardNumber,
            _cardLastNumber,
            _cardValidThru,
            _cardOwner
          ],
        ),
      ),
    );
  }

  Widget _buildDots(){
    List<Widget> dotList = List<Widget>();
    var counter = 0;

    for(var i=0; i<12; i++){
      counter+=1;

      dotList.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
          ),
        )
      );

      if(counter==4){
        counter=0;
        dotList.add(
          SizedBox(
            width: 38.0,
          )
        );
      }
    }//for

    dotList.add(_buildNumbers());

    return Row(
      children: dotList,
    );
  }//_buildDots

  Widget _buildNumbers() {
    return Text(
      cardModel.cardNumber.substring(12),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        letterSpacing: 2.0
      ),
    );
  }//_buildNumbers
}
