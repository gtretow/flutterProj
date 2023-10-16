import 'package:flutter/material.dart';
import 'package:trilhaapp/model/marvel/newCharacters_model.dart';
import 'package:trilhaapp/repositories/marvel/newCharacters_repository.dart';

class MarvelCharacters extends StatefulWidget {
  const MarvelCharacters({super.key});

  @override
  State<MarvelCharacters> createState() => _MarvelCharactersState();
}

class _MarvelCharactersState extends State<MarvelCharacters> {
  final ScrollController _scrollController = ScrollController();

  late MarvelRepository marvelRepository;
  int offset = 0;
  var loading = false;
  CharactersModel characters = CharactersModel();
  @override
  void initState() {
    _scrollController.addListener(() {
      var autoScrollPosition = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > autoScrollPosition) {
        loadData();
      }
    });
    marvelRepository = MarvelRepository();
    super.initState();
    loadData();
  }

  loadData() async {
    if (loading) return;
    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        loading = true;
      });
      offset = offset + characters.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
      loading = false;
    }
    setState(() {});
  }

  int returnMaxHeroes() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int returnActualQuantity() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            'Marvel Characters count: ${returnActualQuantity()} of ${returnMaxHeroes()}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount:
                    characters.data == null || characters.data!.results == null
                        ? 0
                        : characters.data!.results!.length,
                itemBuilder: (_, int index) {
                  var character = characters.data!.results![index];
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "${character.thumbnail!.path!}.${character.thumbnail!.extension!}",
                          width: 150,
                          height: 150,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(character.description!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          !loading
              ? ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: const Text('Carregar mais itens'))
              : const CircularProgressIndicator()
        ],
      ),
    ));
  }
}
