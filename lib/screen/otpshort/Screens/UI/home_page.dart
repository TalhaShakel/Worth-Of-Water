
// import 'package:flutter/material.dart';
// import '../../Firebase/firebase_auth.dart';
// import '../Widgets/textfield.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController otp = TextEditingController();
//   bool canShow = false;
//   var temp;

//   @override
//   void dispose() {
//     phoneNumber.dispose();
//     otp.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Firebase Phone Auth"),
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             buildTextField("PhNo", phoneNumber, Icons.phone, context),
//             canShow
//                 ? buildTextField("OTP", otp, Icons.timer, context)
//                 : const SizedBox(),
//             !canShow ? buildSendOTPBtn("Send OTP") : buildSubmitBtn("Submit"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildSendOTPBtn(String text) => ElevatedButton(
//         onPressed: () async {
//           setState(() {
//             canShow = !canShow;
//           });
//           temp = await FirebaseAuthentication().sendOTP(phoneNumber.text);
//         },
//         child: Text(text),
//       );

//   Widget buildSubmitBtn(String text) => ElevatedButton(
//         onPressed: () {
//           FirebaseAuthentication().authenticateMe(temp, otp.text);
//         },
//         child: Text(text),
//       );
// }
