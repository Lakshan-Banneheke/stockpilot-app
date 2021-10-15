import 'package:flutter/material.dart';

abstract class Constants{
  static final String baseURL = "http://stockpilot-backend-716829868.us-east-2.elb.amazonaws.com/";
  static final String loginUrl = baseURL + "user/login";

  //Colours
  static final Color kHintText = Color(0xFF8E8E8E);
  static final Color kSecondary = Color(0xFFE43066);
  static final Color kDarkPrimary = Color(0xFF006AFF);
  static final Color kPrimary = Color(0xFF00AEFF);
}