import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyectoubicua/Vistas/size_config.dart';

class Categorias extends StatelessWidget {
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categorias = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "More"},
    ];
    return Padding(
      
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        
         List.generate(
          categorias.length,
          (index) => CategoryCard(
            icon: categorias[index]["icon"],
            text: categorias[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String text;
  final String icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}