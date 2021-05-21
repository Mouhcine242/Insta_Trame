
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insta_trame/Classes/Pick_pictures.dart';


class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
      ),
      body: Stack(
        children:<Widget> [
          _googlMap(context)
        ],
      ),
    );


  }
}

Widget _googlMap(BuildContext context){
  Completer<GoogleMapController> ctl = Completer();
  List<String> names = ['Fontsanta i Fatjó','Bon Viatge','Les Aigües','Cornellà Centre','Ignasi Iglésias','La Fontsanta',
    'Centre Miquel Martí i Pol','El Pedró','Llevant-Les Planes','Montesa','Hospital Sant Joan Despí | TV3','La Sardana',
    'Pont dEsplugues','Can Clota','Sant Feliu | Consell Comarcal','Torreblanca','Walden','Rambla de Sant Just','Can nOliveres',
    'Can Rigal','Ernest Lluch','Avinguda de Xile','Zona Universitària','Palau Reial','Pius XII','Maria Cristina','Numància',
    'LIlla','Francesc Macià','Marina','Auditori | Teatre Nacional','Ciutadella | Vila Olímpica','Wellington','Glòries',
    'La Farinera','Ca lAranyó','Can Jaumandreu','Pere IV','Fluvià','Espronceda','Selva de Mar','Sant Martí de Provençals',
    'El Maresme','Fòrum','Alfons el Magnànim','Can Llima','La Mina','Besòs','Parc del Besòs','Central Tèrmica del Besòs',
    'La Catalana','Sant Joan Baptista','Estació de Sant Adrià','Encants de Sant Adrià','Sant Roc','Gorg'];
  List<double> lat = [41.3602701633887,41.3646427714853,41.3567799975011,41.3573169129495,41.3613569139958,41.3679007086999,
    41.3687284566583,41.3654342916373,41.371016220546,41.3696139040304,41.3723391899373,41.3727247041924,41.3767926012985,
    41.3769753769181,41.3795850237938,41.3797845985049,41.3797331039552,41.3788403536607,41.3766500553622,41.3761025293673,
    41.3767026998859,41.3806754902035,41.3842044554882,41.3859950478969,41.3867212978738,41.3879646699666, 41.3893437380252,
    41.3905049686833,41.3921819382415,41.3939821425228, 41.3974678467679,41.3875861222237,41.3902522809999,41.4016956114457,
    41.4037827695728,41.404422411394,41.4077813674524,41.4061358906449,41.4078078590492,41.4114396191256, 41.4091992878307,
    41.4153361658307,41.4105620185959,41.4119528755077, 41.417295577421,41.4153247598517,41.418651111406,41.4200509841933, 41.4193521921015,
    41.4189761548633,41.4226073186697,41.4274859983148, 41.424092262059,41.4304584678793,41.4349739717875,41.4392645004098 ];
  List<double> lon = [2.06231782329774,2.05883027285289,2.06600611840813,2.06967312836759,2.07276892190294,2.063082294656,
    2.07132883760428,2.07676925416326,2.07616093808326,2.08086981278302,2.07580611668373,2.08392213029834,2.08850907950424,
    2.09367193246044,2.05268675136945,2.06069211974912, 2.06704907259576,2.07522510789372,2.09828528935288,2.10609197002068,
    2.11084261591932,2.11479729860436,2.11449065372833,2.11861755590232,2.12148246924578,2.12638568304569,2.1318359632411,2.13640433318727,
    2.1429899578455,2.18687783955788,2.18689347916676, 2.19202375520085,2.18849876956405, 2.18691287534046,  2.18832202776882,
    2.19129145611927, 2.19313333596197,2.19812707436525, 2.20479899638345,2.19795940120491,2.21035287119043, 2.20324268873208,
    2.21579346234101,2.21994703731682,2.21347520456112,  2.22298996859334 , 2.22274993877984,2.20946506199739, 2.21751032970247,
    2.22624782117548,2.2218633113181,2.22530887632893, 2.23065496122408, 2.22290444983689,2.22778764587606,2.23264400671318 ];
  List<Marker> allMarkers = [];
  var s =0;
  while(s<names.length){
    allMarkers.add(Marker(markerId: MarkerId(names[s]),
        position: LatLng(lat[s], lon[s]),
        infoWindow: InfoWindow(title: names[s]),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Pick_pictures()));
        }));
    s++;
  }
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.height,
    child: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(41.3851,2.1734)// Lat and lng of Barcelona
      ),
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller){
        ctl.complete(controller);
      },
      markers: Set.from(allMarkers),
    ),
  );
}