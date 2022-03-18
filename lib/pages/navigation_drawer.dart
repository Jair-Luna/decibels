import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/pages/home_page.dart';
import 'package:decibels/pages/library_page.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);
  static const String routeName = "/Inicio";

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        ///centerTitle: new Text('Decibels'),
        title: const Center(
          child: Text("DECIBELS"),
        ),
        backgroundColor: const Color.fromARGB(118, 31, 89, 128),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(118, 31, 89, 128),
              ),
              child: Image.asset('assets/decibels.png'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Perfil(userId, usersCollection),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_music),
              title: const Text('Biblioteca'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Biblioteca(userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.subscriptions),
              title: const Text('Suscripciones'),
              onTap: () {
                Navigator.of(context).pushNamed('/Subscriptions');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Configuracion(userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.plagiarism_rounded),
              title: const Text('Términos'),
              onTap: () {
                Navigator.of(context).pushNamed('/Terminos');
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.signOutAlt),
              title: const Text('Salir'),
              onTap: () async {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: HomePage(userId, usersCollection),
    );
  }
}
