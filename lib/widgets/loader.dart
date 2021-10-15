import 'package:flutter/material.dart';


class Loader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                "assets/images/logo.png",
                height: 170,
                width: 170,
              ),
            ),
            SizedBox(height: 20),
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
