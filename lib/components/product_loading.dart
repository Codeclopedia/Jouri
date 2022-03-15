import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoading extends StatefulWidget {
  const ProductLoading({Key? key}) : super(key: key);

  @override
  _ProductLoadingState createState() => _ProductLoadingState();
}

class _ProductLoadingState extends State<ProductLoading> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.black38,
          highlightColor: Colors.white,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 185.0,
                      width: double.infinity,
                      color: Colors.black12,
                    ),
                    Container(
                      height: 25.5,
                      width: 65.0,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD7124A),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topLeft: Radius.circular(5.0))),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 12.0),
                    child: Container(
                      height: 9.5,
                      width: 130.0,
                      color: Colors.black12,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0),
                  child: Container(
                    height: 9.5,
                    width: 80.0,
                    color: Colors.black12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
