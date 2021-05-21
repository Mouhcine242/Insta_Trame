import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


  bool switche = false ;
  ThemeData light = ThemeData(brightness: Brightness.light,);
  ThemeData dark = ThemeData(brightness: Brightness.dark,);
  String a = 'English';


class Settings extends StatefulWidget{
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(fontSize: 20.0),),
      ),
      body:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Dark or Light',style: TextStyle(fontSize: 20),),
              SizedBox(width: 10,),
              Switch(value: switche, onChanged:(bool value) {
                setState(() {
                  switche = value ;
                });
              })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Change Languge',style: TextStyle(fontSize: 20.0),),
              SizedBox(width: 10,),
              Container(
                child: DropdownButton(
                  iconSize: 30.0,
                  value: a,
                    onChanged: (String b){
                    setState(() {
                      a=b;
                    });
                    },
                    items:<String> ['English','Spanish'].map((e) => DropdownMenuItem(
                      value: e,
                        onTap: () {

                        },
                        child: Text(e))).toList(), ),
              ),
            ],
          )
        ],
      ),

    );
  }
}

class  ChangeThemeButum extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(value: themeProvider.isDarkmode,
        onChanged:(value) {
      final provider=  Provider.of<ThemeProvider>(context,listen: false);
      provider.togglTheme(value);

        });
  }

} class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.dark;
  bool get isDarkmode => _themeMode==ThemeMode.dark;
  void togglTheme(bool isOn){
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
