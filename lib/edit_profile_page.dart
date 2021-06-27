import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  final Map mapUser;

  const EditProfilePage({Key key, this.mapUser}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPhoneNUmber = new TextEditingController();

  void simpanData() async {
    await http.post(
        Uri.parse("http://192.168.42.198/tokoku_db/edit_profile.php"),
        body: {
          "id": widget.mapUser['id'].toString(),
          "nama": controllerNama.text,
          "email": controllerEmail.text,
          "phone_number": controllerPhoneNUmber.text,
        });
  }

  @override
  void initState() {
    controllerNama.text = widget.mapUser['nama'];
    controllerEmail.text = widget.mapUser['email'];
    controllerPhoneNUmber.text = widget.mapUser['phone_number'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerNama,
                  decoration:
                      new InputDecoration(hintText: "Ari", labelText: "Name"),
                ),
                new TextField(
                  controller: controllerEmail,
                  decoration: new InputDecoration(
                      hintText: "google@gmail.com", labelText: "Email"),
                ),
                new TextField(
                  controller: controllerPhoneNUmber,
                  decoration: new InputDecoration(
                      hintText: "081xxxxxxx", labelText: "Phone Number"),
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
