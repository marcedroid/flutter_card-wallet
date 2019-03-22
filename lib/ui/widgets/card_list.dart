import 'package:flutter/material.dart';
import 'package:card_wallet/models/card_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:card_wallet/blocs/card_list_bloc.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<CardResults>>(
      stream: cardListBloc.cardsList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Column(
          children: <Widget>[
            !snapshot.hasData ?
              CircularProgressIndicator() :
              SizedBox(
                height: _screenSize.height * 0.8,
                child: Swiper(
                  itemCount: snapshot.data.lenght,
                  itemWidth: _screenSize.height * 0.7,
                  itemHeight: _screenSize.width * 0.5,
                  layout: SwiperLayout.STACK,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                ),
              )
          ],
        );
      },
    );
  }
}
