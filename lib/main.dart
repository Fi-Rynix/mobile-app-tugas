import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nyobak Dashboard"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //container
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                "Halo",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            const SizedBox(height: 10),

            //row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 80, height: 80, color: Colors.red),
                Container(width: 80, height: 80, color: Colors.green),
                Container(width: 80, height: 80, color: Colors.orange),
              ],
            ),

            const SizedBox(height: 20),

            //stack
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250,
                  height: 120,
                  color: Colors.purple,
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.yellow,
                ),
                const Text("Profil"),
              ],
            ),

            const SizedBox(height: 20),

            //gridview
            Container(
              height: 200,
              margin: const EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    color: Colors.cyan,
                    child: Center(
                      child: Text("Fitur ${index + 1}"),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            //listviewa
            Container(
              height: 200,
              margin: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.lime,
                    child: Center(
                      child: Text("Activity ${index + 1}"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            //container dlm column
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.pink,
                  margin: const EdgeInsets.all(8),
                  child: const Center(child: Text("Kotak 1")),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.indigo,
                  margin: const EdgeInsets.all(8),
                  child: const Center(
                    child: Text(
                      "Kotak 2",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}