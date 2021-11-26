import 'package:flutter/material.dart';

import 'network.dart';
const coinAPIUrL = 'rest.coinapi.io';
const APIKey = "0769BC08-42C0-493A-914D-A5A273F42AA7";
Object coinName = 'BTC';
Object exchangedCurrency = 'USD';
String coinAPIPath = "/v1/exchangerate/$coinName/$exchangedCurrency";
const List<Object> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'VND',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<Object> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'DOGE',
  'OMG',
  'USDT',
  'BUSD'
];

class CoinData {
  Future getCoinData(Object selectedCurrency)async{
    Map<Object,String> cryptoPrices = {};
    for(Object crypto in cryptoList){
      coinAPIPath = "/v1/exchangerate/$crypto/$selectedCurrency";
      NetworkHelper networkHelper = NetworkHelper(url: Uri.http("$coinAPIUrL","$coinAPIPath",{"apikey":"$APIKey"}));
      var decodedData = await networkHelper.getData();
      double price = decodedData['rate'];
      cryptoPrices[crypto]=price.toStringAsFixed(0);
    }
    return cryptoPrices;
  }
}
