import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockpilot_app/widgets/button_icon.dart';

import '../../constants.dart';
import 'bloc/login_user_bloc.dart';
import 'bloc/login_user_event.dart';
import 'bloc/login_user_state.dart';

class UserLoginPage extends StatelessWidget {
  final _StyleSheet stylesheet = _StyleSheet();
  final FocusNode focusEmail = new FocusNode();
  final FocusNode focusPassword = new FocusNode();
  final _formKey = GlobalKey<FormState>();
  final auth = {"email": "", "password": ""};

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final loginUserBloc = BlocProvider.of<LoginUserBloc>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: Container(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logoText(context),
                    emailInput(context),
                    passwordInput(context, loginUserBloc),
                    BlocBuilder<LoginUserBloc, LoginUserState>(
                      buildWhen: (previous, current) => previous.loginFailed != current.loginFailed,
                      builder: (context, state) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                          height: state.loginFailed ? 20 : 0,
                          child: Text(
                            'Username or Password is Incorrect.',
                            style: stylesheet._errorText,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),

                    BlocBuilder<LoginUserBloc, LoginUserState>(
                      buildWhen: (previous, current) => previous.loading != current.loading,
                      builder: (context, state) {
                        return AnimatedCrossFade(
                          duration: Duration(milliseconds: 500),
                          firstCurve: Curves.ease,
                          secondCurve: Curves.ease,
                          firstChild: ButtonIcon(
                            text: 'Log In',
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                loginUserBloc.add(LoginEvent(auth));
                              }
                            },
                          ),
                          secondChild: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          crossFadeState: state.loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/card2.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(''),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color:  Constants.kPrimary, width: 1.5), color: Colors.white),
      child: TextFormField(
        maxLines: 1,
        focusNode: focusEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          isDense: true,
          icon: Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Icon(FontAwesomeIcons.solidUserCircle),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: InputBorder.none,
          hintText: "Email",
          hintStyle: stylesheet._hintText,
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => auth['email'] = value.trim(),
        onFieldSubmitted: (value) {
          focusEmail.unfocus();
          FocusScope.of(context).requestFocus(focusPassword);
        },
      ),
    );
  }

  Widget passwordInput(BuildContext context, LoginUserBloc bloc) {
    return BlocBuilder<LoginUserBloc, LoginUserState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 12, bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: Constants.kPrimary, width: 1.5), color: Colors.white),
          child: TextFormField(
            maxLines: 1,
            focusNode: focusPassword,
            textInputAction: TextInputAction.done,
            obscureText: !state.showPass,
            decoration: InputDecoration(
              isDense: true,
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(FontAwesomeIcons.lock),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintText: "Password",
              hintStyle: stylesheet._hintText,
              suffixIcon: GestureDetector(
                onTap: () => bloc.add(TogglePassEvent()),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 2, right: 4),
                  child: Icon(
                    state.showPass ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                  ),
                ),
              ),
              suffixIconConstraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
            ),
            validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
            onSaved: (value) => auth['password'] = value.trim(),
            onFieldSubmitted: (value) {
              focusEmail.unfocus();
            },
          ),
        );
      },
    );
  }


  Widget logoText(context) {
    return Column(
      children: [
        Hero(
          tag: 'logo',
          child: Container(
            margin: EdgeInsets.only(top: 80, bottom: 5),
            width: MediaQuery.of(context).size.width/1.5,
            height: MediaQuery.of(context).size.height/20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
            ),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ],
    );
  }
}

class _StyleSheet {
  final TextStyle _hintText = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Constants.kHintText);
  final TextStyle _errorText = GoogleFonts.fredokaOne(
    textStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.red,
    ),
  );
}
