import 'package:flutter_html/flutter_html.dart';
import '../source.dart';

class HTMLParser extends StatelessWidget {
  final String? body;
  const HTMLParser(this.body, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: body,
/*   style: {
    "table": Style(
      backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
    ),
    "tr": Style(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    "th": Style(
      padding: EdgeInsets.all(6),
      backgroundColor: Colors.grey,
    ),
    "td": Style(
      padding: EdgeInsets.all(6),
      alignment: Alignment.topLeft,
    ),
    // text that renders h1 elements will be red
    "h1": Style(color: Colors.red),
  } */
    );
  }
}
