import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class addData extends StatefulWidget {
  @override
  _addDataState createState() => _addDataState();
}

class _addDataState extends State<addData> {
  TextEditingController controllerKode = new TextEditingController();
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerStok = new TextEditingController();
  TextEditingController controllerImage = new TextEditingController();

  void simpanData() {
    http.post(Uri.parse("http://192.168.42.198/tokoku_db/adddata.php"), body: {
      "kodeProduk": controllerKode.text,
      "namaProduk": controllerNama.text,
      "hargaProduk": controllerHarga.text,
      "stokProduk": controllerStok.text,
      "imageProduk": controllerImage.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Menambahkan data"),
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
                      simpanData();
                      Navigator.pop(context);
                    },
                    child: new Text("Save"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
