import 'package:flutter/material.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({Key? key}) : super(key: key);

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  var count = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: new ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: count,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var bilgiList = [
      "X ray cihazından önce metal olan cisimleri üzerinizden bırakmak için hazırlanın (kemer, toka, kulaklık,telefon, kesici ve delici aletler, Vs.)",
      "Bilet işlemlerinden önce bagaja gidecek bavul ve eşyalarınızın ağırlığını tartın. El bağajları içinde 100ml den fazla sıvı ürün (parfüm, kolanya, içecek Vs.) olmadığına emin olun.",
      "Bilet işlemleri bankosuna uğrayın ve biletinizi alın ve bagajınızı teslim edin.",
      "Uçağınıza gitmek için pasaport ve kimliğinizi hazırlayıp pasaport kontrol noktasına gidin.",
      "Tabelalardaki kapı numaralarını takip edin ve çıkış kapınıza gidin.",
      "çıkış kapısında biletinizi gösterip talimatlara uyarak otobüslere binin.",
      "Uçağa bindikten sonra telefonunuzu uçak moduna alıp uçuşun keyfini çıkarın."
    ];
    var anaBaslikList=["1.Adım","2.Adım","3.Adım","4.Adım","5.Adım","6.Adım","7.Adım",];
    return new buildTile(
      anaBaslik: anaBaslikList[index],
      altMetin: bilgiList[index],
    );
  }
}

class buildTile extends StatefulWidget {
  var anaBaslik;
  var altMetin;

  buildTile({
    this.anaBaslik,
    this.altMetin,
  });

  @override
  State<buildTile> createState() => _buildTileState();
}

class _buildTileState extends State<buildTile> {
  @override
  Widget build(BuildContext context) {
    bool _customTileExpanded = false;
    return new ExpansionTile(
      title: Text(
        widget.anaBaslik,
        style: TextStyle(color: Colors.black,fontSize: 20),
      ),
      children: [
        ListTile(
            title: Text(
          widget.altMetin,
          style: TextStyle(color: Colors.black,fontSize: 20),
        )),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded);
      },
    );
  }
}
