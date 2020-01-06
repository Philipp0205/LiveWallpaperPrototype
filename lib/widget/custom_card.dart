import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class CustomCard extends StatefulWidget {
  CustomCard({
    @required this.url,
    @required this.title,
    @required this.description,
  });
  final String url;
  final String title;
  final String description;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

 @override
 void initState() {
   _controller = VideoPlayerController.network('https://p-ams2.pcloud.com/cBZx3qea5Zsc991SZxB8iZXZ4tTiN7ZQ5ZZW05ZkZ2stQZaJZ3ZakZ4ZHXZR5Zw7ZSXZQkZtZSkZY0ZykZEXZiWeSkZV71c3cr2hTYWlagXRkczeJP0ADf7/Claiming%20coastline%2C%20Lagos.mp4');

   _initializeVideoPlayerFuture = _controller.initialize();
   _controller.setLooping(true);
   _controller.play();

   super.initState();
 }

 @override
 void dispose() {
   _controller.dispose();

   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Stack(
        children: <Widget>[
         FutureBuilder(
           future: _initializeVideoPlayerFuture,
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.done) {
               return AspectRatio(
                 aspectRatio: _controller.value.aspectRatio,
                 child: VideoPlayer(_controller),
                 );
             } else {
               return Center(child: CircularProgressIndicator());
             }
           },
         ),
//          Container(
//            child: (widget.url != null)
//
//              ? Image.network(widget.url)
//                : null,
//            width: double.infinity,
//            height: double.infinity,
//          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 200.0,
              decoration: _whiteGradientDecoration(),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  (widget.title != null) ? widget.title : '',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (widget.description != null) ? widget.description : '',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _whiteGradientDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.black, const Color(0x10000000)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter),
    );
  }
}