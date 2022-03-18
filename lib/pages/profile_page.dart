import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  final String userId;
  final CollectionReference usersCollection;
  Perfil(this.userId, this.usersCollection, {Key? key}) : super(key: key);

  static const String routeName = "/Perfil";
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: usersCollection.doc(userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text("Perfil"),
              ),
              backgroundColor: const Color.fromARGB(118, 31, 89, 128),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 190,
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/fondo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      UserFoto(
                        assetImage: data['photourl'],
                        size: 110,
                      ),
                      Text(
                        data['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      Text(
                        data['email'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const ConeccionGeneral(
                  suscripciones: 20,
                  siguiendo: 15,
                ),
                Descripcion(
                  text: 'Teléfono: ${data['phone']}',
                ),
                const Padding(
                  padding: EdgeInsets.all(50),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: botonajuste(userId),
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class botonajuste extends StatelessWidget {
  final String userId;
  const botonajuste(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      foregroundColor: Colors.white,

      onPressed: () {
        // Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Configuracion(userId),
          ),
        );
      },
      label: const Text(
        'Ajustes',
        style: TextStyle(color: Colors.white),
      ),
      icon: const Icon(Icons.edit),
      elevation: 10,
    );
  }
}

class Descripcion extends StatelessWidget {
  final String text;
  Descripcion({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(this.text),
    );
  }
}

class ConeccionGeneral extends StatelessWidget {
  final int suscripciones, siguiendo;
  const ConeccionGeneral({
    Key? key,
    required this.suscripciones,
    required this.siguiendo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(118, 31, 89, 128),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          conecciones(
            text: 'suscripciones',
            numero: this.suscripciones,
          ),
          conecciones(text: "Siguiendo", numero: this.siguiendo),
        ],
      ),
    );
  }
}

class conecciones extends StatelessWidget {
  final String text;
  final int numero;
  const conecciones({
    Key? key,
    required this.text,
    required this.numero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Color.fromARGB(150, 0, 0, 0),
    );
    return Column(
      children: <Widget>[
        Text(
          this.text.toUpperCase(),
          style: style,
        ),
        Text(
          '${this.numero}',
          style: style,
        ),
      ],
    );
  }
}

class UserFoto extends StatelessWidget {
  final String assetImage;
  final double size;
  const UserFoto({
    Key? key,
    required this.assetImage,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(this.assetImage), fit: BoxFit.cover),
        shape: BoxShape.circle,
        border: Border.all(color: Color.fromARGB(255, 54, 127, 187), width: 4),
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
