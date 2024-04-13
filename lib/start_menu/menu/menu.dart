import 'package:fianal/logo_image/my_drawer_header.dart';
import 'package:fianal/start_menu/menu_pages/about_us.dart';
import 'package:fianal/start_menu/menu_pages/history.dart';
import 'package:fianal/start_menu/menu_pages/hostel_map.dart';
import 'package:fianal/start_menu/menu_pages/hostels.dart';
import 'package:fianal/start_menu/menu_pages/log_in.dart';
import 'package:fianal/start_menu/menu_pages/members.dart';
import 'package:fianal/start_menu/menu_pages/news.dart';
import 'package:fianal/start_menu/menu_pages/precautionary_advice.dart';
import 'package:fianal/start_menu/menu_pages/services.dart';
import 'package:fianal/start_menu/menu_pages/videos.dart';
import 'package:fianal/start_menu/menu_pages/volunteer_hub.dart';
import 'package:fianal/start_menu/menu_pages/welcome.dart';

import 'package:flutter/material.dart';

class StartMenuPage extends StatefulWidget {
  @override
  _MenuHomeState createState() => _MenuHomeState();
}

class _MenuHomeState extends State<StartMenuPage> {
  var currentPage = DrawerSections.welcome;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.welcome) {
      container = WelcomePage();
    } else if (currentPage == DrawerSections.history) {
      container = HistoryPage();
    } else if (currentPage == DrawerSections.services) {
      container = ServicesPage();
    } else if (currentPage == DrawerSections.news) {
      container = NewsPage();
    } else if (currentPage == DrawerSections.videos) {
      container = VideosPage();
    } else if (currentPage == DrawerSections.hostels) {
      container = HostelsPage();
    } else if (currentPage == DrawerSections.hostel_map) {
      container = HostelMapPage();
    } else if (currentPage == DrawerSections.precautionary_advice) {
      container = PrecautionaryAdvicePage();
    } else if (currentPage == DrawerSections.members) {
      container = MembersPage();
    } else if (currentPage == DrawerSections.volunteer_hub) {
      container = VolunteerHubPage();
    } else if (currentPage == DrawerSections.about_us) {
      container = AboutUsPage();
    } else if (currentPage == DrawerSections.log_in) {
      container = LogInPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text("           Defensa Civil App"),
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
          menuItem(1, "Inicio", Icons.home,
              currentPage == DrawerSections.welcome ? true : false),
          menuItem(2, "Historia", Icons.create_outlined,
              currentPage == DrawerSections.history ? true : false),
          menuItem(3, "Servicios", Icons.event,
              currentPage == DrawerSections.services ? true : false),
          menuItem(4, "Noticias", Icons.article,
              currentPage == DrawerSections.news ? true : false),
          menuItem(5, "Videos", Icons.videocam,
              currentPage == DrawerSections.videos ? true : false),
          menuItem(6, "Albergues", Icons.house,
              currentPage == DrawerSections.hostels ? true : false),
          menuItem(7, "Mapa de Albergues", Icons.map_outlined,
              currentPage == DrawerSections.hostel_map ? true : false),
          menuItem(8, "Medidas Preventiva", Icons.medical_services,
              currentPage == DrawerSections.precautionary_advice ? true : false),
          menuItem(9, "Miembros", Icons.group,
              currentPage == DrawerSections.members ? true : false),
          menuItem(10, "Quiero ser Voluntario", Icons.person_add,
              currentPage == DrawerSections.volunteer_hub ? true : false),
          Divider(),
          menuItem(11, "Acerca de", Icons.info,
              currentPage == DrawerSections.about_us ? true : false),
          menuItem(12, "Iniciar sesion", Icons.vpn_key,
              currentPage == DrawerSections.log_in ? true : false),
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
              currentPage = DrawerSections.welcome;
            } else if (id == 2) {
              currentPage = DrawerSections.history;
            } else if (id == 3) {
              currentPage = DrawerSections.services;
            } else if (id == 4) {
              currentPage = DrawerSections.news;
            } else if (id == 5) {
              currentPage = DrawerSections.videos;
            } else if (id == 6) {
              currentPage = DrawerSections.hostels;
            } else if (id == 7) {
              currentPage = DrawerSections.hostel_map;
            } else if (id == 8) {
              currentPage = DrawerSections.precautionary_advice;
            } else if (id == 9) {
              currentPage = DrawerSections.members;
            } else if (id == 10) {
              currentPage = DrawerSections.volunteer_hub;
            } else if (id == 11) {
              currentPage = DrawerSections.about_us;
            } else if (id == 12) {
              currentPage = DrawerSections.log_in;
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
  welcome,
  history,
  services,
  news,
  videos,
  hostels,
  hostel_map,
  precautionary_advice,
  members,
  volunteer_hub,
  about_us,
  log_in
}