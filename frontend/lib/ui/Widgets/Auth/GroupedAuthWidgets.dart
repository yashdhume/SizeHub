import 'package:flutter/material.dart';
import 'package:size_hub/api/ApiClient.dart';
import 'package:size_hub/model/AuthenticationService.dart';
import 'package:size_hub/ui/MainLayout/MainLayout.dart';
import 'package:size_hub/ui/Widgets/Auth/BackgroundPainter.dart';
import 'package:size_hub/ui/Widgets/Auth/LoginCard.dart';
import 'package:size_hub/ui/Widgets/Common/PurpleRaisedButton.dart';
import 'package:size_hub/ui/animations/BounceInAnimation.dart';
import 'package:provider/provider.dart';
import 'SignUpCard.dart';

class GroupedAuthWidgets extends StatefulWidget {
  GroupedAuthWidgets({Key key, this.isRegister}) : super(key: key);
  final bool isRegister;

  @override
  _GroupedAuthWidgetsState createState() => _GroupedAuthWidgetsState();
}

class _GroupedAuthWidgetsState extends State<GroupedAuthWidgets>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isRegister;
  PageController _pageViewController;
  Curve _curve = Curves.bounceIn;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    if (widget.isRegister) {
      _isRegister = true;
      _pageViewController = PageController(initialPage: 1);
      _controller.forward(from: 0);
    } else {
      _isRegister = false;
      _pageViewController = PageController(initialPage: 0);
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _pageViewController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox.expand(
        child: CustomPaint(
          painter: BackgroundPainter(
              animation: _controller.view,
              firstColor: Colors.purple,
              secondColor: Colors.deepPurple),
        ),
      ),
      AnimatedContainer(
          transform: Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width/15, _isRegister ? 100 : MediaQuery.of(context).size.height/4),
          ).transform,
          duration: Duration(milliseconds: 250),
          child: Text(
            _isRegister ? "Sign up" : 'Welcome\n back',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
            textScaleFactor: 2,
          )),
      Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Flexible(
                child: PageView(
                  physics: new NeverScrollableScrollPhysics(),
                  controller: _pageViewController,
                  children: [_buildLogin(), _buildSignUp()],
                ),
              ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left:20),
                child: BounceInAnimation(
                  child: PurpleRaisedButton(
                    child: Text(!_isRegister ? "Login" : "Create Account"),
                    onPressed: () {
                      if (_isRegister)
                        context
                            .read<AuthenticationService>()
                            .signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )
                            .then((value) {
                              ApiClient().createUser(_emailController.text, _usernameController.text);
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(value)));
                          if (value == 'Signed up') {
                            setState(() {
                              _isRegister = false;
                              _pageViewController.animateToPage(0,
                                  duration: Duration(milliseconds: 200),
                                  curve: _curve);
                              _controller.reverse();
                            });
                          }
                        });
                      else
                        context
                            .read<AuthenticationService>()
                            .signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )
                            .then((value) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(value)));
                          if (value == 'Signed in') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainLayout()),
                            );
                          }
                        });
                    },
                  ),
                  delay: Duration(milliseconds: 200),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: BounceInAnimation(
                  child: FlatButton(
                    child: Text(
                        _isRegister ? "Already Have an account" : "Create Account"),
                    textColor: _isRegister ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      setState(() {
                        _isRegister = !_isRegister;
                        if (!_isRegister) {
                          _controller.reverse();
                          _pageViewController.animateToPage(0,
                              duration: Duration(milliseconds: 200), curve: _curve);
                        } else {
                          _controller.forward(from: 0);
                          _pageViewController.animateToPage(1,
                              duration: Duration(milliseconds: 200), curve: _curve);
                        }
                      });
                    },
                  ),
                  delay: Duration(milliseconds: 300),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Center _buildLogin() {
    return Center(
      child: LoginCard(
        emailController: _emailController,
        passwordController: _passwordController,
      ),
    );
  }

  Center _buildSignUp() {
    return Center(
      child: SignUpCard(
        emailController: _emailController,
        passwordController: _passwordController,
        nameController: _usernameController,
      ),
    );
  }
}
