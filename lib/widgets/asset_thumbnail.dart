import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/widgets/image_view.dart';
import 'package:image_gallery/widgets/video_view.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({super.key, required this.asset});

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: asset.thumbnailData.then((value) => value!),
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return asset.type == AssetType.image
                      ? ImageView(imageFile: asset.file)
                      : VideoView(videoFile: asset.file);
                },
              ),
            );
          },
          child: Stack(
            children: [
              Positioned.fill(child: Image.memory(bytes, fit: BoxFit.cover)),
              if (asset.type == AssetType.video)
                // Center(
                //   child: Container(
                //     color: Colors.black,
                //     child: const Icon(Icons.play_arrow, color: Colors.white),
                //   ),
                // ),
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 48,
                      color: Colors.white70,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
