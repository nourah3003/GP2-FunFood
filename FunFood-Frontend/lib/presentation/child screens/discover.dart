import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fun_food/classes/api.dart';
import 'package:fun_food/main.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  double width = 0;
  int currentIndex = 0;
  Duration duration = Duration.zero;
  Future<List<dynamic>?>? items;
  AudioPlayer instance = AudioPlayer();

  String typeResolver(String val) {
    if (val == "1") {
      return "Fruit";
    } else {
      return "Vegetable";
    }
  }

  @override
  void initState() {
    items = API.getAll(user!.userID);
    super.initState();
  }

  @override
  void dispose() {
    instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,

      body: Stack(alignment: Alignment.topCenter, children: [
        Image.asset(
          "assets/discover screen.jpg",
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            SafeArea(
                child: Container(
              width: size.width,
              height: size.height * 0.1,
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.6)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32,
                      )),
                  Text(
                    "Discover !",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  )
                ],
              ),
            )),
            Expanded(
              child: FutureBuilder<List<dynamic>?>(
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return PageView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.6),
                                ),
                                child: ListView(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (currentIndex > 0) {
                                                currentIndex = currentIndex - 1;
                                                setState(() {});
                                              }
                                            },
                                            icon: Icon(Icons.arrow_back_ios)),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            url +
                                                "/" +
                                                snapshot.data![currentIndex]
                                                    ["image_url"],
                                            fit: BoxFit.cover,
                                            width: size.width * 0.6, // size of images
                                            height: size.height * 0.3,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (currentIndex <
                                                  snapshot.data!.length - 1) {
                                                currentIndex = currentIndex + 1;
                                                setState(() {});
                                              }
                                            },
                                            icon: Icon(Icons.arrow_forward_ios))
                                      ],
                                    ),
                                    
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Center(
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Text(
                                              snapshot.data![currentIndex]
                                                  ["name"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Calibri',
                                              ),
                                            )),
                                      ),
                                    ),
                                     FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: ListTile(
                                          title: Text("Type : "),
                                          subtitle: Text(
                                           typeResolver(snapshot.data![currentIndex]
                                                  ["type"].toString()),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Calibri',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: ListTile(
                                          title: Text("Benefits : "),
                                          subtitle: Text(
                                            snapshot.data![currentIndex]
                                                ["benefits"],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Calibri',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    snapshot.data![currentIndex]["audio_url"] ==
                                            null
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: size.height * 0.08,
                                              decoration: BoxDecoration(
                                                color: Colors.white60,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        if (instance.state !=
                                                            PlayerState
                                                                .PLAYING) {
                                                          await instance
                                                              .play(
                                                            url +
                                                                "/" +
                                                                snapshot.data![
                                                                        currentIndex]
                                                                        [
                                                                        "audio_url"]
                                                                    .toString()
                                                                    .replaceAll(
                                                                        "\/",
                                                                        "/"),
                                                          )
                                                              .whenComplete(() {
                                                            setState(() {});
                                                          });
                                                          instance
                                                              .onDurationChanged
                                                              .listen(
                                                                  (Duration d) {
                                                            setState(() =>
                                                                duration = d);
                                                          });
                                                          instance
                                                              .onAudioPositionChanged
                                                              .listen(
                                                                  (Duration
                                                                          p) =>
                                                                      {
                                                                        setState(() =>
                                                                            width =
                                                                                p.inMilliseconds / duration.inMilliseconds),
                                                                      });
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      duration
                                                                          .inMilliseconds),
                                                              () {
                                                            instance.release();
                                                            setState(() {});
                                                          });
                                                        }
                                                      },
                                                      icon: instance.state !=
                                                              PlayerState
                                                                  .PLAYING
                                                          ? Icon(
                                                              Icons.play_arrow)
                                                          : Icon(Icons
                                                              .pause_circle_sharp)),
                                                  AnimatedContainer(
                                                    decoration: BoxDecoration(
                                                        color: Colors.pink,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    width: size.width *
                                                        width *
                                                        0.8,
                                                    height: size.height * 0.01,
                                                    child: Text(""),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            });
                      }
                    }
                    return Text("No Items");
                  }),
            )
          ],
        ),
      ]),
    );
  }
}
