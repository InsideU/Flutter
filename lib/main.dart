import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:core';
import 'package:audio_recorder/audio_recorder.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
File image;
File Video;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void sound() async{
    bool isRecording=await AudioRecorder.isRecording;
    await AudioRecorder.start(path:null, audioOutputFormat: AudioOutputFormat.AAC);
    Recording recording = await AudioRecorder.stop();
    print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
  }


  void navigate(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>cache())
    );
  }
  void click() async{
    print("Camera is being called");
    File img= await ImagePicker.pickImage(source:ImageSource.camera);
    image=img;
  }

  void videorecord() async{
    File vid= await ImagePicker.pickVideo(source: ImageSource.camera);
    
    setState(() {
      Video=vid;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.deepOrange,
      body:  ListView(

       children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(30.0),
         ),

        MaterialButton(
          height: 120.0,
          child:Icon(Icons.camera_alt,size: 100.0,),
          onPressed: click,
        ),
         Padding(
           padding: const EdgeInsets.all(30.0),
         ),

         MaterialButton(
           height: 120.0,
            child: Icon(Icons.video_call,size: 100.0,),
           onPressed: videorecord,

         ),
         Padding(
           padding: const EdgeInsets.all(30.0),
         ),
         MaterialButton(
           height: 120.0,
           child: Icon(
               Icons.mic,
             size: 100.0,
           ),
           onPressed: sound,
         ),
         Padding(
           padding: const EdgeInsets.all(90.5),
         ),
         RaisedButton(
           child: Text("SHOW MY RECORDINGS"),
           textColor: Colors.white,
           color: Colors.purple,
             onPressed: navigate
         )
       ],
      ),

    );
  }
}
class cache extends StatefulWidget {
  @override
  _cacheState createState() => _cacheState();
}

class _cacheState extends State<cache> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("Recordings"),
     ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image==null?Text("Sorry no image to show"): Image.file(image),
            Video==null?Text("Sorry no video to show"): Image.file(image),
          ],
        ),
        ),
    );
  }
}

