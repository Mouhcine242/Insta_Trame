import 'package:cloud_firestore/cloud_firestore.dart';
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
              :Container( padding: EdgeInsets.all(3),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.all(3.0),
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: snapshot.data.docs[index].get('url'),
                    fit: BoxFit.cover,),
                  );
                }),

          );
        },
      ),
    );


  }
}