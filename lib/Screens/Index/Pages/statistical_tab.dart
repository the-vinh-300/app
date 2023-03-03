import 'package:demo_flutter/Screens/Index/Pages/Form/interface_inc.dart';
import 'package:flutter/material.dart';
import 'Form/interface_spe.dart';

class StatisTab extends StatelessWidget {
  const StatisTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisCustom();
  }
}

class StatisCustom extends StatefulWidget {
  StatisCustom({super.key});

  @override
  State<StatisCustom> createState() => _StatisCustomState();
}

class _StatisCustomState extends State<StatisCustom> {
  @override
  Widget build(BuildContext context) {
    //Tab bar
    return DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              child: const TabBar(tabs: [
                Tab(
                  child: Text(
                    'Chi tiêu',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Thu nhập',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ]),
            ),
            const Expanded(
                child: TabBarView(
              children: [
                //Chart spending
                StatisFormSpe(),
                //Chart income
                StatisFormInc()
              ],
            ))
          ],
        ));
  }
}
