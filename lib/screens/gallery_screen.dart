import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/asset_thumbnail.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<AssetEntity> assets = [];

  Future<void> _fetchAssets() async {
    assets = await PhotoManager.getAssetListRange(start: 0, end: 100000);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gallery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
          assets.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: assets.length,
                itemBuilder: (context, index) {
                  return AssetThumbnail(asset: assets[index]);
                },
              ),
    );
  }
}
