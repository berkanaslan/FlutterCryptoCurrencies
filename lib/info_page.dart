import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                      child: Text(
                    "Crypto Currencies",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  Divider(),
                  Text(
                    "Bu uygulama, 3. parti bir API kullanarak "
                    "120'den fazla kripto para biriminin, USD (\$) "
                    "değer karşılığının anlık olarak takip edilebilmesi "
                    "amacıyla hazırlanmıştır.",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Veriler, alternative.me alan adlı web sitesi üzerinden, "
                    "CoinMarketCap şirketinin altyapısı ile "
                    "kullanıcı kullanımına sunulmuştur. "
                    "Verilen değerlerin doğruluğu "
                    "CoinMarketCap sorumluluğundadır.",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Kripto paraların \$ cinsinden karşılığı "
                    "her beş (5) dakikada bir güncellenmektedir. "
                    "Bu hizmet, yayın hayatına devam ettiği süre boyunca "
                    "ücret talebinde bulunmayacak ve reklam gösterimi yapmayacaktır. ",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Verilen bilgilerin hiçbiri, bir yatırım tavsiyesi, "
                    "finansal tavsiye veya herhangi bir tavsiye niteliği taşımamaktadır.",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Berkan ASLAN, Geliştirici\nhello@berkanaslan.com",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
