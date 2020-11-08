import 'package:alpha_gloo/models/user.dart';
import 'package:alpha_gloo/src/authenticate/authenticate.dart';
import 'package:alpha_gloo/src/home/gloo_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      return Authenticate();
    } else {
      return GlooHome();
    }
  }
}
