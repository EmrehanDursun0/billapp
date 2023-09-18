import 'package:billapp/Page/home_page.dart';
import 'package:billapp/firebase_options.dart';
import 'package:billapp/providers/authentication_provider.dart';
import 'package:billapp/providers/categoires_provider.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:billapp/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'providers/bill_app_provider.dart';
import 'providers/firebase_provider.dart';
import 'providers/order_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: createProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return const HomePage();
            }
            return const HomePage();
          }),
        ),
      ),
    );
  }
}

List<SingleChildWidget> createProviders() {
  return [
    ChangeNotifierProvider<BillAppProvider>(
      create: (_) => BillAppProvider(),
    ),
    ChangeNotifierProvider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(),
    ),
    ChangeNotifierProvider<FirebaseProvider>(
      create: (_) => FirebaseProvider(),
    ),
    ChangeNotifierProvider<OrderProvider>(
      create: (_) => OrderProvider(),
    ),
    ChangeNotifierProvider<TableProvider>(
      create: (_) => TableProvider(),
    ),
    ChangeNotifierProvider<CategoryProvider>(
      create: (_) => CategoryProvider(),
    ),
    ChangeNotifierProvider<ProductProvider>(
      create: (_) => ProductProvider(),
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    ),
  ];
}
