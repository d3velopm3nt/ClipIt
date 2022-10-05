import 'package:flutter/material.dart';

class NoResultsView extends StatefulWidget {
  final String image;
 final String title;
  String? description; 
  NoResultsView({Key? key, required this.image, required this.title,this.description}) : super(key: key);

  @override
  State<NoResultsView> createState() => _NoResultsViewState();
}

class _NoResultsViewState extends State<NoResultsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          //title
          _buildImage(widget.image),
          Text(widget.title,style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700)),
          Text(widget.description as String,textAlign: TextAlign.center,)
          ],

      ),
    );
  }


   Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/$assetName',
      width: width,
      filterQuality: FilterQuality.high,
    );
  }
}
