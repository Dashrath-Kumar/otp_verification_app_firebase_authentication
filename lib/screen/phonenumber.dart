import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'otpscreen.dart';

class Phoneno extends StatefulWidget {
  const Phoneno({super.key});

  @override
  State<Phoneno> createState() => _PhonenoState();
}

class _PhonenoState extends State<Phoneno> {
  TextEditingController phonecontroller=TextEditingController();

  void sendOtp () async{
    String phone="+91"+phonecontroller.text.toString();

    await  FirebaseAuth.instance.verifyPhoneNumber(
      //phone no for phone verification
      //codesent fired when otp sent for code verification
      //verificationId is related to id
      phoneNumber: phone,codeSent:(verificationId,resendToken){
      //to go otp page
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>OTPverify(
            //require verification id so provided so otp screen got some data
            verificationId: verificationId,
          ),));
    },
      //afetr verificationcredentila get
      verificationCompleted:(credential){},
      //if failed get error
      verificationFailed: (ex){
        log(ex.code.toString());
      },
      //autoretrival try to match automatic afetr that is goes to time out
      codeAutoRetrievalTimeout: (verificationId){},
      timeout: Duration(seconds: 30),

    );
  }


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Phone Number Verification",style: TextStyle(color:Colors.white,
            fontSize: 25.0,fontWeight:FontWeight.bold ),),
            elevation: 2.5,
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
      //),
      //bottomNavigationBar: BottomNavigationBar(
       // items: [
        //],
     //backgroundColor:Colors.lightGreen,
         // elevation: 2.5,
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
              Text("Phone Verification",style: TextStyle(fontSize:24.0,
                  fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center,),
              Text("We need to register your phone no before started!",
                style: TextStyle(fontSize:20.0,fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,),
              SizedBox(height: 25.0,),

              Container(
                height: 55.0,
                decoration: BoxDecoration(
                    border:Border.all(width: 1.50,color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                child: Row(
                  children: [
                    SizedBox(width: 10.0,),
                    SizedBox(
                      width: 40.0,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(border:InputBorder.none,hintText:"+91",),
                      ),
                    ),
                    SizedBox(width:10.0,),
                    Text("|",style: TextStyle(fontSize: 35.0,color:Colors.grey,)),
                    Expanded(
                      child:TextField(
                        controller: phonecontroller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(border:InputBorder.none,hintText: "Phone Number"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25.0,),

              SizedBox(
                height: 50.0,
                  width:double.infinity,
                  child:ElevatedButton(onPressed:()async{
                    sendOtp();
                    },
                    child: Text("Get OTP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                    fontSize: 20.0),),
                    style:ElevatedButton.styleFrom(primary:Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    )),
                  )

              )
            ],
          ),
        ),
      ),

    );
  }
}
