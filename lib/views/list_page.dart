import 'package:flutter/material.dart';
import '../db_helper/db_helper.dart';
import '../models/esma_model.dart';
import 'detail_page.dart';

List<EsmaModel> esmaList = [];

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var dbHelper = DBHelper();
    List<EsmaModel> getEsmaList = await dbHelper.getEsmas();
    setState(() {
      esmaList = getEsmaList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Esma-ul Husna'),
      ),
      body: ListView.builder(
        itemCount: esmaList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(
                          esmaModel: esmaList[index],
                        )),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Text(esmaList[index].id.toString()),
                  Image.memory(
                    esmaList[index].resim,
                    width: 100,
                    height: 100,
                  ),
                  Text(esmaList[index].isim),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
