// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void openPopup(String subdomain, {String? name}) {
  String host = html.window.location.origin;

  html.window.open(
    '$host#/$subdomain',
    name ?? "",
    'width=400,height=800,scrollbars=no,resizable=no',
  );
}

openUrl(String url) {
  html.window.open(url, "");
}
