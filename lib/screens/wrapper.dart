import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/authenticate/auth.dart';
import 'package:brewcrew/screens/authenticate/sign_in.dart';
import 'package:brewcrew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //home or authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
