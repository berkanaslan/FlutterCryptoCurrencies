import 'dart:convert';
import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crypto_search.dart';
import 'favorites_list.dart';
import 'home.dart';
import 'info_page.dart';
import 'models/currency.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {

  String incomingCoinID = "";
  String incomingCoinName = "";

  DetailPage(this.incomingCoinID, this.incomingCoinName);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Currency> futureSingleCurrency;
  String incomingCoinsName = "";
  String appBarName = "";

  Future<List<Currency>> fetchCurrency() async {
    final response = await http
        .get('https://api.alternative.me/v1/ticker/' + incomingCoinsName + '/');

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
    incomingCoinsName = widget.incomingCoinID;
    appBarName = widget.incomingCoinName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(appBarName + " Details"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.star_border),
          ),
        ],
      ),
      body: coinDetails(),
    );
  }

  coinDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 8.0),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: buildFutureBuilder(),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Currency>> buildFutureBuilder() {
    return FutureBuilder(
      future: fetchCurrency(),
      builder: (BuildContext context, AsyncSnapshot<List<Currency>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 92,
                  width: 92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(46),
                    image: DecorationImage(
                      image: AssetImage("assets/images/coin_images/" +
                          snapshot.data[0].name +
                          ".png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 22),
                      children: <TextSpan>[
                        TextSpan(
                            text: snapshot.data[0].name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ", " + snapshot.data[0].symbol)
                      ]),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Price USD: "),
                            TextSpan(
                                text: snapshot.data[0].price_usd + " \$",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Price BTC: "),
                            TextSpan(
                                text: snapshot.data[0].price_btc,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Market Cap. USD: "),
                            TextSpan(
                                text: snapshot.data[0].market_cap_usd + " \$",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Available Supply: "),
                            TextSpan(
                                text: snapshot.data[0].available_supply,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Total Supply: "),
                            TextSpan(
                                text: snapshot.data[0].total_supply,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Maximum Supply: "),
                            TextSpan(
                                text: snapshot.data[0].max_supply,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Percent Change 1h: "),
                            TextSpan(
                                text: snapshot.data[0].percent_change_1h,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Percent Change 24h: "),
                            TextSpan(
                                text: snapshot.data[0].percent_change_24h,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Percent Change 7d: "),
                            TextSpan(
                                text: snapshot.data[0].percent_change_7d,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    Divider(),
                    RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Last Updated: "),
                            TextSpan(
                                text:
                                    updatedTime(snapshot.data[0].last_updated),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ]),
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Loading..")
              ],
            ),
          );
        }
      },
    );
  }

  updatedTime(String last_updated) {
    var format = new DateFormat("Hm");
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(last_updated + "000"));
    var dateString = format.format(date);
    return dateString.toString();
  }

}
