import 'package:Jouri/ui/home/tabs/fabrics_tab/fabrics_tab_view_model.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../components/attribute_card.dart';
import '../../../../components/product_loading.dart';
import '../../../../models/attribute_term.dart';
import '../../../../utilities/general.dart';

class FabricsTab extends StatelessWidget {
  const FabricsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fabricsTabData = Provider.of<FabricsTabViewModel>(context);
    var currentLang = General.getLanguage(context);

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
                      return snapshot.data!.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    print(
                                        "fabric category id ${snapshot.data![index].id!}");
                                    fabricsTabData.navigateToArchiveScreen(
                                        context,
                                        snapshot.data![index].id!,
                                        snapshot.data![index].name,
                                        snapshot.data![index].description);
                                  },
                                  child: AttributeCard(
                                      attribute: snapshot.data![index]),
                                );
                              })
                          : Container(
                              height: 400,
                              child: Lottie.asset(
                                'assets/lottie/empty_cart.json',
                                repeat: false,
                                alignment: Alignment.center,
                                width: 200,
                              ));
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
                        print(
                            "fabric category id ${fabricsTabData.loadedAttributeTerms[index].id!}");
                        fabricsTabData.navigateToArchiveScreen(
                            context,
                            fabricsTabData.loadedAttributeTerms[index].id!,
                            fabricsTabData.loadedAttributeTerms[index].name,
                            fabricsTabData
                                .loadedAttributeTerms[index].description);
                      },
                      child: AttributeCard(
                          attribute:
                              fabricsTabData.loadedAttributeTerms[index]),
                    );
                  }),
        ],
      ),
    );
  }
}
