import 'package:flutter/material.dart';
import 'package:pragma_test/data/repositoriesImpl/breed_repo_impl.dart';
import 'package:pragma_test/models/responses/breed_response.dart';
import 'package:pragma_test/ui/delegates/search_breed_delegate.dart';
import 'package:pragma_test/ui/widgets/card_breed.dart';
import 'package:pragma_test/utils/extensions/color_extension.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController _searchContoller = TextEditingController();
  final repo = BreedRepositoryImpl();
  
  List<BreedResponse> breeds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBreeds();
  }

  Future<void> loadBreeds() async {
    try {
      final result = await repo.getBreeds();
      setState(() {
        breeds = result;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBGColor,
        key: _key,
        appBar: AppBar(
          title: const Text(
            'Catbreeds',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFD26934),
                  Color(0xFFFF9B44),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _searchInput(),
              const SizedBox(height: 16),
              Expanded(
                child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : breeds.isEmpty
                      ? const Center(child: Text('No se encontraron razas.'))
                      : ListView.builder(
                          itemCount: breeds.length,
                          itemBuilder: (context, index) {
                            final breed = breeds[index];
                            return CardBreed(
                              name: breed.name,
                              origin: breed.origin,
                              description: breed.description,
                              intelligence: breed.intelligence,
                              imageId: breed.referenceImageId,
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInput() {
    return TextFormField(
      focusNode: searchFocusNode,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Buscar por codigo',
        hintStyle: TextStyle(color: AppColor.inputColorGrey),
        contentPadding: const EdgeInsets.only(left: 20),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColor.textFieldBorderGrey,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColor.textFieldBorderGrey,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColor.textFieldBorderGrey,
            width: 0.5,
          ),
        ),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search, color: AppColor.inputColorGrey),
        ),
      ),
      controller: _searchContoller,
      onTap: () {
        showSearch(
          context: context,
          delegate: SearchBreedDelegate(
            initialBreeds: breeds,
            searchBreed: repo.searchBreed,
            getBreeds: repo.getBreeds,
          ),
        );
      },
    );
  }
}