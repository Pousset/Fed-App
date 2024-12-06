//import 'package:fedhubs_pro/screens/company_profile_edit.dart';

// ignore_for_file: unnecessary_new, deprecated_member_use

import 'package:fedhubs_pro/models/affluence/crowd_opening_indicator.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:fedhubs_pro/screens/sections_form/entreprise_timetable_page.dart';
import 'package:fedhubs_pro/screens/sections_form/menu/entreprise_menu_link_page.dart';
import 'package:fedhubs_pro/services/affluence/crowd_opening_indicator.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../sections_form/sect6_edit_comforts_availability.dart';
import '../sections_form/entreprise_information_page.dart';
import '../sections_form/sect2_edit_crowd_info.dart';
import '../sections_form/sect4_edit_general_info.dart';
import '../sections_form/sect8_edit_payment_info.dart';
import '../sections_form/sect7_edit_external_services.dart';
import '../sections_form/sect5_edit_social_network_links.dart';
import '../event_displays/event_list.dart';

class DirectControl extends StatefulWidget {
  final String idClient;
  const DirectControl(this.idClient, {Key? key}) : super(key: key);

  @override
  DirectControlState createState() => DirectControlState();
}

class DirectControlState extends State<DirectControl> {
  int currentTapIndex = 0;
  String appBarTitle = 'Control Center';
  //Future<ErrorHandlingUpdate> _updateData;
  late Future<CrowdOpeningIndicator?>? crowdOpeningIndicatorModel;
  CrowdOpeningIndicator modelInfoAffluence = CrowdOpeningIndicator();
  // Init color
  late Color _redLed, _orangeLed, _greenLed;
  late User user;
  late String jwt;

  @override
  void initState() {
    initial();
    crowdOpeningIndicatorModel =
        ApiAffluence().getCrowdOpeningIndicator(widget.idClient);
    modelInfoAffluence.idClient = widget.idClient;
    crowdOpeningIndicatorModel!.then((result) {
      if (!mounted) return;
      setState(() {
        modelInfoAffluence.crowdIndicator = result?.crowdIndicator;
        modelInfoAffluence.opening = result?.opening;
        _redLed = (result?.crowdIndicator == 3
            ? const Color(0xFFF44336)
            : const Color(0xFF607D8B));
        _orangeLed = (result?.crowdIndicator == 2
            ? const Color(0xFFFF5722)
            : const Color(0xFF607D8B));
        _greenLed = (result?.crowdIndicator == 1
            ? const Color(0xFF4CAF50)
            : const Color(0xFF607D8B));
      });
    });
    super.initState();
  }

  void initial() async {
    user = Provider.of<Auth>(context, listen: false).currentUser!;
    setState(() {
      jwt = user.token;
    });
  }

  onTapped(int index) {
    setState(() {
      currentTapIndex = index;
      if (currentTapIndex == 1) {
        appBarTitle = "Profil Entreprise";
      } else {
        appBarTitle = "Tableau de bord";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTapIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Profile',
          ),
        ],
      ),

      // APPBAR
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.black,
        actions: const <Widget>[
          /*IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){

            },
          )*/
        ],
      ),

      body: _buildControllerView(width),
    );
  }

  // buildView
  Widget _buildControllerView(width) {
    if (currentTapIndex == 0) {
      return FutureBuilder<CrowdOpeningIndicator?>(
        future: crowdOpeningIndicatorModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //var data = snapshot.data;
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: new Center(
                  child: new Column(
                    children: [
                      _buildOpeningButton(width),
                      const SizedBox(height: 10),
                      _buildControlCrowd(),
                      const SizedBox(height: 40),
                      _buildEventListButton(width),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(height: 10, width: 10, color: Colors.red),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    } else {
      return GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildFacadeWebsite(context),
              const SizedBox(height: 5),
              _buildAffluenceIndication(context),
              const SizedBox(height: 5),
              _buildWebsiteEssential(context),
              const SizedBox(height: 5),
              _buildTimeOpening(context),
              const SizedBox(height: 5),
              _buildSocialNetworks(context),
              const SizedBox(height: 5),
              _buildComfortAvailability(context),
              const SizedBox(height: 5),
              _buildServicesExt(context),
              const SizedBox(height: 5),
              _buildPaymentInfo(context),
              const SizedBox(height: 5),
              _buildCatalog(context),
              const SizedBox(height: 5),
              _disconnect()
            ],
          ),
        ),
      );
    }
  }

  Future<void> tricolorButtonState(var crowdIndex) async {
    if (crowdIndex == 3) {
      //print(modelInfoAffluence.crowdIndicator );
      setState(() {
        _redLed = const Color(0xFFF44336);
        _orangeLed = const Color(0xFF607D8B);
        _greenLed = const Color(0xFF607D8B);
        modelInfoAffluence.crowdIndicator = crowdIndex;
      });
    } else if (crowdIndex == 2) {
      //print(modelInfoAffluence.crowdIndicator );
      setState(() {
        _redLed = const Color(0xFF607D8B);
        _orangeLed = const Color(0xFFFF5722);
        _greenLed = const Color(0xFF607D8B);
        modelInfoAffluence.crowdIndicator = crowdIndex;
      });
    } else if (crowdIndex == 1) {
      //print(modelInfoAffluence.crowdIndicator );
      setState(() {
        _redLed = const Color(0xFF607D8B);
        _orangeLed = const Color(0xFF607D8B);
        _greenLed = const Color(0xFF4CAF50);
        modelInfoAffluence.crowdIndicator = crowdIndex;
      });
    } else {
      setState(() {
        _redLed = const Color(0xFF607D8B);
        _orangeLed = const Color(0xFF607D8B);
        _greenLed = const Color(0xFF607D8B);
        modelInfoAffluence.crowdIndicator = crowdIndex;
      });
    }
    ApiAffluence().putCrowdOpeningIndicator(modelInfoAffluence);
  }

  /* Start Control Center Edit page Widgets */
  Widget _buildOpeningButton(width) {
    //if((int.parse(data.opening) == 0 ? false : true)==true)
    if (modelInfoAffluence.opening == true) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        width: width,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              modelInfoAffluence.opening = false;
              modelInfoAffluence.crowdIndicator =
                  0; // a changer avec update affluence api
            });
            ApiAffluence().putCrowdOpeningIndicator(modelInfoAffluence);
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.green,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.vpn_key,
                color: Colors.white,
                size: 24.0,
              ),
              SizedBox(width: 8),
              Text('OUVERT', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10.0),
        width: width,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              modelInfoAffluence.opening = true;
              _redLed = (modelInfoAffluence.crowdIndicator == 3
                  ? const Color(0xFFF44336)
                  : const Color(0xFF607D8B));
              _orangeLed = (modelInfoAffluence.crowdIndicator == 2
                  ? const Color(0xFFFF5722)
                  : const Color(0xFF607D8B));
              _greenLed = (modelInfoAffluence.crowdIndicator == 1
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFF607D8B));
            });
            ApiAffluence().putCrowdOpeningIndicator(modelInfoAffluence);
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.red,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.lock,
                color: Colors.white,
                size: 24.0,
              ),
              SizedBox(width: 8),
              Text('FERMÉ', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildControlCrowd() {
    if (modelInfoAffluence.opening == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: new Container(
                width: MediaQuery.of(context).size.height / 11,
                height: MediaQuery.of(context).size.height / 11,
                decoration: new BoxDecoration(
                  color: _redLed,
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.height / 5),
                  border: new Border.all(
                    width: 3.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: new Container(
                width: MediaQuery.of(context).size.height / 11,
                height: MediaQuery.of(context).size.height / 11,
                decoration: new BoxDecoration(
                  color: _orangeLed,
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.height / 5),
                  border: new Border.all(
                    width: 3.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: new Container(
                width: MediaQuery.of(context).size.height / 11,
                height: MediaQuery.of(context).size.height / 11,
                decoration: new BoxDecoration(
                  color: _greenLed,
                  borderRadius: new BorderRadius.circular(
                      MediaQuery.of(context).size.height / 5),
                  border: new Border.all(
                    width: 3.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            new RawMaterialButton(
              onPressed: () {
                tricolorButtonState(3);
              },
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
              child: new Icon(
                Icons.directions_walk,
                color: Colors.red,
                size: MediaQuery.of(context).size.height / 20,
              ),
            ),
            const SizedBox(height: 30),
            new RawMaterialButton(
              onPressed: () {
                tricolorButtonState(2);
              },
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
              child: new Icon(
                Icons.directions_walk,
                color: Colors.orange,
                size: MediaQuery.of(context).size.height / 20,
              ),
            ),
            const SizedBox(height: 30),
            new RawMaterialButton(
              onPressed: () {
                tricolorButtonState(1);
              },
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
              child: new Icon(
                Icons.directions_walk,
                color: Colors.green,
                size: MediaQuery.of(context).size.height / 20,
              ),
            ),
          ]),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
            'Merci de bien vouloir activer au minimum vos ouvertures et fermetures de votre commerce lors de vos activités.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      );
    }
  }

  Widget _buildEventListButton(width) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EventListPage()));
        },
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          backgroundColor: const Color(0xFFE8EAF6),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.calendar_today,
              color: Colors.black,
              size: 24.0,
            ),
            SizedBox(width: 8),
            Text('ÉVÉNEMENTS',
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
      ),
    );
  }
  /* End Control Center Edit page Widgets */

  /* Start Profile Edit page Widgets */
  Widget _buildFacadeWebsite(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Façade du site web",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EntrepriseInformationPage()));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Image de fond\nLogo\nNom de l'entreprise\nSpécialité\nDescription",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAffluenceIndication(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Information sur l'affluence",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormEditAfflluenceInfoPage(widget.idClient)));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Temps d'attente ou message au feu rouge\nTemps d'attente ou message au feu orange\nTemps d'attente ou message au feu vert\nIndications supplémentaires",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildWebsiteEssential(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Informations essentiel",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormEditEssentialInfoPage(widget.idClient)));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "N° de téléphone\nEmail\nLien du site web\nAdresse physique",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTimeOpening(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Horaire d'ouverture",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              //builder: (context) => FormEditTimeOpeningInfoPage()));
                              builder: (context) =>
                                  const EntrepriseTimetablePage()));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Horaire du lundi\nHoraire du mardi\nHoraire du mercredi\nHoraire du jeudi\nHoraire du vendredi\nHoraire du samedi\nHoraire du dimanche",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSocialNetworks(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Réseaux sociaux",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormEditSocialNetworksLinkInfoPage(
                                      widget.idClient)));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Lien Facebook\nLien Instagram\nLien Linkedin\nLien Twitter\nLien Youtube\nLien Pinterest\nLien Snapchat\nLien Tiktok",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildComfortAvailability(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Conforts disponible",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormEditComfortAvailabilityPage(
                                      widget.idClient)));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Toilette\nWifi\nTV\nMusique, etc...",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildServicesExt(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Services rendu",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormEditServicesExtInfoPage(
                                  widget.idClient)));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Vente sur place\nVente à emporté\nLivraison",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Mode de paiement info",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormEditPaymentInfoPage(widget.idClient)));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Espèce\nCarte & PIN\nPaiment sans contact\n...",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCatalog(context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Expanded(
                flex: 6,
                child: Text(
                  "Lien des catalogues",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EntrepriseMenuLinkPage()));
                    },
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Produits vendu\nou\nServices vendu",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _disconnect() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          await Provider.of<Auth>(context, listen: false).signOut();
        },
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          backgroundColor: const Color(0xFFE24F4F),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
              size: 24.0,
            ),
            SizedBox(width: 8),
            Text('Déconnexion',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
    );
  }
  /* End Profile Edit page Widgets */

}
