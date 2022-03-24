import 'package:Jouri/models/tag.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../components/loading.dart';
import '../../../../components/tag_card/tag_card.dart';
import '../../../../components/tag_card/tag_card_view_model.dart';
import 'collections_tab_view_model.dart';

class CollectionsTab extends StatelessWidget {
  const CollectionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var collectionsTabData = Provider.of<CollectionsTabViewModel>(context);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ///tag
          collectionsTabData.loadedTags.isEmpty
              ? FutureBuilder<List<Tag>>(
                  future: collectionsTabData.loadTags(context, currentLang),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ChangeNotifierProvider(
                              create: (context) => TagCardViewModel(),
                              child: TagCard(
                                currentLang: currentLang,
                                collectionsTabData: collectionsTabData,
                                tag: snapshot.data![index],
                                index: index,
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: Loading(),
                      );
                    }
                  },
                )
              : ListView.builder(
                  itemCount: collectionsTabData.loadedTags.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider(
                      create: (context) => TagCardViewModel(),
                      child: TagCard(
                        currentLang: currentLang,
                        collectionsTabData: collectionsTabData,
                        tag: collectionsTabData.loadedTags[index],
                        index: index,
                      ),
                    );
                  })
        ],
      ),
    );
  }
}
