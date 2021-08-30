import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _email = "";
  String _password = "";
  String _name = "";
  String _gender = "";
  String _contact = "";
  String _condition = "";
  String _records = "";

  final _formKey = GlobalKey<FormState>();

  List<String> _genderList = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Color(0xFF337B6E),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "example@gmail.com",
                          icon: Icon(Icons.email),
                          labelText: "Email",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        _email = value;
                      },
                      validator: (value) {
                        if (value.endsWith("@gmail.com")) {
                          return null;
                        } else {
                          return "Only gmail email allowed";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Example123!",
                          icon: Icon(Icons.password),
                          labelText: "Password",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value.length < 6) {
                          return "Need at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Ali Bakar",
                          icon: Icon(Icons.person),
                          labelText: "Name",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.transgender),
                          labelText: "Gender",
                          border: OutlineInputBorder()),
                      items: _genderList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _gender = value as String;
                      },
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       icon: Icon(
                    //           Icons.transgender
                    //       ),
                    //       labelText: "Gender",
                    //       border: OutlineInputBorder()
                    //   ),
                    //   onChanged: (value) {
                    //     _gender = value;
                    //   },
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "+673 0000000",
                          icon: Icon(Icons.phone),
                          labelText: "Phone Number",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        _contact = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: "Depressed",
                          icon: Icon(Icons.medical_services),
                          labelText: "Medical Condition",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        _condition = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: "Check test results here",
                          icon: Icon(Icons.add_chart),
                          labelText: "Medical Records",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        _records = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Text("Update"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print(_email);
                          print(_password);
                          print(_name);
                          print(_gender);
                          print(_contact);
                          print(_condition);
                          print(_records);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
