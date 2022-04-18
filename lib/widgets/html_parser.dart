import 'package:flutter_html/flutter_html.dart';
import 'source.dart';
class HTMLParser extends StatelessWidget {
  final String? body;
  const HTMLParser(this.body, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(data: body);
  }
}
