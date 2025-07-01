import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:signature/signature.dart';

class SignatureView extends StatefulWidget {
  const SignatureView({super.key});

  @override
  State<SignatureView> createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  bool _isUploading = false;

  Future<Uint8List?> compressSignatureImage(Uint8List imageBytes) async {
    // Decode PNG
    final codec = await ui.instantiateImageCodec(imageBytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    // Redraw image to canvas (optionally resize here)
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    // You can scale canvas here if needed (to reduce resolution)
    canvas.drawImage(image, Offset.zero, paint);

    final picture = recorder.endRecording();
    final finalImage = await picture.toImage(image.width, image.height);

    // Convert back to PNG (compressed)
    final compressedBytes = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return compressedBytes?.buffer.asUint8List();
  }

  Future<void> _saveAndUploadSignature() async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please draw your signature')),
      );
      return;
    }

    try {
      setState(() => _isUploading = true);

      // Convert signature to bytes
      final rawBytes = await _controller.toPngBytes();
      if (rawBytes == null) throw Exception('Failed to export signature');

      // Compress image (PNG redraw)
      final compressedBytes = await compressSignatureImage(rawBytes);
      if (compressedBytes == null) throw Exception('Failed to compress image');

      // Save temporarily (optional)
      // final tempDir = await getTemporaryDirectory();
      // final file = File('${tempDir.path}/${generateUuidV4()}.png');
      // await file.writeAsBytes(compressedBytes);

      // Upload to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child(
        'signatures/${generateUuidV4()}.png',
      );
      final uploadTask = await ref.putData(compressedBytes);

      final downloadUrl = await uploadTask.ref.getDownloadURL();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uploaded Successfully: $downloadUrl')),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Upload failed: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Signature'),
        actions: [
          TextButton(
            onPressed: _controller.clear,
            child: const Text("Clear", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: _controller,
              backgroundColor: Colors.grey[200]!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon:
                    _isUploading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Icon(Icons.upload),
                label: Text(_isUploading ? "Uploading..." : "Save & Upload"),
                onPressed: _isUploading ? null : _saveAndUploadSignature,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
