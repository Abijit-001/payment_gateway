import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  static const List<Color> watchColors = [
    Colors.black54,
    Colors.brown,
    Colors.blueGrey,
    Colors.amber,
  ];

  static const List<double> sizes = [9.5, 10.5, 11, 12];

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Map<String, dynamic>? paymentIntent;

  WebViewController webViewController = WebViewController()
    ..setBackgroundColor(Colors.transparent)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse('https://elegant-tanuki-0787ed.netlify.app'),
    );

  /* Future<void> initPaymentSheet() async {
    try {
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: const stripe.SetupPaymentSheetParameters(
          customFlow: true,
          merchantDisplayName: 'Flutter Stripe Demo',
          paymentIntentClientSecret: "",
          customerEphemeralKeySecret: "",
          customerId: "",
          setupIntentClientSecret: "",
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet(
          options: const stripe.PaymentSheetPresentOptions(timeout: 1200000));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successfully completed'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }*/
  Future<void> payment() async {
    try {
      Map<String, dynamic> body = {
        'amount': "249900",
        'currency': "BDT",
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51Njh5MBrgg9vq6KSWxReEvKMARIecrWPksvJtCKNH6cDBShXcXLVqZLsf5UUU15BqjFSzOBowcV7xofycQ9Gcv3N00Nphmevz5',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      paymentIntent = json.decode(response.body);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }

    await stripe.Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Abijit',
        ))
        .then((value) {});

    try{
      await stripe.Stripe.instance.presentPaymentSheet().then((value) {
        print(value);
      });
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Smart Watch',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black54,
                ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 360,
              width: 360,
              child: WebViewWidget(
                controller: webViewController,
              ),
            ),
            Text(
              'Matrix Man\'s Smart watch',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_border_rounded,
                  color: Colors.orange.shade300,
                ),
                Text(
                  '4.6/5.0 (127 Reviews)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.orange.shade300,
                      ),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Column(children: [
                    Text(
                      'Colors',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          4,
                          (index) => Container(
                                height: 25,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ProductDetails.watchColors[index],
                                ),
                                child: const Text('     '),
                              )),
                    )
                  ]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sizes',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.only(
                              right: 5,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.shade200,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: Text(
                                ProductDetails.sizes[index].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.black54,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                      Text(
                        'BDT 2499.00',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.black54,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  await payment();
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                child: Text(
                  'Buy now',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
