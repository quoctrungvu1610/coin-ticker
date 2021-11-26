
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'cards.dart';

CoinData coinData = CoinData();
var rate = 0 ;
Object selectedCurrency = "USD";



class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Object selectedCurrency = "USD";
  DropdownButton<dynamic> androidDropdown() {
    List<DropdownMenuItem<Object>> dropdownItems = [];
    for (Object currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency.toString()), value: currency,);
      dropdownItems.add(newItem);
    }
    return DropdownButton<dynamic>(
      //gia tri mac dinh
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        },);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> currencies = [];
    for (Object currency in currenciesList) {
      Widget text = Text(currency.toString());
      currencies.add(text);
    }
    return CupertinoPicker(
        itemExtent: 40.0,
        onSelectedItemChanged:(selectedIndex){
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            getData();
            print(selectedIndex);

          });
        },
        children: currencies
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return androidDropdown();
    }
    else {
      return iOSPicker();
    }
  }
  //hoac
  // Platform?isIOS? iOSPicker():androidDropdown(),
  Map<Object,String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (Object crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[crypto],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRYPTO TICKER',style: TextStyle(
            letterSpacing: 2.0,
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              makeCards()
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.grey,
            // color: Colors.tealAccent.shade50,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}