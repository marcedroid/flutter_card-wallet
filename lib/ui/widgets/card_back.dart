import 'package:flutter/material.dart';
import 'package:card_wallet/blocs/card_bloc.dart';
import 'package:card_wallet/blocs/bloc_provider.dart';
import 'package:card_wallet/helpers/card_colors.dart';

class CardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    return StreamBuilder<int>(
      stream: bloc.cardColorIndexSelected,
      builder: (context, snapshot){
        return Container(
          decoration: BoxDecoration(
            color: snapshot.hasData?
                CardColor.baseColors[snapshot.data]:
                CardColor.baseColors[0],
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0,),
                Row(
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage('assets/card_band.jpg'),
                        width: 200.0,
                      ),
                    ),

                    SizedBox(width: 15.0,),

                    Container(
                      width: 65.0,
                      height: 42.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(
                          color: Colors.red,
                          width: 3.0
                        ),
                        color: Colors.white
                      ),
                      child: Center(
                        child: StreamBuilder(
                          stream: bloc.cardCvv,
                          builder: (context, snapshot){
                            return Text(
                              snapshot?.data??'',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            );
                          }
                        ),
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: 25.0,
                    left: 12.0
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Image(
                      image: AssetImage('assets/card_band.jpg'),
                      width: 65.0,
                      height: 40.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
