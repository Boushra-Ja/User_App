import 'package:flutter/material.dart';


class companyProfile extends StatelessWidget with PreferredSizeWidget{

  final list ;

  const companyProfile({Key key, this.list}) : super(key: key);
  @override
  Size get preferredSize => Size( double.infinity , 250);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(

      body: ClipPath(
        clipper: MyClipper(),
    child: Container(
    padding: EdgeInsets.only(top: 4),
    decoration: BoxDecoration(
    color: Colors.redAccent,
    boxShadow: [
    BoxShadow(
    color: Colors.red,
    blurRadius: 20,
    offset: Offset(0, 0)
    )
    ]
    ),
    ))
    ));
  }
}
class MyClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height-100);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
/*class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.pink.shade900 ;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}*/