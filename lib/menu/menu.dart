import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int selectedMasa = 1;
  GlobalKey buttonKey = GlobalKey();

  void _onMasaSelected(int masaIndex) {
    setState(() {
      selectedMasa = masaIndex;
    });
    Navigator.pop(context); // Menüyü kapat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restoran Uygulaması"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              key: buttonKey,
              onPressed: () {
                // Popup Menu açılacak
                final RenderBox button =
                    buttonKey.currentContext!.findRenderObject() as RenderBox;
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;
                final RelativeRect position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(Offset.zero, ancestor: overlay),
                    button.localToGlobal(button.size.bottomRight(Offset.zero),
                        ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );

                showMenu<int>(
                  context: context,
                  position: position,
                  items: List<PopupMenuEntry<int>>.generate(
                    10,
                    (int index) {
                      return PopupMenuItem<int>(
                        value: index + 1,
                        child: Text("Masa ${index + 1}"),
                      );
                    },
                  ),
                ).then((int? selectedValue) {
                  if (selectedValue != null) {
                    _onMasaSelected(selectedValue);
                  }
                });
              },
              child: Text("Masa $selectedMasa"),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
