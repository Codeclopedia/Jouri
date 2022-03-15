import 'package:Jouri/components/tag_card/tag_card_view_model.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/tag.dart';
import '../../ui/home_screen/tabs/collections_tab/collections_tab_view_model.dart';

class TagCard extends StatelessWidget {
  const TagCard({
    Key? key,
    required this.currentLang,
    required this.collectionsTabData,
    required this.tag,
    required this.index,
  }) : super(key: key);

  final String currentLang;
  final CollectionsTabViewModel collectionsTabData;
  final Tag tag;
  final int index;

  @override
  Widget build(BuildContext context) {
    var tagCardData = Provider.of<TagCardViewModel>(context);

    var tagStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 28,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      letterSpacing: 6.2,
    );

    var slugStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 2.2,
    );

    return Stack(
      children: [
        ///image
        Container(
          height: 500,
          // width: 375,
          color: index.isEven
              ? Theme.of(context).primaryColor
              : const Color(0Xfff8f9ff),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 20),

          ///image
          child: Align(
            alignment: currentLang == 'ar'
                ? index.isEven
                    ? Alignment.centerLeft
                    : Alignment.centerRight
                : index.isEven
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(
                    '${tag.description}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        ///slug
        Positioned(
            top: 50,
            right: currentLang == 'ar'
                ? index.isEven
                    ? 20
                    : null
                : index.isEven
                    ? null
                    : 1,
            left: currentLang == 'ar'
                ? index.isEven
                    ? null
                    : 20
                : index.isEven
                    ? 20
                    : null,
            child: RotatedBox(
                quarterTurns: -1,
                child: Text(
                  tag.slug!,
                  style: index.isEven
                      ? slugStyle.copyWith(color: Colors.white)
                      : slugStyle,
                ))),

        ///name
        Positioned(
          bottom: 50,
          right: currentLang == 'ar'
              ? index.isEven
                  ? 20
                  : null
              : index.isEven
                  ? null
                  : 1,
          left: currentLang == 'ar'
              ? index.isEven
                  ? null
                  : 20
              : index.isEven
                  ? 20
                  : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  tag.name!,
                  style: index.isEven
                      ? tagStyle.copyWith(color: Colors.white)
                      : tagStyle,
                  textAlign:
                      currentLang == 'ar' ? TextAlign.right : TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    tagCardData.navigateToArchiveScreen(
                        context, tag.id, tag.name);
                  },
                  child: const LocalizedText('homeScreen.shopNow')),
            ],
          ),
        ),
      ],
    );
  }
}
