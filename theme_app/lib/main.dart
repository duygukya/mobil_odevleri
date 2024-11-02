import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haber Uygulaması',
      home: NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haber Uygulaması',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Haber Uygulaması'),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: Icon(
                _isDarkTheme ? Icons.wb_sunny : Icons.nights_stay,
              ),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Belediyelerden Forma Kampanyasına Büyük İlgi!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Image.network(
                'https://www.samsunhaber.com/images/haberler/2024/11/samsunspor_kulubu_nun_baslattigi_forma_kampanyasina_buyuksehir_belediyesi_basta_olmak_uzere_tum_belediyelerden_destek_geldi_belediyelerden_forma_kampanyasina_buyuk_ilgi_h109812_69aee.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Text(
                'Samsunspor Kulübünün Cumhuriyet’in 101. yılı anısına sosyal medya platformu x (twitter) üzerinden gerçekleştirilen Samsunspor forma kampanyası tamamlandı. Kırmızı beyazlı yönetimin başlattığı forma kampanyası belediyeler tarafından desteklendi. Samsun Büyükşehir Belediye Başkanı Halit Doğan, Cumhuriyet’in 101. yılı anısına sosyal medya platformu x (twitter) üzerinden gerçekleştirilen Samsunspor forma kampanyasına destek verdi.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Diğer Haberler',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildNewsButton('Haber 1'),
                    _buildNewsButton('Haber 2'),
                    _buildNewsButton('Haber 3'),
                    _buildNewsButton('Haber 4'),
                    _buildNewsButton('Haber 5'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(title),
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
        ),
      ),
    );
  }
}
