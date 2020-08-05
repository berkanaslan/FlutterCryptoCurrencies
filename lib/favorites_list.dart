import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercryptoapp/models/currency.dart';
import 'package:http/http.dart' as http;

class FavoritesList extends StatefulWidget {
  const FavoritesList({Key key}) : super(key: key);
  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  Future<Currency> futureCurrency;
  int _itemLength;
  List<bool> _isFavorited = [];

  Future<Null> refreshCurrencies() async {
    await Future.delayed(Duration(seconds: 1));
    currencyList();
    return null;
  }

  Future<List<Currency>> fetchCurrency() async {
    final response = await http.get('https://api.alternative.me/v1/ticker/');

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((SingleCurrencyMap) => Currency.fromJson(SingleCurrencyMap))
          .toList();
    } else {
      throw Exception("Veriler getirilemedi.");
    }
  }

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return currencyList();
  }

  RefreshIndicator currencyList() {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshCurrencies,
      child: _itemLength != null
          ? FutureBuilder(
              future: fetchCurrency(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Currency>> snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: _itemLength,
                      itemBuilder: (context, index) {
                        return _isFavorited[index] == true ? ListTile(
                          leading: getSymbols(index, snapshot),
                          title: getPrices(index, snapshot),
                          subtitle: getCryptoNames(index, snapshot),
                          trailing: getFavoriteButtons(index, snapshot),
                          onTap: () {},
                        ) : null;
                      }),
                );
              },
            )
          : FutureBuilder(
              future: fetchCurrency(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Currency>> snapshot) {
                if (snapshot.hasData) {
                  _itemLength = snapshot.data.length;
                  _isFavorited = List<bool>.generate(_itemLength, (_) => false);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _itemLength,
                        itemBuilder: (context, index) {
                          return _isFavorited[index] == true ? ListTile(
                            leading: getSymbols(index, snapshot),
                            title: getPrices(index, snapshot),
                            subtitle: getCryptoNames(index, snapshot),
                            trailing: getFavoriteButtons(index, snapshot),
                            onTap: () {},
                          ) : null;
                        }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
    );
  }

  Widget getSymbols(int index, AsyncSnapshot<List<Currency>> snapshot) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      child: Text(
          snapshot.data[index].symbol.length >= 4
              ? snapshot.data[index].symbol.substring(0, 3)
              : snapshot.data[index].symbol,
          style: TextStyle(color: Colors.white)),
    );
  }

  Widget getPrices(int index, AsyncSnapshot<List<Currency>> snapshot) {
    double price;
    price = double.parse(snapshot.data[index].price_usd);
    price = num.parse(price.toStringAsFixed(4));
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
        setState(() {
          _isFavorited[index] = !_isFavorited[index];
        });
      },
      icon: _isFavorited[index] ? Icon(Icons.star) : Icon(Icons.star_border),
      color: Colors.orange,
    );
  }

  List<bool> get isFavorited => _isFavorited;

  set isFavorited(List<bool> value) {
    _isFavorited = value;
  }
}
