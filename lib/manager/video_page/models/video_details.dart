import 'video.dart';

class VideoDetails {
  final String image, title;
  final int duration;
  final List<Video> videos;

  const VideoDetails(
      {this.image = '',
      this.title = '',
      this.duration = 0,
      this.videos = const []});

  factory VideoDetails.fromJson(Map<String, dynamic> videoJson) {
    final sources = List<Map<String, dynamic>>.from(videoJson['sources']);
    sources.removeWhere((e) => e['type'] != 'video/mp4');
    final videos = sources.map((e) => Video.fromJson(e)).toList();
    return VideoDetails(
        image: videoJson['image'],
        duration: videoJson['duration'],
        title: videoJson['title'],
        videos: videos);
  }
}
