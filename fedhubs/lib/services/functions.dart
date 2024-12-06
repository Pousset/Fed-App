import 'package:html_unescape/html_unescape.dart';

final htmlUnescape = HtmlUnescape();
String? clean(String? str) => str != null ? htmlUnescape.convert(str) : null;
