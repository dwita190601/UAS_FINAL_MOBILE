import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class editData extends StatefulWidget {
  List list;
  int index;
  editData({@required this.index, @required this.list});

  @override
  _editDataState createState() => _editDataState();
}

class _editDataState extends State<editData> {
  TextEditingController controllerKode = new TextEditingController();
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerStok = new TextEditingController();
  TextEditingController controllerImage = new TextEditingController();

  @override
  void initState() {
    controllerKode.text = widget.list[widget.index]['kode'];
    controllerNama.text = widget.list[widget.index]['nama'];
    controllerHarga.text = widget.list[widget.index]['harga'];
    controllerStok.text = widget.list[widget.index]['stok'];
    controllerImage.text = widget.list[widget.index]['image'];
    super.initState();
  }

  void editData() {
    http.post(Uri.parse("http://192.168.42.198/tokoku_db/editdata.php"), body: {
      "kodeProduk": controllerKode.text,
      "namaProduk": controllerNama.text,
      "hargaProduk": controllerHarga.text,
      "stokProduk": controllerStok.text,
      "imageProduk": controllerImage.text,
      "id": widget.list[widget.index]['id'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerKode,
                  decoration: new InputDecoration(
                      hintText: "Kode Produk", labelText: "Kode Produk"),
                ),
                new TextField(
                  controller: controllerNama,
                  decoration: new InputDecoration(
                      hintText: "Nama Produk", labelText: "Nama Produk"),
                ),
                new TextField(
                  controller: controllerHarga,
                  decoration: new InputDecoration(
                      hintText: "Harga Produk", labelText: "Harga Produk"),
                ),
                new TextField(
                  controller: controllerStok,
                  decoration: new InputDecoration(
                      hintText: "Stok Produk", labelText: "Stok Produk"),
                ),
                new TextField(
                  controller: controllerImage,
                  decoration: new InputDecoration(
                      hintText: "https://....", labelText: "Image Produk"),
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new ElevatedButton(
                    onPressed: () {
                      editData();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new MyHomePage()));
                    },
                    child: new Text("Edit"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
