import 'package:flutter/material.dart';
import 'package:pokemon/Models/Pokemon.dart';
import 'package:pokemon/Models/PokemonModel.dart';
import 'package:pokemon/bloc/PokemonBloc.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:rounded_modal/rounded_modal.dart';

class PokemonView extends StatefulWidget {
  @override
  _PokemonViewState createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView>
    with AutomaticKeepAliveClientMixin<PokemonView> {
  PokemonBloc pokemonBloc = PokemonBloc();
  ProgressHUD _progressHUD;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    pokemonBloc.requestPokemonsFromService();
    _progressHUD = ProgressHUD(
      backgroundColor: Colors.black26,
      color: Colors.white,
      loading: false,
    );
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        pokemonBloc.fetchingMorePokemons();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    pokemonBloc.closeStreamController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildStream(context),
        _progressHUD,
      ],
    );
  }

  Widget buildStream(BuildContext context) => StreamBuilder<PokemonProvider>(
        stream: pokemonBloc.streamPokemon,
        builder:
            (BuildContext context, AsyncSnapshot<PokemonProvider> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.hasError == true)
              return buildError();
            else if (snapshot.data.isLoading == true)
              return loadingView();
            else
              return Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    child: buildSuccess(snapshot.data.pokemons),
                  ),
                  snapshot.data.isFetchingPokemon ? Column(
                    children: <Widget>[
                      SizedBox(height: 16,),
                      Center(child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),),
                      SizedBox(height: 16,),
                    ],
                  ) : null
                ].where((Widget widget) => widget != null).toList(),
              );
          } else {
            return loadingView();
          }
        },
      );

  Widget loadingView() => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );

  Widget buildError() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              size: 50.0,
              color: Colors.white,
            ),
            Text(
              'Erro, verifique sua conexão com a internet',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );

  Widget buildSuccess(List<PokemonModel> pokemons) => Scrollbar(
        child: GestureDetector(
          child: GridView.builder(
            controller: _controller,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemons[index].url.split('/')[6]}.png'),
                    Text(
                      pokemons[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                onTap: () {
                  _progressHUD.state.show();
                  pokemonBloc
                      .requestPokemonById(pokemons[index])
                      .then(showModalBottom)
                      .catchError((error) {
                    _progressHUD.state.dismiss();
                    print('ERRROR REQUEST, $error');
                  });
                },
              );
            },
            itemCount: pokemons.length,
          ),
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        ),
      );

  void showModalBottom(Pokemon pokemon) {
    _progressHUD.state.dismiss();
    showRoundedModalBottomSheet(
      context: context,
      radius: 10.0,
      color: Colors.white,
      builder: (context) => Flex(direction: Axis.vertical,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    child: Align(
                      alignment: Alignment(0, -4),
                      child: Image.network(
                        pokemon.img,
                        fit: BoxFit.cover,
                        height: 150.0,
                        width: 150.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70 ,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(pokemon.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                        Text('Weight: ${pokemon.weight.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text('Height: ${pokemon.height.toString()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: 10,),
                        Text('Types', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                direction: Axis.horizontal,
                                spacing: 10,
                                children: pokemon.types.map((Type type) => FilterChip(
                                  label: Text(type.type.name),
                                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                                  backgroundColor: Colors.amber,
                                  onSelected: (bool value) {},
                                )).toList(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text('Abilities', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child:Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceEvenly,
                                spacing: 5,
                                children: pokemon.abilities.map((Ability ab) => FilterChip(
                                  label: Text(ab.ability.name),
                                  labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                                  backgroundColor: Colors.blueAccent,
                                  onSelected: (bool value) {},
                                )).toList(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
