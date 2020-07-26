import 'package:flutter/material.dart';
import 'package:flutter_breaking_bad/config/injection.dart';
import 'package:flutter_breaking_bad/controllers/home_controller.dart';
import 'package:flutter_breaking_bad/models/character_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller;

  @override
  void initState() {
    controller = getIt<HomeController>();
    controller.getAllCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(),
            Expanded(
              child: Observer(builder: (_) {
                if (controller.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.characters.isNotEmpty) {
                  return ListView.builder(
                      itemCount: controller.characters.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        Character character = controller.characters[index];
                        return ListItem(character: character);
                      });
                }
                return Container();
              }),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Character character;

  const ListItem({
    Key key,
    this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 15,
            offset: Offset(0, 45),
            spreadRadius: -50,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 20),
      height: 250,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ClipRRect(
              child: Image.network(
                character.img,
                height: 250,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        character.name,
                        style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                      Text(character.nickname, style: GoogleFonts.roboto(color: Colors.grey)),
                      Text(character.category, style: GoogleFonts.roboto(color: Colors.grey)),
                      Text(character.status, style: GoogleFonts.roboto(color: Colors.grey)),
                      Text(character.portrayed, style: GoogleFonts.roboto(color: Colors.grey)),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Breaking Bad',
              style: TextStyle(
                fontFamily: 'HeartBreakingBad',
                fontSize: 45,
              )),
          GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/lupa.png',
                scale: 2.5,
              )),
        ],
      ),
    );
  }
}
