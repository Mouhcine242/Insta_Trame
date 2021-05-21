// ignore: avoid_web_libraries_in_flutter
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_trame/Classes/Screen2.dart ';
import 'package:insta_trame/Classes/Settings.dart' as st ;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Accueil(),
    theme: st.switche? st.dark : st.light,
  ));
}

class Accueil extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insta-Trame',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'DancingScript',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Center(
          child: Text('Welcome To Barcelona',style: TextStyle(fontFamily: 'DancingScript',color: Colors.black,fontSize: 100.0),),
        ),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcom3.jpg'),
            fit: BoxFit.cover,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return Screen2();
          }));
        },
        child: Text(
          'GO',
          style: TextStyle(fontFamily: 'DancingScript'),
        ),
        backgroundColor: Colors.black54,
      ),
    );
  }

}

