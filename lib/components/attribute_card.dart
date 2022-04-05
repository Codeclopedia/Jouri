import 'package:Jouri/models/attribute_term.dart';
import 'package:flutter/material.dart';

class AttributeCard extends StatelessWidget {
  final AttributeTerm attribute;
  const AttributeCard({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var attrStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      letterSpacing: 3.2,
    );

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 240,

        ///image
        decoration: BoxDecoration(
          image: DecorationImage(
              image: attribute.description != ''
                  ? NetworkImage('${attribute.description}')
                  : const AssetImage('assets/images/hijab_placeholder.jpg')
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
                attribute.name!,
                style: attrStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
