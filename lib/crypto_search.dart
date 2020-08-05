import 'package:flutter/material.dart';
import 'package:fluttercryptoapp/detail_page.dart';


class CryptoSearch extends SearchDelegate<String> {
  final coinNames = [
    "Bitcoin",
    "Ethereum",
    "Tether",
    "XRP",
    "Bitcoin Cash",
    "Bitcoin SV",
    "Litecoin",
    "EOS",
    "Binance Coin",
    "Tezos",
    "Cardano",
    "OKB",
    "ChainLink",
    "Stellar",
    "Monero",
    "Crypto.com Coin",
    "LEO Token",
    "TRON",
    "Huobi Token",
    "Ethereum Classic",
    "USD Coin",
    "NEO",
    "Dash",
    "IOTA",
    "Cosmos",
    "Zcash",
    "NEM",
    "Dogecoin",
    "Ontology",
    "Basic Attention Token",
    "Maker",
    "FTX Token",
    "VeChain",
    "DigiByte",
    "0x",
    "Paxos Standard",
    "Theta Network",
    "Binance USD",
    "Bitcoin Gold",
    "Lisk",
    "Enjin Coin",
    "Decred",
    "Hedera Hashgraph",
    "ICON",
    "Qtum",
    "Algorand",
    "TrueUSD",
    "Augur",
    "OmiseGO",
    "Hyperion",
    "Numeraire",
    "HUSD",
    "Ravencoin",
    "Kyber Network",
    "Dai",
    "Hiveterminal token",
    "Status",
    "Zilliqa",
    "Waves",
    "Bitcoin Diamond",
    "MonaCoin",
    "Bytom",
    "Electroneum",
    "Nano",
    "Holo",
    "Siacoin",
    "Gatechain Token",
    "Tether Gold",
    "MCO",
    "Energi",
    "DxChain Token",
    "Synthetix Network Token",
    "KuCoin Shares",
    "Aave",
    "Blockstack",
    "Nervos Network",
    "REN",
    "Seele",
    "Komodo",
    "NEXO",
    "Compound Ether",
    "Steem",
    "Reddcoin",
    "BitTorrent",
    "Kusama",
    "Celsius Network",
    "Verge",
    "Unibright",
    "BitShares",
    "Streamr DATAcoin",
    "Matic Network",
    "Ripio Credit Network",
    "Decentraland",
    "Horizen",
    "V.SYSTEMS",
    "HyperCash",
    "Quant",
    "Chiliz",
    "Bytecoin",
    "Tokenize Xchange"
  ];

  final recentSearch = [
    "HyperCash",
    "Quant",
    "Chiliz",
    "Bytecoin",
    "Tokenize Xchange"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return DetailPage(query.toLowerCase(), query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSearch
        : coinNames.where((p) => p.toLowerCase().startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
         query = suggestionList[index];
         Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(query.toLowerCase(), query)));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset(
              "assets/images/coin_images/" + suggestionList[index] + ".png"),
        ),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
    );
  }
}