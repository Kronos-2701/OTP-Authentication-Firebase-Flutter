import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth_flutter/detailsScreen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();

  get verificationID => null;

  get _auth => null;

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
              "Enter OTP",
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
                  controller: otpcontroller,
                  decoration: InputDecoration(
                    labelText: "Enter OTP",
                    labelStyle: TextStyle(fontSize: 19),
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
                onPressed: () {
                  AuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationID,
                          smsCode: otpcontroller.text);
                  signin(phoneAuthCredential);
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.yellow[700],
                    padding:
                        EdgeInsets.symmetric(horizontal: 152, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 20,
                    ))),
            SizedBox(height: 19),
            Text(
              "Haven't recieved OTP?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Resend",
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

  void signin(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => basicDetails()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }
}
