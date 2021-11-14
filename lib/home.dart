import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp_auth_flutter/otpscreen.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.pink[600], borderRadius: BorderRadius.circular(54)),
        height: 500,
        width: 500,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              "Hello! Champion",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: TextField(
                  controller: phonecontroller,
                  decoration: InputDecoration(
                    prefix: Text("+91",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: getOtp,
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.yellow[700],
                    padding:
                        EdgeInsets.symmetric(horizontal: 155, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 20,
                    ))),
            SizedBox(height: 15),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot password ?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  getOtp() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91${phonecontroller.text}",
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) {
          setState(() {});
          print(verificationFailed);
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            this.verificationID = verificationID;
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OtpScreen()));
        },
        codeAutoRetrievalTimeout: (verificationID) async {});
    // Navigator.of(context)
    //.push(MaterialPageRoute(builder: (context) => OtpScreen()));
  }
}
