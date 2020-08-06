import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

class WatchVideoScreen extends StatefulWidget {
  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> with SingleTickerProviderStateMixin {

  bool play = true;
  VideoPlayerController _videoPlayerController;
  AnimationController _animationController;
  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  PageController _homeController = new PageController();

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    _videoPlayerController = VideoPlayerController.asset('assets/videos/video1.mp4')
    ..initialize().then((value){
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          homeScreen(),
          footer(),
        ],
      ),
    );
  }

  homeScreen(){
    return PageView.builder(
        controller: _homeController,
        onPageChanged: (index){
          setState(() {
            _videoPlayerController.seekTo(Duration.zero);
            _videoPlayerController.play();
          });
        },
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index){
      return Stack(
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: (){
              setState(() {
                if(play){
                  _videoPlayerController.pause();
                  play = false;
                } else {
                  _videoPlayerController.play();
                  play = !play;
                }
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: VideoPlayer(_videoPlayerController),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 70),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text('@spook_clothing', style: TextStyle(color: Colors.white),),),
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(text: 'Some text'),
                        TextSpan(text: '#something\n', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'SOme more  text', style: TextStyle(fontSize: 12))
                      ]), style: TextStyle(color: Colors.white, fontSize: 14),),),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.music_note, size: 16, color: Colors.white,),
                          Text('Some music name', style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 65, right: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 70,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 23),
                      width: 40,
                      height: 50,
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.black,
                              backgroundImage: AssetImage('assets/images/ic_person.png'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Color(0xFD2c58).withOpacity(1),
                              child: Center(
                                child: Icon(Icons.add, size: 15, color: Colors.white,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.favorite, size: 35, color: Colors.white,),
                          Text('423', style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.sms, size: 35, color: Colors.white,),),
                          Text('20', style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: Icon(Icons.share, size: 35, color: Colors.white,),),
                          Text('Share', style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _animationController,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0x222222).withOpacity(1),
                        child: Icon(Icons.music_note, color: Colors.white,)
                      ),
                      builder: (context, _widget){
                        return Transform.rotate(angle: _animationController.value * 6.3,
                          child: _widget,);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  footer(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Divider(
          color: Colors.white.withOpacity(0.5),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 7, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.home, color: Colors.white,),
                    Text('Home', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.camera_enhance, color: Colors.white),
                    Text('Record', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.white),
                    Text('Profile', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
