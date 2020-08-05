import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercryptoapp/detail_page.dart';
import 'package:fluttercryptoapp/models/currency.dart';
import 'package:http/http.dart' as http;

import 'crypto_search.dart';

class AppBody extends StatefulWidget {
  AppBody({Key key}) : super(key: key);

  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  Future<List<Currency>> _future;
  GlobalKey<RefreshIndicatorState> refreshKey;
  int _itemLength;
  String _favoriteInfo;
  List<bool> _isFavorited = [];

  Future<Null> refreshCurrencies() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _future = fetchCurrency();
    });
    return null;
  }

  Future<List<Currency>> fetchCurrency() async {
    final response = await http.get('https://api.alternative.me/v1/ticker/');

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((SingeCurrencyMap) => Currency.fromJson(SingeCurrencyMap))
          .toList();
    } else {
      throw Exception("Veriler getirilemedi.");
    }
  }

  @override
  void initState() {
    super.initState();
    _future = fetchCurrency();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return currencyList();
  }

  Widget currencyList() {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshCurrencies,
      child: _itemLength != null
          ? FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<List<Currency>> snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: _itemLength,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: getSymbols(index, snapshot),
                          title: getPrices(index, snapshot),
                          subtitle: getCryptoNames(index, snapshot),
                          trailing: getFavoriteButtons(index, snapshot),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        snapshot.data[index].id,
                                        snapshot.data[index].name)));
                          },
                        );
                      }),
                );
              },
            )
          : FutureBuilder(
              future: fetchCurrency(),
              builder: (BuildContext context, AsyncSnapshot<List<Currency>> snapshot) {
                if (snapshot.hasData) {
                  _itemLength = snapshot.data.length;
                  _isFavorited = List<bool>.generate(_itemLength, (_) => false);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _itemLength,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: getSymbols(index, snapshot),
                            title: getPrices(index, snapshot),
                            subtitle: getCryptoNames(index, snapshot),
                            trailing: getFavoriteButtons(index, snapshot),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          snapshot.data[index].id,
                                          snapshot.data[index].name)));
                            },
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Crypto coins are loading..")
                      ],
                    ),
                  );
                }
              }),
    );
  }

  Widget getSymbols(int index, AsyncSnapshot<List<Currency>> snapshot) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child:
          Image.asset("assets/images/coin_images/" + snapshot.data[index].name + ".png"),
    );
  }

  Widget getPrices(int index, AsyncSnapshot<List<Currency>> snapshot) {
    double price;
    price = double.parse(snapshot.data[index].price_usd);
    price = num.parse(price.toStringAsFixed(6));
    return Text(
      "\$" + price.toString(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget getCryptoNames(int index, AsyncSnapshot<List<Currency>> snapshot) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            color: Colors.grey,
          ),
          children: <TextSpan>[
            TextSpan(
                text: snapshot.data[index].name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ", " + snapshot.data[index].symbol),
          ]),
    );
  }

  Widget getFavoriteButtons(int index, AsyncSnapshot<List<Currency>> snapshot) {
    return IconButton(
      onPressed: () {
        if (!_isFavorited[index]) {
          _favoriteInfo = snapshot.data[index].name + " added to favorites.";
        } else {
          _favoriteInfo = snapshot.data[index].name + " removed to favorites.";
        }
        setState(() {
          _isFavorited[index] = !_isFavorited[index];
          final snackBar = SnackBar(
            content: Text(_favoriteInfo),
            action: SnackBarAction(
              onPressed: () {
                setState(() {
                  _isFavorited[index] = !_isFavorited[index];
                });
              },
              label: "Undo",
              textColor: Colors.white,
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        });
      },
      icon: _isFavorited[index] ? Icon(Icons.star) : Icon(Icons.star_border),
      color: Colors.orange,
    );
  }
}
