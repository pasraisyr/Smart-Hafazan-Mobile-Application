import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class HukumMimMatiPage extends StatefulWidget {
  const HukumMimMatiPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HukumMimMatiPageState createState() => _HukumMimMatiPageState();
}

class _HukumMimMatiPageState extends State<HukumMimMatiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hukum Mim Mati Tajwid'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hukum Mim Mati',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 197, 142, 219), // Set your desired background color
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Text(
              'Definisi : ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Hukum Mim Mati adalah Mim mati mati atau mim saktah adalah mim yang berbaris mati atau sukun (ﻡْ).',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show the image in full screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImagePage(),
                  ),
                );
              },
              child: const Text('Lihat Nota'),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final List<String> imageAssets = ['assets/hukum/hukumMim.png'];

  FullScreenImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PhotoViewGallery.builder(
              itemCount: imageAssets.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(imageAssets[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: PageController(),
              onPageChanged: (index) {},
            ),
            Positioned(
              top: 40.0,
              left: 16.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Pop the screen when tapping on the close button
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: HukumMimMatiPage(),
    ),
  );
}
