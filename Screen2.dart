import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_trame/Classes/Map.dart';
import 'package:insta_trame/Classes/Pick_pictures.dart';
import 'package:insta_trame/main.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'Settings.dart';



class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();

}

class _Screen2State extends State<Screen2> {

  Future getData() async{
    var url = Uri.parse('https://api.jsonbin.io/b/608ae548f41a6a12bbf13eec');
    var response = await http.get(url);

    var data = jsonDecode(response.body);

    List<Station>  sts = [];
    for(var s in data["data"]["tram"]) {
        Station st = Station(s["name"],s["type"],s["id"]);
        sts.add(st);
      }
    return sts ;
    }
    List<String> names = ['Fontsanta i Fatjó','Bon Viatge','Les Aigües','Cornellà Centre','Ignasi Iglésias','La Fontsanta',
    'Centre Miquel Martí i Pol','El Pedró','Llevant-Les Planes','Montesa','Hospital Sant Joan Despí | TV3','La Sardana',
    'Pont dEsplugues','Can Clota','Sant Feliu | Consell Comarcal','Torreblanca','Walden','Rambla de Sant Just','Can nOliveres',
    'Can Rigal','Ernest Lluch','Avinguda de Xile','Zona Universitària','Palau Reial','Pius XII','Maria Cristina','Numància',
    'LIlla','Francesc Macià','Marina','Auditori | Teatre Nacional','Ciutadella | Vila Olímpica','Wellington','Glòries',
    'La Farinera','Ca lAranyó','Can Jaumandreu','Pere IV','Fluvià','Espronceda','Selva de Mar','Sant Martí de Provençals',
    'El Maresme','Fòrum','Alfons el Magnànim','Can Llima','La Mina','Besòs','Parc del Besòs','Central Tèrmica del Besòs',
    'La Catalana','Sant Joan Baptista','Estació de Sant Adrià','Encants de Sant Adrià','Sant Roc','Gorg'];




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
        actions: [
          PopupMenuButton <int>(
            onSelected: (item) => onSelected(context,item),
              itemBuilder: (context)=> [
                PopupMenuItem(
                  value: 0,
                    child: Text('Home')),
                PopupMenuItem(
                  value: 1,
                    child:Text('Map') ),
                PopupMenuItem(
                  child: Text('settings'),
                    value: 2)
              ])
        ],

      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(onPressed: () {},
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)
                ),
                child: Text('Home',style: TextStyle(fontSize: 20.0),),),
                RaisedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Map()));
                },
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)
                ),
                child: Text('Map',style: TextStyle(fontSize: 20.0),),)
              ],
            )
          ),
          Text('Stations :',style: TextStyle(fontSize: 30.0,fontFamily: 'DancingScript'),),

          Expanded(

            child: ListView.builder(
              itemCount: names.length,
                itemBuilder: (context,index){
                return RaisedButton(
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text(names[index],style: TextStyle(fontSize: 30 ,fontFamily: 'DancingScript',color: Colors.black),),
                    onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Pick_pictures()));
                    });
            }) ,
          )
        ],
      ),
    );
  }
}

void onSelected(BuildContext context , int item){
  switch(item){
    case 0:
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>Accueil()),
      );
      break;
    case 1:
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> Map())
      );
      break;
    case 2:
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>Settings())
      );
  }
}

class Station{
  String name;
  String type ;
  int id ;
  Station(this.name,this.type,this.id);
   final String apikey = 'AIzaSyAc2bECWGiXtx_aT_s9chKlmmNr-D3NJjA';

}


