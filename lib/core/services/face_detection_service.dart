import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectionService {
  final FaceDetector _detector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.fast,
      minFaceSize: 0.15,
    ),
  );

  /// Deteksi wajah dari file foto (hasil takePicture).
  Future<List<Face>> detectFacesFromFile(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    return _detector.processImage(inputImage);
  }

  void dispose() {
    _detector.close();
  }
}