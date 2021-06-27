import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/edit_profile_page.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'detailHalaman.dart';
import 'addData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLANET GADGET STORE',
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Map mapUser;

  const MyHomePage({Key key, this.mapUser}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map newUser = {};

  Future<List> ambilData() async {
    var data = await http
        .get(Uri.parse("http://192.168.42.198/tokoku_db/ambildata.php"));
    var jsonData = json.decode(data.body);
    return jsonData;
  }

  void ambilDataUser() async {
    final response = await http.post(
      "http://192.168.42.198/tokoku_db/get_user.php",
      body: {
        "id": widget.mapUser['id'].toString(),
      },
    );

    var dataUser = json.decode(response.body);

    setState(() {
      newUser = dataUser;
    });
  }

  void konfirmasiDelete() async {
    var response = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Delete'),
        content: Text('You sure to delete your account?'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, 'yes'),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (response == 'yes') {
      deleteUser();
    }
  }

  void deleteUser() async {
    await http.post(
      "http://192.168.42.198/tokoku_db/delete_user.php",
      body: {
        "id": widget.mapUser['id'].toString(),
      },
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    ambilDataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text("LIST PRODUK"),
      ),
      drawer: profileDrawer(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new addData())),
        child: new Icon(Icons.add),
      ),
      body: Container(
        child: FutureBuilder(
          future: ambilData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading ...."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new detailHalaman(
                                    list: snapshot.data,
                                    index: index,
                                  ))),
                      child: new Card(
                        child: new ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data[index]['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: new Text(snapshot.data[index]['nama']),
                          subtitle:
                              new Text("Stok: " + snapshot.data[index]['stok']),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget profileDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.person, size: 50),
                ),
                SizedBox(height: 8),
                Text(
                  newUser['nama'] == null ? '' : newUser['nama'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  newUser['email'] == null ? '' : newUser['email'],
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  newUser['phone_number'] == null
                      ? ''
                      : newUser['phone_number'],
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    mapUser: widget.mapUser,
                  ),
                ),
              ).then((value) => ambilDataUser());
            },
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () => konfirmasiDelete(),
            leading: Icon(Icons.delete),
            title: Text('Delete Account'),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[400]),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            trailing: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
