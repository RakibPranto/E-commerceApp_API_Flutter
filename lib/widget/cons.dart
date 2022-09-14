import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String baseUrl = 'https://apihomechef.antopolis.xyz/';
showtoast(String title) {
  return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}
