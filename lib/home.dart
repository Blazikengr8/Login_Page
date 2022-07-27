import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'auth.dart';
import 'login.dart';

class HomePage extends StatefulWidget{
  User user;
  HomePage(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  LoginStatus current=LoginStatus.start;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child:current==LoginStatus.start? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.user.email),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    current=LoginStatus.loading;
                  });
                  var res=await AuthProvider().logOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child: Text('Log Out')),
          ],
        ):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}