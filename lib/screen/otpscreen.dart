

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_otpapp_tutorial/screen/phonenumber.dart';
import 'package:pinput/pinput.dart';

import '../home.dart';

class OTPverify extends StatefulWidget {
  final String verificationId;
  const OTPverify({Key? key, required this.verificationId}):super(key: key);

  @override
  State<OTPverify> createState() => _OTPverifyState();
}

class _OTPverifyState extends State<OTPverify> {
  TextEditingController otpcontroller=TextEditingController();

  void verifyotp() async{
    String otp =otpcontroller.text.trim();
    //this is for otp
    PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode:otp);
    //below code to find that this otp is valid or not
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
      if(userCredential.user!=null){
        Navigator.popUntil(context,(route)=>route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      }
    } on FirebaseAuthException catch(ex){
      log(ex.code.toString());
    }

  }


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    /*List otpTextStyles = [
      createStyle(accentPurpleColor),
      createStyle(accentYellowColor),
      createStyle(accentDarkGreenColor),
      createStyle(accentOrangeColor),
      createStyle(accentPinkColor),
      createStyle(accentPurpleColor),
    ];*/

    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.headline3?.copyWith(color: color);
    }



    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:Text("OTP Verification",style: TextStyle(color:Colors.black,
            fontSize: 25.0,fontWeight:FontWeight.bold ),),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>Phoneno(),));
        },
          icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,),
        ),
      ),
      body:Container(
        margin:EdgeInsets.only(left:25.0,right: 25.0),
        alignment: Alignment.center,
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img1.jpg',
                width: 170.0,height: 170.0,),
              SizedBox(height:25),
              Text("Verify Phone OTP",style: TextStyle(fontSize:24.0,
                  fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center,),
              SizedBox(height: 25.0,),
          Pinput(
            length: 6,
            showCursor: true,
          ),
            SizedBox(height: 25.0,),
           SizedBox(
                  height: 50.0,
                  width:double.infinity,
                  child:
                  ElevatedButton(onPressed:(){
                    verifyotp();
                    },
                    child: Text("Verify OTP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 20.0),),
                    style:ElevatedButton.styleFrom(primary:Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )),
                  )

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>Phoneno(),));
                  },
                      child: Text("Edit phone no....",style: TextStyle(fontSize:20.0,
                          fontWeight: FontWeight.bold,color: Colors.green.shade600),
                        textAlign: TextAlign.left,
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      ),

    );;
  }
}
