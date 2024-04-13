import 'package:fianal/logo_image/my_drawer_header.dart';
import 'package:fianal/menu_post_login/pages_post/change_password.dart';
import 'package:fianal/menu_post_login/pages_post/my_situation.dart';
import 'package:fianal/menu_post_login/pages_post/report_situation.dart';
import 'package:fianal/menu_post_login/pages_post/situation_map.dart';
import 'package:fianal/menu_post_login/pages_post/specific_news.dart';
import 'package:fianal/start_menu/menu/menu.dart';
import 'package:flutter/material.dart';

class MenuPostPage extends StatefulWidget {
  @override
  _MenuPostState createState() => _MenuPostState();
}

class _MenuPostState extends State<MenuPostPage> {
  var currentPage = DrawerSections.noticias;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.noticias) {
      container = NoticiasPage();
    }else if (currentPage == DrawerSections.report_situation) {
      container = ReportSituationPage();
    } else if (currentPage == DrawerSections.my_situation) {
      container = MySituationPage();
    } else if (currentPage == DrawerSections.situation_map) {
      container = SituationMapPage();
    } else if (currentPage == DrawerSections.change_password) {
      container = ChangePasswordPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text("            Defensa Civil App"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Noticias Especificas", Icons.article_outlined,
              currentPage == DrawerSections.noticias ? true : false),
          menuItem(2, "Reportar Situacion", Icons.report_outlined,
              currentPage == DrawerSections.report_situation ? true : false),
          menuItem(3, "Mis Situaciones", Icons.list_alt_outlined,
              currentPage == DrawerSections.my_situation ? true : false),
          menuItem(4, "Mapa de situaciones", Icons.map_outlined,
              currentPage == DrawerSections.situation_map ? true : false),
          menuItem(5, "Cambiar Contraseña", Icons.edit_outlined,
              currentPage == DrawerSections.change_password ? true : false),
          menuItem(6, "Salir", Icons.exit_to_app,
              currentPage == DrawerSections.main ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.noticias;
            } else if (id == 2) {
              currentPage = DrawerSections.report_situation;
            } else if (id == 3) {
              currentPage = DrawerSections.my_situation;
            } else if (id == 4) {
              currentPage = DrawerSections.situation_map;
            } else if (id == 5) {
              currentPage = DrawerSections.change_password;
            }else if (id == 6) {
              currentPage = DrawerSections.main;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StartMenuPage()), // Reemplaza MenuPrincipalPage con el nombre de tu página de menú principal
              );
            }

          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections{
  noticias,
  report_situation,
  my_situation,
  situation_map,
  change_password,
  main,
}
