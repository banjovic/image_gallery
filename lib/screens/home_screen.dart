import 'package:flutter/material.dart';
import 'package:image_gallery/screens/gallery_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Gallery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Image Gallery App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Navigate to the gallery screen
                final PermissionState ps =
                    await PhotoManager.requestPermissionExtend();
                if (ps.isAuth) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GalleryScreen()),
                  );
                } else {
                  // Optionally send the user to settings:
                  PhotoManager.openSetting();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Permission denied. Please enable in settings.',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Open Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
