import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonIcon extends StatelessWidget {
  final String text;
  final Function onTap;
  final IconData icon;
  final double marginHorizontal;
  final double textSize;
  final bool loading;

  ButtonIcon({
    @required this.text,
    @required this.onTap,
    this.icon,
    this.marginHorizontal,
    this.textSize,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: marginHorizontal ?? 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(6),
        color: Constants.kSecondary,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          splashColor: Colors.black12,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Icon(
                        icon,
                        color: Colors.white,
                      )
                    : Container(),
                SizedBox(
                  width: icon == null ? 0 : 20,
                ),
                !loading
                    ? Text(
                        text,
                        style: TextStyle(
                          fontSize: textSize ?? 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Center(
                        child: SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
