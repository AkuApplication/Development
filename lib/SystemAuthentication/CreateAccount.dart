import 'package:chat_app/SystemAuthentication/Methods.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  //Initializing variables
  List<String> _genderList = ["Male", "Female"];
  List<String> _phoneCodeList = ["+673"];
  bool _obscureText = true;
  String _name;
  String _gender;
  String _phoneCode;
  String _contact;
  String _email;
  String _password;
  String _message = "An email has just been sent to you. Click the link provided in your email to complete registration";

  //Created a FormKey to interact with the Form
  final _formKey = GlobalKey<FormState>();

  //Created a default Gender Icon to be able to change its state later on accordingly
  Icon icon = Icon(
    Icons.transgender,
    color: Colors.grey,
  );

  //Method for Showing and Hiding Password
  void _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Getting the size according to the device being used to ryn the app
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width / 1.2,
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Container(
                width: size.width / 1.3,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 70,
              ),
              Container(
                width: size.width / 1.3,
                child: Text(
                  "Create Account to Continue!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                          validator: (value) {
                            if (value.isNotEmpty) {
                              return null;
                            } else {
                              return "Required your name";
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          decoration: decoText.copyWith(
                              hintText: "Name",
                              prefixIcon:
                              Icon(Icons.person, color: Colors.grey)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonFormField(
                          decoration: decoText.copyWith(
                              labelText: "Gender",
                              prefixIcon: icon
                          ),
                          value: _gender,
                          items: _genderList.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _gender = value as String;
                            if(_gender == "Female"){
                              setState(() {
                                icon = Icon(
                                  Icons.female,
                                  color: Colors.grey,
                                );
                              });
                            } else if(_gender == "Male"){
                              setState(() {
                                icon = Icon(
                                  Icons.male,
                                  color: Colors.grey,
                                );
                              });
                            }
                          },
                          validator: (value) {
                            if(value != null){
                              return null;
                            } else {
                              return "Please pick your gender";
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width / 4,
                            child: DropdownButtonFormField(
                              decoration: decoText.copyWith(
                                  labelText: "Code",
                              ),
                              value: _phoneCode,
                              items: _phoneCodeList.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _phoneCode = value as String;
                                });
                              },
                              validator: (value) {
                                if(value != null){
                                  return null;
                                } else {
                                  return "Please pick a phone code";
                                }
                              },
                            ),
                          ),
                          SizedBox(width: size.width / 20,),
                          Flexible(
                            child: TextFormField(
                                validator: (value) {
                                  if (value.length < 7) {
                                    return "Please insert your real phone number";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _contact = value;
                                  });
                                },
                                decoration: decoText.copyWith(
                                    hintText: "Phone Number",
                                    prefixIcon:
                                    Icon(Icons.phone, color: Colors.grey)
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                            validator: (value) {
                              if (value.endsWith("@gmail.com")) {
                                return null;
                              } else {
                                return "Only gmail allowed";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            decoration: decoText.copyWith(
                                hintText: "Email",
                                prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey
                                )
                            )
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                          obscureText: _obscureText,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          decoration: decoText.copyWith(
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.password,
                                color: Colors.grey,
                              )
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value == _password) {
                                return null;
                              } else {
                                return "Password does not match";
                              }
                            },
                            decoration: decoText.copyWith(
                                hintText: "Confirm Password",
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.grey,
                                )
                            )
                        ),
                      ),
                    ),
                    ListTile(
                      title: _obscureText ? Text("Show Password") : Text("Hide Password"),
                      leading: Checkbox(
                        activeColor: Colors.teal.shade300,
                        value: !_obscureText,
                        onChanged: (value) {
                          _togglePass();
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 7,
                    ),
                    customButton(size),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                          "Already have an Account ?",
                          style: TextStyle(
                            color: Colors.teal.shade400,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //A custom Widget
  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        //To validate the form
        if (_formKey.currentState.validate()) {
          showDialog(context: context, barrierDismissible: false, builder: (context) {
            return WillPopScope(
              onWillPop: () => null,
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: size.width / 3),
                child: Container(
                  height: size.height / 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: size.width / 40,),
                      Text("Loading...", textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            );
          },);

          //Combined the code with the phone number to complete the contact
          setState(() {
            _contact = _phoneCode + _contact;
          });

          await Methods().createAccount(_email, _password, _name, _gender, _contact).then((user) {
            Navigator.pop(context);
            showDialog(context: context, barrierDismissible: false, builder: (context) {
              return WillPopScope(
                onWillPop: () => null,
                child: AlertDialog(
                  content: Text(
                    _message,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close"),
                      ),
                    ),
                  ],
                ),
              );
            },);
          }).onError((error, stackTrace) {
            Navigator.pop(context);
            showDialog(context: context, barrierDismissible: false, builder: (context) {
              return WillPopScope(
                onWillPop: () => null,
                child: AlertDialog(
                  content: Text(
                    error.message,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close"),
                      ),
                    ),
                  ],
                ),
              );
            },);
          });
        }
      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.teal.shade400,
        ),
        alignment: Alignment.center,
        child: Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
