class Currency {
    String the24h_volume_usd;
    String available_supply;
    String id;
    String last_updated;
    String market_cap_usd;
    String max_supply;
    String name;
    String percent_change_1h;
    String percent_change_24h;
    String percent_change_7d;
    String price_btc;
    String price_usd;
    String rank;
    String symbol;
    String total_supply;

    Currency({this.the24h_volume_usd, this.available_supply, this.id, this.last_updated, this.market_cap_usd, this.max_supply, this.name, this.percent_change_1h, this.percent_change_24h, this.percent_change_7d, this.price_btc, this.price_usd, this.rank, this.symbol, this.total_supply});

    factory Currency.fromJson(Map<String, dynamic> json) {
        return Currency(
            the24h_volume_usd: json['the24h_volume_usd'],
            available_supply: json['available_supply'],
            id: json['id'],
            last_updated: json['last_updated'],
            market_cap_usd: json['market_cap_usd'],
            max_supply: json['max_supply'],
            name: json['name'],
            percent_change_1h: json['percent_change_1h'],
            percent_change_24h: json['percent_change_24h'],
            percent_change_7d: json['percent_change_7d'],
            price_btc: json['price_btc'],
            price_usd: json['price_usd'],
            rank: json['rank'],
            symbol: json['symbol'],
            total_supply: json['total_supply'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['the24h_volume_usd'] = this.the24h_volume_usd;
        data['available_supply'] = this.available_supply;
        data['id'] = this.id;
        data['last_updated'] = this.last_updated;
        data['market_cap_usd'] = this.market_cap_usd;
        data['max_supply'] = this.max_supply;
        data['name'] = this.name;
        data['percent_change_1h'] = this.percent_change_1h;
        data['percent_change_24h'] = this.percent_change_24h;
        data['percent_change_7d'] = this.percent_change_7d;
        data['price_btc'] = this.price_btc;
        data['price_usd'] = this.price_usd;
        data['rank'] = this.rank;
        data['symbol'] = this.symbol;
        data['total_supply'] = this.total_supply;
        return data;
    }
}