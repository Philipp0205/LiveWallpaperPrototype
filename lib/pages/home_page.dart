import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:wallpaper_prot2/utils/img_provider.dart';
import 'image_page.dart';
import '../widget/custom_card.dart';
import 'package:wallpaper_prot2/model/ImageModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel("com.example.wallpaper_prot2/wallpaper");
  List<PreloadPageController> controllers = [];
  List<Hits> hits;

  @override
  void initState() {
    _loadImages();
    controllers = [
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
    ];
    super.initState();
  }

  _animatePage(int page, int index) {
    for (int i = 0; i < 5; i++) {
      if (i != index) {
        controllers[i].animateToPage(page,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
  }

  _loadImages() {
    var imagemodel = ImgProvider().getImages();
    hits = imagemodel.hits;
    setState(() {});
    
  }
  
 Future<void> _setLiveWallpaper() async {
    bool isWallpaperChanged;
    try {
      await platform.invokeMethod('getBatteryLevel');
      isWallpaperChanged = true;
    } on PlatformException catch (e) {
     isWallpaperChanged = false;
    }
    
 } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: PreloadPageView.builder(
        controller:
        PreloadPageController(viewportFraction: 0.7, initialPage: 3),
        itemCount: 1,
        preloadPagesCount: 1,
        itemBuilder: (context, mainIndex) {
          return PreloadPageView.builder(
            itemCount: 5,
            preloadPagesCount: 5,
            controller: controllers[mainIndex],
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            onPageChanged: (page) {
              _animatePage(page, mainIndex);
            },
            itemBuilder: (context, index) {

              var hitIndex = (mainIndex * 5) + index;
              var hit;
              if (hits != null) {
                hit = hits[hitIndex];
              }
              return GestureDetector(
                onTap: () {
                  if (hits != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePage(
                          model: hit,
                          imageBoxFit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
                child: CustomCard(
                  title: hit?.user,
                  url: hit?.webformatURL,
                  description: hit?.description
                ),
              );
            },
          );
        },
      ),
    );
  }
}