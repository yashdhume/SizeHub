import 'package:flutter/material.dart';
import 'package:size_hub/ui/Pages/ExplorePage.dart';
import 'package:size_hub/ui/Widgets/FirebaseTest.dart';
import 'package:size_hub/ui/Widgets/SplashPageWidgets/SplashPageLogo.dart';
import 'package:size_hub/ui/animations/BounceInAnimation.dart';
import 'package:size_hub/ui/animations/FadeInAnimation.dart';

class GroupedSplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: FadeInAnimation(
            child: Container(
              child: Text(
                'Welcome to',
                style: TextStyle(
                    fontFamily: 'SnowburstOne',
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SplashPageLogo(),
        Flexible(
            child: BounceInAnimation(
              child: SizedBox(
                  width: 250,
                  child: RaisedButton(
                    child: Text('Login'),
                    color: Colors.purple,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.purple)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExplorePage()),
                      );
                    },
                  )),
              delay: Duration(milliseconds: 2000),
            )),
        Flexible(
            child: BounceInAnimation(
              child: SizedBox(
                  width: 250,
                  child: FlatButton(
                    child: Text('Create Account'),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirebaseTest()),
                      );
                    },
                  )),
              delay: Duration(milliseconds: 2000),
            ))
      ],
    );
  }
}