import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_drinking_reminder/screen/auth/OnBoardingScreen.dart';
import 'package:water_drinking_reminder/screen/otpshort/Screens/Widgets/textfield.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool canShow = false;
  var temp;

  @override
  void dispose() {
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";
  void loginWithPhone() async {
    print(phoneNumber.toString());
    auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber.text.toString(),
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((phonecon) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int resendToken) {
        otpVisibility = true;
        verificationID = verificationId;

        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp.text);

      await auth.signInWithCredential(credential).then(
        (value) {
          print("You are logged in successfully");
        },
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextField("Phone Number", phoneNumber, Icons.phone, context),
            canShow
                ? buildTextField("OTP", otp, Icons.timer, context)
                : const SizedBox(),
            !canShow ? buildSendOTPBtn("Send OTP") : buildSubmitBtn("Submit"),
          ],
        ),
      ),
    );
  }

  Widget buildSendOTPBtn(String text) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue)),
        onPressed: () async {
          setState(() {
            canShow = !canShow;
          });
          loginWithPhone();
        },
        child: Text(text),
      );

  Widget buildSubmitBtn(String text) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue)),
        // style: ButtonStyle(
        //   backgroundColor: Colors.blue.shade100
        // ),
        onPressed: () {
          verifyOTP();
          // FirebaseAuthentication().authenticateMe(temp, otp.text);
        },
        child: Text(text),
      );
}
