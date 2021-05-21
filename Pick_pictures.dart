import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_trame/Classes/AddImages.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase;

class Pick_pictures extends StatefulWidget{
  @override
  _Pick_picturesState createState() => _Pick_picturesState();
}

class _Pick_picturesState extends State<Pick_pictures> {

  bool uploading = false;
  double val = 0;
  CollectionReference imgRef ;
  firebase.Reference ref ;
  List<File> _image = [] ;
  File images;
  final imagePicker = ImagePicker();
  final picker  = ImagePicker();
  Future getImage() async{
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      images = File(image.path);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        centerTitle: true,
        actions: [
          FlatButton(onPressed: () {
            setState(() {
            uploading = true ;
          });
            uploadFile().whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddImages())));},
              child: Text('UPLOAD'))
        ],
      ),
      body:Stack(
        children: [
          GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: _image.length+1,
              itemBuilder: (context,index){
                return index == 0
                    ? Center(
                  child:  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      chooseImage();
                    },
                  ),
                )
                    :Container(margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_image[index-1]),
                        fit: BoxFit.cover,
                      )
                  ),);
              }
          ),
          uploading? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(child: CircularProgressIndicator(value: val,),),
              ],
            ),)
              :Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt_sharp),
        onPressed: (){
          getImage();
        },
      ),
    );
  }
  chooseImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if(pickedFile.path==null) retrLevel();
  }
  Future<void > retrLevel() async{
    final LostData  response = await picker.getLostData();
    if(response.isEmpty){
      return ;
    }
    if(response.file!= null ){
      setState(() {
        _image.add(File(response.file.path));
      });

    }else{
      print(response.file);
    }
  }
  Future uploadFile() async{
    int j =1 ;
    for(var i in _image){
      setState(() {
        val = j /_image.length ;
      });
      String p = Path.basename(i.path);
      ref = firebase.FirebaseStorage.instance
          .ref()
          .child('Images/$p');
      await ref.putFile(i).whenComplete(() async{
        await ref.getDownloadURL().then((value){
          imgRef.add({'url' : value});
          j++;
      });
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}