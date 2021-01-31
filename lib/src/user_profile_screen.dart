import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/src/components/gloo_back_arrow.dart';
import 'package:alpha_gloo/src/home/gloo_home.dart';
import 'package:alpha_gloo/src/views/details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => new _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return new Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GlooTheme.bgGradient),
      child: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipPath(
                      child: Container(color: GlooTheme.nearlyWhite),
                      clipper: getClipper(),
                    ),
                    Text(
                      'Raffaella Carrà',
                      style: TextStyle(
                        color: GlooTheme.nearlyWhite,
                        fontSize: 27.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                            color: GlooTheme.nearlyWhite,
                            image: DecorationImage(
                                image: AssetImage('assets/images/carra.jpg'),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7.0, color: GlooTheme.nearlyWhite)
                            ])),
                    DetailsView(entries: {
                      "Bio": "Com'è bello far l'amore da Trieste in Gloo",
                      "E-mail": "raffaella@carra.it",
                      "Università": "Università degli studi di Salerno",
                    }),
                    MaterialButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.pushNamed(context, '/');
                      },
                      color: GlooTheme.purple,
                      textColor: GlooTheme.nearlyWhite,
                      child: Icon(
                        Icons.logout,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
            ),
          ),
         GlooBackArrow(),
        ],
      ),
    ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, 0.0 / 1.9);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
