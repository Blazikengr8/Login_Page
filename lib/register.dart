import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_page/login.dart';
import 'package:login_page/validator.dart';

import 'auth.dart';
import 'home.dart';

class RegisterPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }

}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var username;
  var password;
  var confirm_password;
  LoginStatus current = LoginStatus.start;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF2F3F5),
      body: current==LoginStatus.start? Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Register',style: GoogleFonts.plusJakartaSans(fontSize: 36),),
              SizedBox(
                height: height*0.02,
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: width*0.75,
                  height: height*0.58,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email:',style: GoogleFonts.plusJakartaSans(fontSize: 16),),
                      SizedBox(height: height*0.01,),
                      Stack(
                        children: [
                          Container(
                            height: height*0.07,
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextFormField(
                              style: GoogleFonts.plusJakartaSans(fontSize: 16,),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val)
                              {
                                if (!val.isValidEmail) {
                                  return 'Enter valid email';
                                }
                              },
                              onChanged: (value){
                                username=value;
                                _formKey.currentState.validate();
                              },
                              decoration:  InputDecoration(
                                hintStyle: GoogleFonts.plusJakartaSans(),
                                hintText: 'Enter your email',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Text('Password:',style: GoogleFonts.plusJakartaSans(fontSize: 16),),
                      SizedBox(height: height*0.01,),
                      Stack(
                        children: [
                          Container(
                            height: height*0.07,
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          TextFormField(
                            style: GoogleFonts.plusJakartaSans(fontSize: 16,),
                            obscureText: true,
                            validator: (val)
                            {
                              if (!val.isValidPassword) {
                                return 'Enter valid password';
                              }
                            },
                            onChanged: (value){
                              password=value;
                              _formKey.currentState.validate();
                            },
                            decoration:  InputDecoration(
                              hintStyle: GoogleFonts.plusJakartaSans(),
                              hintText: 'Enter a password',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Text('Confirm Password:',style: GoogleFonts.plusJakartaSans(fontSize: 16),),
                      SizedBox(height: height*0.01,),
                      Container(
                        height: height*0.07,
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextFormField(
                          style: GoogleFonts.plusJakartaSans(fontSize: 16,),
                          obscureText: true,
                          validator: (val)
                          {
                            if (!val.isValidPassword && val!=password) {
                              return 'Enter valid password';
                            }
                          },
                          onChanged: (value){
                            confirm_password=value;
                            _formKey.currentState.validate();
                          },
                          decoration:  InputDecoration(
                            hintStyle: GoogleFonts.plusJakartaSans(),
                            hintText: 'Re-enter password',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      GestureDetector(

                        onTap: () async{
                          if(_formKey.currentState.validate()) {
                            setState(() {
                              current = LoginStatus.loading;
                            });
                            print(username + ' ' + password);
                            var res = await AuthProvider().register(
                                username, password);
                            if (res != null) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => HomePage(res)));
                            }
                            else
                              {
                                setState(() {
                                  current = LoginStatus.start;
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Error in Logging In!'),
                                  ));
                                });
                              }
                          }
                        },
                        child: Container(
                          height: height*0.07,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                          child: Center(
                            child: Text('Register',style: GoogleFonts.plusJakartaSans(fontSize: 24,color: Colors.white),),
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Go back to ',style: GoogleFonts.plusJakartaSans(color: Colors.grey),),
                          InkWell(child: Text('Login.',style: GoogleFonts.plusJakartaSans(color: Colors.black),),onTap: ()=>Navigator.pop(context),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator(),),
    );
  }
}