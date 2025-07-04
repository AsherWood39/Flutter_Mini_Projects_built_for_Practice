// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class DrawScreen extends StatefulWidget {
  final CameraDescription camera;
  final XFile? selectedImage;
  final String imagePath;

  const DrawScreen({
    super.key,
    required this.camera,
    this.selectedImage,
    required this.imagePath,
  });

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  // ignore: unused_field
  bool _isWakelockEnabled = false;
  String imagePath = '';
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  double opacity = .5;
  double _opacitySlider = 50;
  double _imageSizeSlider = 440;
  XFile? _selectedImage;
  @override
  void initState() {
    super.initState();
    _opacitySlider = 50;
    _imageSizeSlider = 440;
    opacity = .5;
    _enableWakelock();
    imagePath = widget.imagePath;
    _selectedImage = widget.selectedImage;
    _controller = CameraController(widget.camera, ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize();
  }

  void _enableWakelock() {
    setState(() {
      _isWakelockEnabled = true;
    });
    WakelockPlus.enable();
  }

  void _disableWakelock() {
    setState(() {
      _isWakelockEnabled = false;
    });
    WakelockPlus.disable();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    // ignore: unnecessary_null_comparison
    if (PickedFile != null) {
      setState(() {
        _selectedImage = XFile(pickedFile!.path);
        imagePath = '';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _disableWakelock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
              child: Text('Have fun', style: TextStyle(color: Colors.white)),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_outlined, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Positioned.fill(
                child: InteractiveViewer(
                  panEnabled: false,
                  boundaryMargin: const EdgeInsets.all(100),
                  minScale: 0.1,
                  maxScale: 2,
                  child: Opacity(
                    opacity: opacity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: _imageSizeSlider,
                          child: Image(
                            image: imagePath == ''
                                ? FileImage(File(_selectedImage!.path))
                                      as ImageProvider<Object>
                                : AssetImage(imagePath)
                                      as ImageProvider<Object>,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Text('Opacity'),
                Slider(
                  value: _opacitySlider,
                  max: 100,
                  divisions: 100,
                  label: _opacitySlider.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _opacitySlider = value;
                      opacity = _opacitySlider / 100;
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Text('Size      '),
                Slider(
                  value: _imageSizeSlider,
                  max: 440,
                  divisions: 440,
                  label: _imageSizeSlider.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _imageSizeSlider = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Browse Gallery',
        backgroundColor: Colors.purple,
        onPressed: () async {
          pickImage();
          setState(() {
            _imageSizeSlider = 600;
            _opacitySlider = 100;
          });
        },
        child: const Icon(Icons.image, color: Colors.white),
      ),
    );
  }
}
