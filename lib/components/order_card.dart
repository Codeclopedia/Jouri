import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../models/order.dart';
import '../utilities/constants.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
    required this.currency,
  }) : super(key: key);

  final Order order;
  final String currency;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (order.status == Constants.canceled || order.status == Constants.failed)
      statusColor = Colors.red;
    else if (order.status == Constants.completed)
      statusColor = Colors.green;
    else if (order.status == Constants.processing)
      statusColor = Colors.orange;
    else if (order.status == Constants.pending)
      statusColor = Colors.yellow;
    else if (order.status == Constants.refundReq ||
        order.status == Constants.refunded)
      statusColor = Colors.purple;
    else {
      statusColor = Theme.of(context).primaryColor;
    }

    var statusStyle = TextStyle(
      fontFamily: 'OpenSans',
      color: statusColor,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );
    var idStyle = TextStyle(
      fontFamily: 'OpenSans',
      color: Theme.of(context).primaryColor,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffe5e5ea),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.status!,
              style: statusStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                LocalizedText('orders.orderId', style: idStyle),
                Text(' : #${order.id}', style: idStyle)
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${order.dateCreated!.day} - ${order.dateCreated!.month} - ${order.dateCreated!.year}',
              style: idStyle.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocalizedText('orders.total',
                    style: idStyle.copyWith(
                      letterSpacing: 2.8,
                    )),
                Text(' : ${order.total} $currency',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ))
              ],
            )
          ],
        )
      ]),
    );
  }
}
