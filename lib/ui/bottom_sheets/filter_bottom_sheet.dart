import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../utilities/general.dart';

class FilterBottomSheet extends StatefulWidget {
  final SfRangeValues? data;

  const FilterBottomSheet({Key? key, required this.data}) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  var values = const SfRangeValues(10.0, 30.0);

  @override
  void initState() {
    if (widget.data != null && widget.data!.start != widget.data!.end) {
      values = widget.data!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sheetTitleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      letterSpacing: 2.8,
    );

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
              General.getTranslatedText(context, 'productArchive.filter'),
              style: sheetTitleStyle,
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context).pop(const SfRangeValues(0, 0));
              },
              icon: const Icon(Icons.close),
            ),
          ),
          ListTile(
            title: Text(
                General.getTranslatedText(context, 'productArchive.price')),
            leading: const Icon(Icons.monetization_on_outlined),
            minLeadingWidth: 20,
          ),
          SfRangeSlider(
            min: 10.0,
            max: 30.0,
            values: values,
            onChanged: (value) {
              setState(() {
                values = value;
              });
            },
            stepSize: 1,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            interval: 2,
            startThumbIcon: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            endThumbIcon: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            activeColor: Colors.grey,
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text(
                      General.getTranslatedText(
                          context, 'productArchive.reset'),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(values);
                    },
                    child: Text(General.getTranslatedText(
                        context, 'productArchive.apply')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
