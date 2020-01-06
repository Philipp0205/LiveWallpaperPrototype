import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_prot2/model/ImageModel.dart';
import  'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImagePage extends StatefulWidget {
  final Hits model;
  final BoxFit imageBoxFit;

  ImagePage({this.model, this.imageBoxFit});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  VideoPlayerController _videocontroller;
  Future<void> _initializeVideoPlayerFuture;

  static const platform = const MethodChannel(
      'com.example.wallpaper_prot2/wallpaper');

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _videocontroller = VideoPlayerController.network('https://p-ams2.pcloud.com/cBZx3qea5Zsc991SZxB8iZXZ4tTiN7ZQ5ZZW05ZkZ2stQZaJZ3ZakZ4ZHXZR5Zw7ZSXZQkZtZSkZY0ZykZEXZiWeSkZV71c3cr2hTYWlagXRkczeJP0ADf7/Claiming%20coastline%2C%20Lagos.mp4');

    _initializeVideoPlayerFuture = _videocontroller.initialize();
    _videocontroller.play();

    _videocontroller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _videocontroller.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,

      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _videocontroller.value.aspectRatio,
              child: VideoPlayer(_videocontroller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setWallpaperDialog,
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _videocontroller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

 void setWallpaperDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Set a wallpaper',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                  )
                  ),
              ),
              ListTile(
                title: Text(
                  'Home Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(1),
              ),
              ListTile(
                title: Text(
                  'Lock Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(2),
              ),
              ListTile(
                title: Text(
                  'Both',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(3),
              )
            ],
          ),
        );
      },
    );
 }

  Future<void> _setWallpaper(int wallpaperType) async {
    var file = await DefaultCacheManager().getSingleFile('https://p-ams2.pcloud.com/cBZx3qea5Zsc991SZxB8iZXZ4tTiN7ZQ5ZZW05ZkZ2stQZaJZ3ZakZ4ZHXZR5Zw7ZSXZQkZtZSkZY0ZykZEXZiWeSkZV71c3cr2hTYWlagXRkczeJP0ADf7/Claiming%20coastline%2C%20Lagos.mp4');
    try {
      final int result = await platform
          .invokeMethod('setWallpaper', [file.path, wallpaperType]);
      print('Wallpaper updated.... $result');
    } on PlatformException catch (e) {
      print("Failed to set wallpaper: '${e.message}'.");
    }
    Fluttertoast.showToast(
      msg: "Wallpaper set successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
    Navigator.pop(context);
  }
}


