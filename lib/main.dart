import 'package:flutter/material.dart';
import 'music_add_page.dart';
import 'db_provider.dart';

void main() => runApp(Siggmo());

class Siggmo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // ダークモード
        brightness:Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF212121),
        accentColor: const Color(0xFF64ffda),
        canvasColor: const Color(0xFF303030),
      ),
      // リスト一覧画面を表示
      home: MainPage(),
    );
  }
}

// リスト一覧画面用Widget
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 曲一覧を取得
  List<String> musicList = [];

  //画面読み込み時にDBから曲一覧を取得する
  _MainPageState(){
    //DBクラスを呼び出す
    DatabaseFactory factory = DatabaseFactory();
    late SiggmoDao helper = SiggmoDao(factory);

    // 曲一覧を取得
    helper.mainAllFetch().then((value) => print("value = ${value!.musicId}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: Text('登録曲一覧'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () => test(),
          )
        ]
      ),
      body: ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(musicList[index]),
              onTap:(){
                print("onTap called");
              },
              onLongPress:() {
                print("onLongTap called.");
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // "push"で新規画面に遷移
          // 曲追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return MusicAddPage();
            }),
          );
          if(newListText != null){
            // キャンセルした場合は返り値がnullとなるので注意
            setState(() {
              // リスト追加
              musicList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void test(){
    //DBクラスを呼び出す
    DatabaseFactory factory = DatabaseFactory();
    late SiggmoDao helper = SiggmoDao(factory);

    // 曲一覧を取得
    helper.mainAllFetch().then((value) =>
        //print("value = ${value!.musicId}")
      print(value!.musicId)
    );
  }
}

