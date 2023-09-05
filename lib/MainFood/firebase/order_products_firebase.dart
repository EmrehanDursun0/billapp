import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Sipariş belgesini temsil eden sınıf
class OrderDocument {
  final String productId;
  final String name;
  final String price;
  final int quantity;
  final String additionalInfo;
  final String timestamp;

  OrderDocument({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.additionalInfo,
    required this.timestamp,
  });
}

class OrderProductsFirebase extends StatefulWidget {
  const OrderProductsFirebase({Key? key}) : super(key: key);

  @override
  OrderProductsFirebaseState createState() => OrderProductsFirebaseState();
}

class OrderProductsFirebaseState extends State<OrderProductsFirebase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/menu/splash.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Sipariş Bekleyenler",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "name",
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        // height: 30, // Bu satırı kaldırın
                        child: Text(
                          "00 TL",
                          style: GoogleFonts.judson(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        "00 TL",
                        style: GoogleFonts.judson(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Siparişi Hazırlananlar",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "name",
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        child: Text(
                          "00 TL",
                          style: GoogleFonts.judson(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        "00 TL",
                        style: GoogleFonts.judson(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Siparişi Teslim Edilenler",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "name",
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        child: Text(
                          "00 TL",
                          style: GoogleFonts.judson(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        "00 TL",
                        style: GoogleFonts.judson(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Ödemesi Alınanlar",
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "name",
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        child: Text(
                          "00 TL",
                          style: GoogleFonts.judson(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        "00 TL",
                        style: GoogleFonts.judson(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
