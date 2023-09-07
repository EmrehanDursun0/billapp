// import 'package:billapp/menu_update/dynamic_menu_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// void showUpdateMenuDialog(BuildContext context) {
//   String username = ""; // Kullanıcı adı alanı
//   String password = ""; // Şifre alanı

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: const Color(0xFFE0A66B),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(40),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF260900),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Center(
//                 child: Text(
//                   "Admin Giriş",
//                   style: GoogleFonts.judson(
//                     fontSize: 26,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               onChanged: (value) {
//                 username = value; // Kullanıcı adını güncelle
//               },
//               decoration: InputDecoration(
//                 labelText: 'Kullanıcı Adı',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               onChanged: (value) {
//                 password = value; // Şifreyi güncelle
//               },
//               decoration: InputDecoration(
//                 labelText: 'Şifre',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                   onPressed: () async {
//                     try {
//                       UserCredential userCredential = await FirebaseAuth
//                           .instance
//                           .signInWithEmailAndPassword(
//                         email:
//                             username, // Kullanıcı adını e-posta olarak kullanabilirsiniz
//                         password: password,
//                       );

//                       // Kullanıcı başarıyla giriş yaptıysa
//                       if (userCredential.user != null) {
//                         // ignore: use_build_context_synchronously
//                         Navigator.of(context).pop(); // Dialog'u kapat
//                         // ignore: use_build_context_synchronously
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>
//                               const DynamicMenuPage(selectedtitle: ''),
//                         ));
//                       }
//                     } catch (e) {
//                       // Hata durumunda
//                       // ignore: use_build_context_synchronously
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text("Kullanıcı adı veya şifre hatalı"),
//                       ));
//                     }
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xFF260900),
//                   ),
//                   child: Text(
//                     'Giriş yap',
//                     style: GoogleFonts.judson(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Dialog'u kapat
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xFF260900),
//                   ),
//                   child: Text(
//                     'İptal',
//                     style: GoogleFonts.judson(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
