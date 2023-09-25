import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_gateway/product_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = "pk_test_51Njh5MBrgg9vq6KSHqVET8jncwNv4sg1D8NazRCfEzYS8NratKjt58twODtdXPybLOOz1lBxashUicm8rYApCw3p00OUCfqGWD";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark,),);
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home:const ProductDetails(),
    );
  }
}
