import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_app/models/user.dart';
import 'package:first_flutter_app/screens/wrapper.dart';
import 'package:first_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ),
    );
  }
}
