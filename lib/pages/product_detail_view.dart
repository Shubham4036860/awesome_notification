import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  String productImageUrl;
  String productTitle;
  String productDescription;

  ProductDetailPage(
      this.productImageUrl, this.productTitle, this.productDescription,
      {super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final List<String> sizeList = ["S", "M", "L", "XL"];
  int qtyOfProduct = 1;
  int selectedSizePos = 0;
  int priceOfProduct = 130;
  int finalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Product Detail',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )),
            productDetailsView(widget.productImageUrl, widget.productTitle,
                widget.productDescription)
          ],
        ),
      ),
    ));
  }

  Widget productDetailsView(
      String urlOfProduct, String titleOfProduct, String desOfProduct) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Image.network(urlOfProduct, fit: BoxFit.contain),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Text(
                titleOfProduct,
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "R.S${finalPrice.toString() == "0" ? priceOfProduct.toString() : finalPrice.toString()}",
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            desOfProduct,
            style: const TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25.0, left: 20.0),
          child: Text(
            "Size Of Product",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: getSizeWidget(context),
              ),
            )),
        const Padding(
          padding: EdgeInsets.only(top: 25.0, left: 20.0),
          child: Text(
            "Quantity Of Product",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    calculationOfProduct("minus");
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.orange.withOpacity(0.3),
                    child: const Center(
                      child: Icon(Icons.remove),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  qtyOfProduct.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    calculationOfProduct("plus");
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.orange.withOpacity(0.3),
                    child: const Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 52,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.3), width: 1.0)),
              child: const Center(
                child: Text(
                  "Add To Cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ],
    );
  }

  List<Widget> getSizeWidget(BuildContext context) {
    List<Widget> sizeWidget = [];

    for (int i = 0; i < (sizeList).length; i++) {
      sizeWidget.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedSizePos = i;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:
                    selectedSizePos == i ? Colors.orange : Colors.transparent,
                border: Border.all(color: Colors.grey, width: 1)),
            child: Center(
              child: Text(
                sizeList[i],
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                    color: selectedSizePos == i ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: selectedSizePos == i
                        ? FontWeight.bold
                        : FontWeight.w300),
              ),
            ),
          ),
        ),
      ));
    }

    return sizeWidget;
  }

  void calculationOfProduct(String action) {
    if (action == "plus") {
      setState(() {
        qtyOfProduct++;
        finalPrice = priceOfProduct * qtyOfProduct;
        print("final price of product$finalPrice");
      });
    } else if (action == "minus") {
      setState(() {
        if (qtyOfProduct > 1) {
          qtyOfProduct--;
          finalPrice = priceOfProduct * qtyOfProduct;
          print("final price of product$finalPrice");
        }
      });
    }
  }
}
