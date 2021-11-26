import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CryptoCard extends StatelessWidget {
  CryptoCard({required this.cryptoCurrency, required this.value, required this.selectedCurrency});
  Object selectedCurrency;
  var value;
  Object cryptoCurrency;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
        child: Card(
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal:  28.0),
              child: Text(
                '1 $cryptoCurrency = $value $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  letterSpacing: 1.0,
                ),
              ),
            )
        )
    );
  }
}
