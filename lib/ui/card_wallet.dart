import 'package:flutter/material.dart';
import 'package:card_wallet/ui/widgets/card_front.dart';
import 'package:card_wallet/ui/widgets/my_appbar.dart';
import 'package:card_wallet/ui/app.dart';
import 'package:card_wallet/blocs/card_bloc.dart';
import 'package:card_wallet/blocs/bloc_provider.dart';

class CardWallet extends StatefulWidget {
  @override
  _CardWalletState createState() => _CardWalletState();
}

class _CardWalletState extends State<CardWallet> {
  AnimationController rotateController;
  AnimationController opacityController;
  Animation<double> animation;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);
    /*rotateController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 300)
    );
    opacityController = AnimationController(
      vsync: this, duration: Duration(seconds: 2)
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
