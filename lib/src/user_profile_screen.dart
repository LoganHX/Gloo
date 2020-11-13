import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/src/home/gloo_home.dart';
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
      backgroundColor: GlooTheme.purple.withOpacity(0.8),
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: GlooTheme.nearlyPurple),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: GlooTheme.nearlyPurple,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/elon.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 90.0),
                    Text(
                      'Elon Musk',
                      style: TextStyle(
                          color: GlooTheme.nearlyPurple,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Wow, Gloo is fantastic',
                      style: TextStyle(
                          color: GlooTheme.nearlyPurple,
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          ),
                    ),
                    SizedBox(height: 25.0),
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          //shadowColor: GlooTheme.grey,
                          color: GlooTheme.grey,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'Edit Name',
                                style: TextStyle(color: GlooTheme.nearlyPurple),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 25.0),
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          //shadowColor: GlooTheme.nearlyPurple,
                          color: GlooTheme.nearlyPurple,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () async {
                              await _auth.signOut();
                              Navigator.pushNamed(context, '/'); //todo da fare meglio, dubito si faccia così

                            },
                            child: Center(
                              child: Text(
                                'Log out',
                                style: TextStyle(color: GlooTheme.purple),
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
            Padding(
              //App bar da mettere anche nella pagina seguente
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios, //ios
                      color: GlooTheme.grey,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}