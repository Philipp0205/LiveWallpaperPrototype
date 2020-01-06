import 'package:wallpaper_prot2/model/ImageModel.dart';

class ImgProvider {
 ImageModel getImages(){
 int totalHits = 5;
 List<Hits> hits = new List<Hits>();

 hits.add(new Hits(id: 1, webformatURL: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', title: 'Test', description: "Test", user: 'testuser'  ));
 hits.add(new Hits(id: 1, webformatURL: 'https://1.bp.blogspot.com/-q3aoaoo9gK0/WdYs4Jzh0_I/AAAAAAAADsk/OKY1BGJ0LxITMRcXrNSYmw21hwISRDQzgCEwYBhgL/s1600/IMG_E5985.JPG', title: 'Test', description: "Test", user: 'testuser'  ));
 hits.add(new Hits(id: 1, webformatURL: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', title: 'Test', description: "Test", user: 'testuser'  ));
 hits.add(new Hits(id: 1, webformatURL: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', title: 'Test', description: "Test", user: 'testuser'  ));
 hits.add(new Hits(id: 1, webformatURL: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', title: 'Test', description: "Test", user: 'testuser'  ));

 return new ImageModel(totalHits: totalHits, hits: hits, total: 5);
 }

}
