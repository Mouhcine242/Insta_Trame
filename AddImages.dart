import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';


class AddImages extends StatefulWidget{
  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
        builder: (context,snapshot){
          return !snapshot.hasData
              ?Center(
            child: CircularProgressIndicator(),
          )
              :ListView.builder(
            itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
              return GestureDetector(
                child: Card(
                  elevation: 5.0,
                  shadowColor: Colors.black54,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 120,
                        width: 100,
                        child:FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.data.docs[index].get('url'),)
                      ),
                      Padding(padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: 100,
                            child: TextField(
                              obscureText: false,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'DancingScript',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Set Titel',
                                hintStyle: TextStyle(fontSize: 20)

                              ),
                            ),
                          ),
                          SizedBox(height: 50,)
                        ],
                      ),),
                      Spacer(),
                      IconButton(icon: Icon(Icons.delete),
                          color: Colors.grey,
                          onPressed:() {
                        deletData(snapshot.data.docs[index].id);
                          } ),
                    ],
                  ),
                ),
              );

              });
        },
      ),
    );


  }
  void deletData(docId){
    FirebaseFirestore.instance.collection('imageURLs').doc(docId).delete().catchError((e){
      print(e);
    });
  }

}
