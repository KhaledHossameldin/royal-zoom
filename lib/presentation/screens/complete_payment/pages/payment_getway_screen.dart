import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGetWayScreen extends StatefulWidget {
  const PaymentGetWayScreen({super.key});

  @override
  State<PaymentGetWayScreen> createState() => _PaymentGetWayScreenState();
}

class _PaymentGetWayScreenState extends State<PaymentGetWayScreen> {
  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
