class Video {
  final String url;
  final QualityLabel label;
  final int height, width;

  const Video(
      {required this.url,
      required this.height,
      required this.label,
      required this.width});

  factory Video.fromJson(var json) {
    final label = _getLabel(json['label']);
    return Video(
        url: json['file'],
        height: json['height'],
        label: label,
        width: json['width']);
  }

  double get aspectRatio => width / height;
}

enum QualityLabel {
  label180,
  label270,
  label360,
  label540,
  label720,
  label1080,
  unknown
}

extension QualityLabelExtension on QualityLabel {
  String get labelName {
    switch (this) {
      case QualityLabel.label180:
        return '180p';
      case QualityLabel.label270:
        return '270p';
      case QualityLabel.label360:
        return '360p';
      case QualityLabel.label540:
        return '540p';
      case QualityLabel.label720:
        return '720p';
      case QualityLabel.label1080:
        return '1080p';
      case QualityLabel.unknown:
        return '';
    }
  }
}

QualityLabel _getLabel(String label) {
  final index = labels.indexOf(label);
  if (index == -1) return QualityLabel.unknown;
  return qualityLabels[index];
}

const labels = ['180p', '270p', '360p', '540p', '720p', '1080p'];

const qualityLabels = [
  QualityLabel.label180,
  QualityLabel.label270,
  QualityLabel.label360,
  QualityLabel.label540,
  QualityLabel.label720,
  QualityLabel.label1080
];
