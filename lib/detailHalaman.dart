import 'package:flutter/material.dart';
import 'editData.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class detailHalaman extends StatefulWidget {
  List list;
  int index;
  detailHalaman({@required this.index, @required this.list});

  @override
  _detailHalamanState createState() => _detailHalamanState();
}

class _detailHalamanState extends State<detailHalaman> {
  void deleteData() {
    var url = "http://192.168.42.198/tokoku_db/deletedata.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Apakah Anda yakin ingin menghapus '${widget.list[widget.index]['nama']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "Ok Delete",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.amber,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePage(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text(
            "Cancel",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.greenAccent[700],
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.list[widget.index]['nama']),
      ),
      body: new Container(
        child: new Card(
          child: new Center(
            child: Column(
              children: <Widget>[
                new Text(widget.list[widget.index]['nama']),
                new Text("Kode: " + widget.list[widget.index]['kode']),
                new Text("Harga: " + widget.list[widget.index]['harga']),
                new Text("Stok: " + widget.list[widget.index]['stok']),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new editData(
                                      list: widget.list,
                                      index: widget.index,
                                    ))),
                        child: new Text("Edit")),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.amber,
                      onPressed: () => confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
