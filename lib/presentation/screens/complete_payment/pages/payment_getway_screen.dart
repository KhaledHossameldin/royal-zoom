import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../constants/routes.dart';
import '../../../../localization/localizor.dart';

class PaymentGetWayScreen extends StatefulWidget {
  const PaymentGetWayScreen({super.key, this.ndc, this.invoiceId});
  final String? ndc;
  final num? invoiceId;

  @override
  State<PaymentGetWayScreen> createState() => _PaymentGetWayScreenState();
}

class _PaymentGetWayScreenState extends State<PaymentGetWayScreen> {
  Future<String> loadHtml() async {
    var result = await rootBundle.loadString('assets/html/payment.html');

    result = result.replaceAll('{checkoutId}', widget.ndc ?? '');
    result =
        result.replaceAll('{locale}', Localizor.translator.locale.languageCode);
    Logger().d(result);
    return result;
  }

  WebViewController? _controller;

  void initContrller(String html) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            Navigator.of(context)
                .pushNamed(Routes.paymentResult, arguments: widget.invoiceId);

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(html);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadHtml().then((html) {
      initContrller(html);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_controller == null)
        ? const CircularProgressIndicator()
        : WebViewWidget(controller: _controller!);
  }
}
