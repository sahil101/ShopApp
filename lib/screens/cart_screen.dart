import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart' show Cart;
import 'package:provider/provider.dart';
import 'package:shop/widgets/cart_item.dart';
// as ci;
import 'package:shop/providers/orders.dart';
// import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 10),
                      Spacer(),
                      Chip(
                        label: Text(
                          '\$${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .title
                                  .color),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      OrederButton(cart: cart)
                    ],
                  )),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) => CartItem(
                    id: cart.items.values.toList()[i].id,
                    productId: cart.items.keys.toList()[i],
                    title: cart.items.values.toList()[i].title,
                    quantity: cart.items.values.toList()[i].quantity,
                    price: cart.items.values.toList()[i].price),
              ),
            )
          ],
        ));
  }
}

class OrederButton extends StatefulWidget {
  const OrederButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrederButtonState createState() => _OrederButtonState();
}

class _OrederButtonState extends State<OrederButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
        onPressed: widget.cart.totalAmount <= 0 || _isLoading == true
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(), widget.cart.totalAmount);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              },
        textColor: Theme.of(context).primaryColor);
  }
}
