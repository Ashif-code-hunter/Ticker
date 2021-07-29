import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  String selectedCrypto = 'BTC';

  CupertinoPicker picker(List<String> currencieList) {
    // get method for curpitino picker for ios
    List<Widget> scrollItemList =
        []; // we can also give text instead of widget like List<Text>
    for (String scrollItem in currencieList) {
      scrollItemList.add(
        Text(
          scrollItem,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return CupertinoPicker(
      itemExtent: 42,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: scrollItemList,
    );
  }

  String coinValue;
  bool areYouWaiting = false;
  void getData() async {
    areYouWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency, selectedCrypto);
      areYouWaiting = false;
      setState(() {
        coinValue = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF010035),
        title: Center(
          child: Text(
            'Coin Ticker',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Color(0x99010035),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130,
                      ),
                      Text(
                        '1 $selectedCrypto = ${areYouWaiting ? '?' : coinValue}$selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildExpandedCards('Crypto', cryptoList),
                    buildExpandedCards('Currency', currenciesList),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpandedCards(String cardTitle, List<String> currency) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color(0x99010035),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$cardTitle',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            picker(currency),
          ],
        ),
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.value,
    @required this.selectedCurrency,
    @required this.selectedCrypto,
  }) : super(key: key);

  final String value;
  final String selectedCurrency;
  final String selectedCrypto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
      child: Card(
        color: Color(0xFF424242),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          child: Text(
            '1 $selectedCrypto = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
