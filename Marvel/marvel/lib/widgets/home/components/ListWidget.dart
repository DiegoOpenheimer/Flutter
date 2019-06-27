import 'package:flutter/cupertino.dart';
import 'package:marvel/model/marvel-model.dart';
import 'package:marvel/services/marvelAPI.dart';
import 'package:meta/meta.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MarvelListWidget extends StatelessWidget {

  ScrollController _controller;
  List<Character> list;

  MarvelListWidget({
    @required ScrollController controller,
    @required this.list
  }) :
      assert(controller != null && list != null),
      this._controller = controller;

  @override
  Widget build(BuildContext context) {
    return _buildGridView(context);
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      cacheExtent: double.infinity,
      controller: _controller,
      padding: EdgeInsets.only(top: 8),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .7),
      itemBuilder: (context, index) {
        return _buildItemList(list[index], context);
      },
      itemCount: list.length,
    );
  }

  Widget _buildItemList(Character character, BuildContext context) {
    String extension = character?.thumbnail?.extension == Extension.GIF ? '.gif' : '.jpg';
    String pathImage = character.thumbnail != null ? '${character.thumbnail.path}${extension}?apikey=$apikey' : '';
    Widget first = pathImage.isNotEmpty ? Container(
      height: 300,
      decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(pathImage), fit: BoxFit.cover)),
    ) : Center(child: Text('Without image'),);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/information', arguments: { 'character': character, 'image': pathImage });
      },
      child: Column(
        children: <Widget>[
          Flexible(
            child: Hero(child: first, tag: character.id, transitionOnUserGestures: true,),
          ),
          Text(character.name, overflow: TextOverflow.ellipsis,),
          SizedBox(height: 8,)
        ],
      ),
    );
  }
}
