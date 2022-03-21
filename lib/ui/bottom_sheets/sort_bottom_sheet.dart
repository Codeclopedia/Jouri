import 'package:flutter/material.dart';

import '../../utilities/general.dart';

class SortBottomSheet extends StatefulWidget {
  final int? sortValue;

  SortBottomSheet({Key? key, required this.sortValue}) : super(key: key);

  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  int? value = 0;
  var titleList = ['newest', 'oldest', 'priceHTL', 'priceLTH'];
  var sheetTitleStyle = const TextStyle(
    color: Color(0xff231f20),
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    letterSpacing: 2.8,
  );
  var elementsStyle = const TextStyle(
    color: Color(0xff231f20),
    fontSize: 14,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    letterSpacing: 2.8,
  );

  @override
  void initState() {
    value = widget.sortValue ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              General.getTranslatedText(context, 'productArchivePage.sort'),
              style: sheetTitleStyle,
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          ...titleList.map((e) => _buildRadioButton(e)),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(value);
              },
              child: Text(
                  General.getTranslatedText(context, 'productArchivePage.apply')),
            ),
          ),
        ],
      ),
    );
  }

  _buildRadioButton(String title) {
    return RadioListTile(
      value: titleList.indexOf(title),
      groupValue: value,
      onChanged: (ind) => setState(() => value = ind as int?),
      title: Text(
        General.getTranslatedText(context, "productArchivePage.$title"),
        style: elementsStyle,
      ),
      selectedTileColor: Theme.of(context).primaryColor,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
