import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        "images/mangobee.png",
        fit: BoxFit.cover,
      ),
    ));
  }
}
