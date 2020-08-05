import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fluttercryptoapp/detail_page.dart';
import 'crypto_search.dart';
import 'favorites_list.dart';
import 'home.dart';
import 'info_page.dart';

class AppBottomNavigationBarController extends StatefulWidget {
  @override
  _AppBottomNavigationBarControllerState createState() =>
      _AppBottomNavigationBarControllerState();
}

class _AppBottomNavigationBarControllerState
    extends State<AppBottomNavigationBarController> {
  List<Widget> _pageOptions = [
    AppBody(
      key: PageStorageKey('AllCryptoList'),
    ),
    FavoritesList(
      key: PageStorageKey('FavoriteCryptoList'),
    ),
    AppBody(
      key: PageStorageKey('AllCryptoList'),
    ),
    InfoPage(
      key: PageStorageKey('AppInfoPage'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Crypto Currencies"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CryptoSearch());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: _pageOptions[_selectedIndex],
        bucket: bucket,
      ),
    );
  }

  buildBottomNavigationBar(int selectedIndex) {
    return BottomNavyBar(
      showElevation: true,
      itemCornerRadius: 50,
      curve: Curves.decelerate,
      onItemSelected: (int index) => setState(() => _selectedIndex = index),
      selectedIndex: _selectedIndex,
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Colors.deepPurpleAccent,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.star),
          title: Text('Favorites'),
          activeColor: Colors.orange,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
          activeColor: Colors.redAccent,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.info),
          title: Text('Info'),
          activeColor: Colors.blueGrey,
          inactiveColor: Colors.black,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
