import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kids_shadow_drawing_app/Presentation/draw_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late final firstCamera;
  XFile? _selectedImage;
  Future<void> getCamera() async {
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = XFile(pickedFile.path);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DrawScreen(
              camera: firstCamera,
              selectedImage: _selectedImage,
              imagePath: '',
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    getCamera();
    super.initState();
  }

  List<String> imageUrls = [
    'assets/Rainbow-Coloring-Page-with-Castle.jpg',
    'assets/ducks.jpg',
    'assets/Flower-Basket.png',
    'assets/Rabbit.png',
    'assets/Reindeer.jpg',
    'assets/Unicorn.jpg',
    'assets/Mushroom.png',
    'assets/Strawberry.png',
    'assets/Sun.png',
    'assets/TulipColoringPage.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Kidzee Drawing',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Georgia',
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GridView.builder(
          itemCount: imageUrls.length,
          padding: EdgeInsets.all(15.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DrawScreen(
                      camera: firstCamera,
                      imagePath: imageUrls[index],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage(imageUrls[index])),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        tooltip: 'Browse Gallery',
        onPressed: () async {
          pickImage();
        },
        child: const Icon(Icons.image, color: Colors.white),
      ),
    );
  }
}
