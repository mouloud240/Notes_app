import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/Domain/usecases/addNote.dart';
import 'package:note_app/Domain/usecases/getNotes.dart';
import 'package:note_app/Presentation/Widgets/CutombuttonWigdet.dart';
import 'package:note_app/Presentation/Widgets/homeScreenNoteTile.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/data/models/NoteModel.dart';
import 'package:note_app/data/repos/notesRepoImplement.dart';
import 'package:note_app/data/source/local/LocalDataSource.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _searchController = TextEditingController();

  late Future<List<NoteModel>> _usersList;
  final _mybox = Hive.box<NoteModel>('notes');
  @override
  void initState() {
    _usersList = fetchUsers();
    super.initState();
  }

  Future<List<NoteModel>> fetchUsers() {
    return Getnotes(
            notesRepository: Notesrepoimplement(
                localdatasource: Localdatasource(notesBox: _mybox)))
        .call();
  }

  Future<void> handleButtonClick(NoteModel note) async {
    await AddNote(
            notesRepo: Notesrepoimplement(
                localdatasource: Localdatasource(notesBox: _mybox)))
        .call(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: CustomButtonWidget(
        buttonIcon: Icons.add,
        onclickFuntction: () {
          Navigator.of(context).pushNamed("plusTapScreen");
        },
      ),
      backgroundColor: Appcolors.black,
      bottomNavigationBar: BottomAppBar(
        color: Appcolors.backgroundColor,
      ),
      body: ValueListenableBuilder(
        valueListenable: _mybox.listenable(),
        builder: (context, box, widget) {
          _usersList = fetchUsers();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              //Todo:fix the scroll behavior
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Hello,\nMy Notes",
                        style: TextStyle(
                            color: Appcolors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40)),
                    SvgPicture.asset("assets/icons/setting.svg")
                  ],
                ),
                TextField(
                  controller: _searchController,
                  style:
                      const TextStyle(color: Appcolors.lightgrey, fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Appcolors.darkGrey,
                      hintText: "Search Here",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 32,
                      ),
                      prefixIconColor: Appcolors.lightgrey,
                      hintStyle: const TextStyle(
                          color: Appcolors.lightgrey, fontSize: 20)),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _usersList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<NoteModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Homescreennotetile(
                              note: snapshot.data![index],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
