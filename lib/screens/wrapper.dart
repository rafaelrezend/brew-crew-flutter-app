import 'package:first_flutter_app/home/home.dart';
import 'package:first_flutter_app/models/user.dart';
import 'package:first_flutter_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
