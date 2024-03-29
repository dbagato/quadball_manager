import 'package:flutter/material.dart';
import 'package:quadball_manager/services/firebase_provider.dart';
import 'package:quadball_manager/widgets/widgets.dart';

class UsersScreen extends StatelessWidget {
  FirebaseProvider firebaseProvider = FirebaseProvider();
  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: listView(),
      ),
    );
  }

  Widget listView() {
    return FutureBuilder(
        // A esta propiedad le damos el future
        future: firebaseProvider.getAllUserLoc(),
        // A esta propiedad le damos los datos iniciales mientras carga el Future
        initialData: const [],
        // Esta propiedad lo explicamos debajo
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: listaUsersLoc(snapshot.data),
          );
        });
  }

  List<Widget> listaUsersLoc(List<dynamic>? data) {
    final List<Widget> users = [];

    data?.forEach((element) {
      final widgetTemp = UsersScreenView(userLoc: element);
      users.add(widgetTemp);
    });
    return users;
  }
}
