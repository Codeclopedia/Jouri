import 'package:Jouri/ui/home/tabs/fabrics_tab/fabrics_tab_view_model.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../components/product_loading.dart';
import '../../../../models/attribute_term.dart';

class FabricsTab extends StatelessWidget {
  const FabricsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fabricsTabData = Provider.of<FabricsTabViewModel>(context);
    var currentLang = KLocalizations.of(context).locale.toLanguageTag();
    var tagStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 3.2,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          fabricsTabData.loadedAttributeTerms.isEmpty
              ? FutureBuilder<List<AttributeTerm>>(
                  future:
                      fabricsTabData.loadAttributeTerms(context, currentLang),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                fabricsTabData.navigateToArchiveScreen(
                                    context,
                                    snapshot.data![index].id!,
                                    snapshot.data![index].name,
                                    snapshot.data![index].description);
                              },
                              child: Card(
                                elevation: 3,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  height: 240,

                                  ///image
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: snapshot
                                                    .data![index].description !=
                                                ''
                                            ? NetworkImage(
                                                '${snapshot.data![index].description}')
                                            : const AssetImage(
                                                    'assets/images/hijab_placeholder.jpg')
                                                as ImageProvider,
                                        fit: BoxFit.cover),
                                  ),

                                  ///title
                                  child: Center(
                                    child: Container(
                                      width: 200,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          snapshot.data![index].name!,
                                          style: tagStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        primary: true,
                        children: const [
                          ProductLoading(),
                          ProductLoading(),
                          ProductLoading(),
                          ProductLoading(),
                        ],
                      );
                    }
                  })
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: fabricsTabData.loadedAttributeTerms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        fabricsTabData.navigateToArchiveScreen(
                            context,
                            fabricsTabData.loadedAttributeTerms[index].id!,
                            fabricsTabData.loadedAttributeTerms[index].name,
                            fabricsTabData
                                .loadedAttributeTerms[index].description);
                      },
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 240,

                          ///image
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: fabricsTabData
                                            .loadedAttributeTerms[index]
                                            .description !=
                                        ''
                                    ? NetworkImage(
                                        '${fabricsTabData.loadedAttributeTerms[index].description}')
                                    : const AssetImage(
                                            'assets/images/hijab_placeholder.jpg')
                                        as ImageProvider,
                                fit: BoxFit.cover),
                          ),

                          ///title
                          child: Center(
                            child: Container(
                              width: 200,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  fabricsTabData
                                      .loadedAttributeTerms[index].name!,
                                  style: tagStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ],
      ),
    );
  }
}
