import 'package:chat_app/Notifications/notificationsMethods.dart';
import 'package:chat_app/Screens/adminHomePage.dart';
import 'package:chat_app/SystemAuthentication/CreateAccount.dart';
import 'package:chat_app/SystemAuthentication/Methods.dart';
import 'package:chat_app/SystemAuthentication/SendEmailForResetPassword.dart';
import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Screens/counselorHomePage.dart';
import 'package:chat_app/Screens/patientHomePage.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Getting related Firebase instances to be able to interact with Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Created a FormKey to interact with the Form
  final _formKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();

  //Initializing variables
  bool _obscureText = true;
  String _email;
  String _password;
  String _message = "You are not yet verified. Please click on the latest link provided in your email to complete registration.";
  String _account;
  String _phoneNumber;
  String verificationId;
  String _otp;
  bool noOTP = true;
  AuthCredential _authCredential;
  PhoneAuthCredential _phoneAuthCredential;
  int _numOfLogins;
  SharedPreferences sharedPreferences;

  //Getting SharedPreferences instance
  void getPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  //Getting data from Firestore
  void checkFirestore() async {
    await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) async {
      _account = value.data()["accountType"];

      if(_account == "Admin"){
        Navigator.pop(context);
        await _firestore.collection('users').doc(_auth.currentUser.uid).update({
          "status": "Online",
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage(),));
      } else {
        Navigator.pop(context);
        _phoneNumber = value.data()["contact"];

        if(_account == "Patient"){
          _numOfLogins = value.data()["numOfLogins"];
        }
        // Verify phone number and link the phone number to the email account
        await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumber,
          verificationCompleted: (phoneAuthCredential) async {
            // Navigator.pop(context);
            setState(() {
              noOTP = false;
            });
            this._phoneAuthCredential= phoneAuthCredential;
            print(this._phoneAuthCredential);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please insert the OTP code you received above in the specified field")));
            // showDialog(context: context, builder: (context) {
            //   return AlertDialog(
            //     content: TextFormField(
            //       key: _otpKey,
            //       onSaved: (newValue) {
            //         _otp = newValue;
            //       },
            //       cursorColor: Colors.teal.shade300,
            //       decoration: decoText.copyWith(
            //           hintText: "OTP SMS Code",
            //           prefixIcon: Icon(Icons.email, color: Colors.grey)
            //       ),
            //       keyboardType: TextInputType.number,
            //     ),
            //     actions: [
            //       Center(
            //         child: TextButton(
            //           onPressed: () async {
            //             _otpKey.currentState.save();
            //             print(_otp);
            //             if (_otp == phoneAuthCredential.smsCode) {
            //               try {
            //                 this._authCredential = PhoneAuthProvider.credential(verificationId: this.verificationId, smsCode: _otp);
            //                 print(this._authCredential.toString());
            //                 await _auth.currentUser.linkWithCredential(this._authCredential);
            //                 await _auth.signInWithCredential(this._authCredential);
            //               } on FirebaseAuthException catch (e) {
            //                 if (e.code == 'provider-already-linked') {
            //                   await _auth.signInWithCredential(this._authCredential);
            //                 }
            //               }
            //
            //               await _firestore.collection('users').doc(_auth.currentUser.uid).update({
            //                 "status": "Online",
            //               });
            //
            //               Navigator.pop(context);
            //
            //               if (_account == "Patient") {
            //                 _numOfLogins = value.data()["numOfLogins"];
            //                 if(_numOfLogins < 1){
            //                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstTime(),));
            //                 } else {
            //                   firstNotification();
            //                   secondNotification();
            //                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(sharedPreferences: sharedPreferences,),));
            //                 }
            //               } else if (_account == "Counselor") {
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoctorHomePage(),));
            //               }
            //
            //             }
            //           },
            //           child: Text("Verify"),
            //         ),
            //       ),
            //     ],
            //   );
            // },);
          },
          verificationFailed: (error) {
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
          },
          codeSent: (verificationId, forceResendingToken) {
            this.verificationId = verificationId;
            print(this.verificationId);
            // print(this.verificationId);
            // print(forceResendingToken.toString());
          },
          codeAutoRetrievalTimeout: (verificationId) {
            this.verificationId = verificationId;
            showDialog(context: context, barrierDismissible: false, builder: (context) {
              return WillPopScope(
                onWillPop: () => null,
                child: AlertDialog(
                  content: Text(
                    "Timed out.",
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
          },
        );
      }

    });
  }

  //Variables for the notifications value
  bool firstReminder;
  bool secondReminder;

  void firstNotification() async {
    firstReminder = sharedPreferences.getBool("firstReminder") ?? true;

    if(firstReminder ==  true){
      await CustomNotification().showNotificationForTODOChecklist();
    } else {
      await CustomNotification().cancelNotificationForTODO();
    }
  }

  void secondNotification() async {
    secondReminder = sharedPreferences.getBool("secondReminder") ?? true;

    if(secondReminder ==  true){
      await CustomNotification().showNotificationDaily();
    } else {
      await CustomNotification().cancelNotificationForMoodTracker();
    }
  }

  //Method for Showing or Hiding Password
  void _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 7,
              ),
              Container(
                width: size.width / 1.3,
                child: Text(
                  "Welcome",
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
                  "Sign In to continue!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 10,
              ),
              Form(
                key: _formKey,
                child: noOTP ? Column(
                  children: [
                    Container(
                      width: size.width / 1,
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
                          cursorColor: Colors.teal.shade300,
                          decoration: decoText.copyWith(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email, color: Colors.grey)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Container(
                        width: size.width / 1,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value.length > 5) {
                                return null;
                              } else {
                                return "Need at least 6 character";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            cursorColor: Colors.teal.shade300,
                            decoration: decoText.copyWith(
                                hintText: "Password",
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
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount(),));
                      },
                      child: Text(
                        "Don’t have an Account ? ",
                        style: TextStyle(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SendEmailResetPassword(),));
                      },
                      child: Text(
                        "Forgot your password ? ",
                        style: TextStyle(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ) : Column(
                  children: [
                    TextFormField(
                      onSaved: (newValue) {
                        _otp = newValue;
                      },
                      // onChanged: (value) async {
                      //
                      // },
                      cursorColor: Colors.teal.shade300,
                      decoration: decoText.copyWith(
                          hintText: "OTP SMS Code",
                          prefixIcon: Icon(Icons.email, color: Colors.grey)
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                      child: Text("Submit OTP"),
                      onPressed: () async {
                        _formKey.currentState.save();
                        if (_otp == this._phoneAuthCredential.smsCode) {
                          try {
                            this._phoneAuthCredential = PhoneAuthProvider.credential(verificationId: this.verificationId, smsCode: _otp);
                            // print(this._phoneAuthCredential.toString());
                            // print(this._authCredential);
                            await _auth.currentUser.linkWithCredential(this._phoneAuthCredential);
                            await _auth.signInWithCredential(this._phoneAuthCredential);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'provider-already-linked') {
                              await _auth.signInWithCredential(this._phoneAuthCredential);
                            }
                          }

                          await _firestore.collection('users').doc(_auth.currentUser.uid).update({
                            "status": "Online",
                          });

                          if (_account == "Patient") {
                            // _numOfLogins = value.data()["numOfLogins"];
                            if(_numOfLogins < 1){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstTime(),));
                            } else {
                              firstNotification();
                              secondNotification();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(sharedPreferences: sharedPreferences,),));
                            }
                          } else if (_account == "Counselor") {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoctorHomePage(),));
                          }

                        }
                      },
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

  //A custom widget
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

          await Methods().logIn(_email, _password).then((user) {
            if (!(user.emailVerified)) {
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
            } else {
              checkFirestore();
            }
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
          "Login",
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
