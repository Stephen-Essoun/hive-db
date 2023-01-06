import 'package:flutter/material.dart';
import 'package:hive_db/module/contact.dart';
import 'package:hive_db/ui/contact_ui.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<Contacts>('contactsBox');
    Hive.registerAdapter(ContactsAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const ContactsView(),
    );
  }
}
