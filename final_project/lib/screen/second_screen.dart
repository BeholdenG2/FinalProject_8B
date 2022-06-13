import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class SecondScreen extends StatefulWidget{
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  final controllerPercent = TextEditingController();

  void setDefaultValues(double value)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent', value);
  }

  Future<double?>getDefaultValues()async{
    final prefs = await SharedPreferences.getInstance();
    final double percent = prefs.getDouble('percent')??15;

    return percent;
  }
  

  @override
  Widget build(BuildContext context) {

    getDefaultValues().then((value) => {
      controllerPercent.text = value.toString()
    });

    const fontHeaders = TextStyle(fontSize: 30, color: Color.fromARGB(255, 0, 0, 0));
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255), appBar: AppBar(title: const Text("Configuration"), backgroundColor: Colors.purple, elevation: 0,),
      drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.purple,
          ),
          child: Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home, color: Colors.purple, size: 24.0,),
          title: Text('Home Screen'),
          onTap: () {
            final route = MaterialPageRoute(builder: (context) => const HomeScreen());
            Navigator.push(context, route);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings, color: Colors.purple, size: 24.0,),
          title: Text('Configuration'),
          onTap: () {
            final route = MaterialPageRoute(builder: (context) => const SecondScreen());
            Navigator.push(context, route);
          },
        ),
      ],
    ),
  ), 

      body: Center( 
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField( 
            controller: controllerPercent,
            cursorColor: Colors.purple,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 1.5),),
              labelText: 'Percent', labelStyle: TextStyle(color: Colors.purple)
            ),
          ),
        ),
        
        ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),),
        onPressed: (){
          setState(() {
            double percent = double.parse(controllerPercent.text);
            setDefaultValues(percent);
          });
              }, child: const Text("Save"))
      ],
    )
      )
          );
  }
}
