/*
 アプリ名:　タイピング練習アプリ
 使い方　:　押してほしいキーが表示されるので、そのキーを入力していく。
 注意　　:　チュートリアルなし
 */
//グローバル変数
boolean[] press=new boolean[26];// キーが押されたかどうか(true, false)
boolean enterflg=false;//enterキーが押されたかどうか(trueのときキーを入力する)
char[] keyboard_key=new char[26];//キーボードのキー
char[] nyuuryoku_key=new char[16];//入力してほしいキー(computer)
char[] nyuuryoku_key1=new char[16];//入力したキー(player)
int keynum=0;//正しく入力したキーの数
int level=5;//タイピングレベル
int hanabinum=0;//花火の個数を決める変数
int countnum=0;//時間を格納している配列の要素数
int congratulation=0;//new record congratulations!」と表示するかどうかを決める変数
int perfectflg=0;//入力されたキーが全て正しく押されたかどうかを決める変数
int[] count=new int[1000];//タイピングにかかった時間を格納していく
float r=0;//花火の大きさを決める変数
float[] x=new float[10];//花火が発生するx座標を格納している配列
float[] y=new float[10];//花火が発生するy座標を格納している配列

//char[] alphabet=new char [26];
//-----
void setup() {
  size(900, 950);// 背景のサイズ
  background(0);//背景は黒

  PFont font = createFont("Arial", 50);//フォントを動的に作成する（"フォントの名前" , フォントの大きさ）
  textFont(font);//フォントを指定

  init();//初期化を行う関数
  /*
  for (int i=0; i<100; i++) {
   println(i+" "+char(i) );// コンソール表示
   }
   println("-----");
   for (int i=0; i<26; i++) {
   alphabet[i] = char(i+65);
   println(i+" "+alphabet[i] );// コンソール表示
   }
   */
}
//-----
void init() {
  for (int i=0; i<26; i++) {
    press[i]=false;
  }
  //キーボードのキー
  keyboard_key[0]='Q';
  keyboard_key[1]='W';
  keyboard_key[2]='E';
  keyboard_key[3]='R';
  keyboard_key[4]='T';
  keyboard_key[5]='Y';
  keyboard_key[6]='U';
  keyboard_key[7]='I';
  keyboard_key[8]='O';
  keyboard_key[9]='P';
  keyboard_key[10]='A';
  keyboard_key[11]='S';
  keyboard_key[12]='D';
  keyboard_key[13]='F';
  keyboard_key[14]='G';
  keyboard_key[15]='H';
  keyboard_key[16]='J';
  keyboard_key[17]='K';
  keyboard_key[18]='L';
  keyboard_key[19]='Z';
  keyboard_key[20]='X';
  keyboard_key[21]='C';
  keyboard_key[22]='V';
  keyboard_key[23]='B';
  keyboard_key[24]='N';
  keyboard_key[25]='M';
  for (int i=0; i<10; i++) {
    x[i]=random(70, 580);//花火が発生するx座標を格納している配列
    y[i]=random(610, 910);//花火が発生するy座標を格納している配列
  }
}
//-----
void draw() {
  background(0);//背景は黒

  update();//パラメータを更新する関数
  showkeyboard();//キーボードを表示する関数
  showkey();//入力してほしいキーまたは入力したキーを表示する関数
  message();//メッセージを表示する関数
  besttime();//タイピングにかかった時間が最速だったかどうかを判定する関数
  score_sort();//時間を格納している配列を小さい順に並べる関数
  score_hyo();//スコア表を表示する関数
  ennsyutu();//演出を入れる関数
  if (enterflg==false && congratulation==countnum-1 &&countnum>0) {
    r++;//花火の大きさを大きくする
    r=r%200;
    if (r==0) {
      if (hanabinum<10) {
        hanabinum++;//花火の個数を増やす
      } else {
        hanabinum=0;//花火の個数を0にする
      }
    }
  }
}
//-----
void update() {//パラメータを更新する関数
  if (enterflg==false) {
    for (int i=0; i<26; i++) {
      press[i]=false;// キーが押されたかどうか
    }
    for (int i=0; i<16; i++) {
      nyuuryoku_key[i]=' ';//入力して欲しいキー
    }
    for (int i=0; i<16; i++) {
      nyuuryoku_key1[i]=' ';//入力したキー
    }
    keynum=0;//正しく入力したキーの数を0にする
    perfectflg=0;
  }

  if (enterflg==true) {
    for (int i=0; i<16; i++) {
      if (nyuuryoku_key[i]==' ') {
        nyuuryoku_key[i]=keyboard_key[int(random(26))];//入力して欲しいキー
      }
    }
    count[countnum]++;//時間を増やす
    congratulation=0;//new record congratulations!」と表示するかどうかを決める変数を0にする
    hanabinum=0;//花火の個数を0にする
    r=0;//花火の大きさをリセットする
  }
}
//-----
void ennsyutu() {//演出を入れる関数
  float x1, y1;

  textAlign(CENTER, CENTER);//テキストの配置方法
  //枠を作成する
  stroke(200);//灰色の線
  strokeWeight(10);//線の太さ
  fill(0);//黒色で塗り潰す
  rect(50, 590, 550, 340);//四角形をつくる

  //最初の画面に「タイピングの練習」と表示する
  if (enterflg==false&& countnum==0) {

    fill(255);//文字の色
    textSize(65);//テキストのサイズ
    text("タイピングの練習", 320, 750);
  }
  //キーの入力の時に、「コンピュータの指示したキーを入力せよ」と表示する
  if (enterflg==true) {
    fill(255);//文字の色
    textSize(40);//テキストのサイズ
    text("コンピュータの指示した", 330, 720);
    text("キーを入力せよ !", 270, 780);
  }
  //新記録を出した時の花火を表示する
  if (enterflg==false && congratulation==countnum-1 &&countnum>0) {
    colorMode(HSB, 360, 100, 100);
    for (int i=0; i<hanabinum; i++) {
      fill(random(360), 100, 100);//ランダムで塗りつぶす
      noStroke();//円周を表示しない
      for (int j=0; j<360; j=j+10) {
        x1=x[i]+r*cos(radians(j));
        y1=y[i]-r*sin(radians(j));
        if (x1>60 && x1<590 && y1<920 && y1>600) {
          ellipse(x1, y1, 3, 3);//円を表示する
        }
      }
    }
    colorMode(RGB, 255);
  }
  //新記録を出せなかった時にランキング順位とメッセージを表示する
  if (enterflg==false && congratulation!=countnum-1 &&countnum>0) {

    fill(255);//文字の色
    textSize(40);//テキストのサイズ
    text("ランキング順位", 280, 720);
    fill(255, 255, 0);//文字の色
    textSize(50);//テキストのサイズ
    text(countnum-congratulation, 480, 717);
    fill(255);//文字の色
    textSize(40);//テキストのサイズ
    text("新記録を目指そう !", 315, 780);
  }
}
//-----
void score_sort() {//時間を格納している配列を小さい順に並べる関数
  int min, dummy;

  if (enterflg==false&&countnum>0) {
    for (int i=0; i<countnum-1; i++) {
      min=i;
      for (int j=i+1; j<countnum; j++) {
        if (count[j]<count[min]) {
          min=j;
        }
      }
      dummy=count[i];
      count[i]=count[min];
      count[min]=dummy;
    }
  }
}
//-----
void score_hyo() {//スコア表を表示する関数
  textAlign(CENTER, CENTER);//テキストの配置方法

  //「Score Ranking」と表示する
  fill(255, 0, 0);//赤色のテキスト
  textSize(30);//テキストのサイズ
  text("Score Ranking", 750, 520);
  //枠を作る
  stroke(255, 0, 0);//赤色の線
  strokeWeight(2);//線の太さ
  fill(0);//黒色で塗り潰す
  rect(650, 550, 240, 390);//四角形をつくる
  //スコアを表示する
  fill(255);//白色のテキスト
  for (int i=1; i<=10; i++) {
    textSize(30);//テキストのサイズ
    text(i, 670, 570+37*(i-1));//順位を表示する
    text(":", 695, 570+37*(i-1));//「:」を表示する
    textSize(20);//テキストのサイズ
    text("sec", 860, 575+37*(i-1));//「sec」と表示する
  }
  for (int i=0; i<10; i++) {
    if (count[i]!=0&&i<countnum) {
      textSize(30);//テキストのサイズ
      text(count[i]/60.0, 765, 570+37*i);//時間を表示する
    }
  }
}
//-----
void besttime() {//タイピングにかかった時間が最速だったかどうかを判定する関数
  if (enterflg==false&&countnum>0&&congratulation==0) {
    for (int i=0; i<countnum; i++) {
      if (countnum==1) {
        congratulation=0;
      } else if (count[i]>count[countnum-1]) {//最新の入力時間とそれまでの入力時間を比較する
        congratulation++;
      }
    }
  }
}
//-----
void message() {//メッセージを表示する関数
  //タイピングレベルの表示
  fill(255);//白色のテキスト
  textSize(30);//テキストのサイズ
  text("level:", 425, 450);
  text(level, 480, 450);
  //「Please press the enter key」と表示
  fill(255);//白色のテキスト
  if (enterflg==false) {
    text("Please press the enter key", 425, 500);
  }
  for (int i=0; i<level; i++) {
    if (nyuuryoku_key[i]==nyuuryoku_key1[i]) {
      perfectflg++;
    }
  }
  if (enterflg==true && keynum==level-1 && perfectflg==level) {
    text("Please press the enter key", 425, 500);
  }
  perfectflg=0;
  //「new record congratulations!」と表示
  fill(255, 255, 0);//黄色のテキスト
  if (enterflg==false) {
    if (congratulation==countnum-1) {
      text("new record congratulations!", 420, 550);
    }
  }
  //経過した時間の表示
  fill(255);//白色のテキスト
  if (enterflg==true) {
    text(count[countnum]/60, 420, 550);
    text("second", 500, 550);
  }
}
//-----
void showkey() {//入力して欲しいキーまたは入力したキーを表示する関数
  strokeWeight(2);//線の太さ
  textAlign(CENTER, CENTER);//テキストの配置方法

  //入力して欲しいキーの表示
  fill(0, 255, 0);//緑色のテキスト
  stroke(0, 255, 0);//緑色の線
  textSize(20);//テキストのサイズ
  text("Computer:", 50, 70);
  textSize(40);//テキストのサイズ
  for (int i=0; i<level; i++) {
    text(nyuuryoku_key[i], 125+40*i, 70);
  }
  line(100, 100, 800, 100);//線の表示

  //入力したキーの表示
  fill(0, 200, 255);//青色のテキスト
  stroke(0, 200, 255);//青色の線
  textSize(20);//テキストのサイズ
  text("Player:", 50, 150);
  textSize(40);//テキストのサイズ
  if (enterflg==true) {
    for (int i=0; i<keynum+1; i++) {
      text(nyuuryoku_key1[i], 125+40*i, 150);
    }
  }
  line(100, 180, 800, 180);//線の表示
  if (enterflg==true) {
    stroke(0, 200, 255);//青色の線
    line(115+40*keynum, 175, 135+40*keynum, 175);
  }
} 
//-----
void showkeyboard() {//キーボードを表示する関数
  stroke(255);//白色の囲み線
  strokeWeight(2);//囲み線の太さ
  textSize(50);//テキストのサイズ
  textAlign(CENTER, CENTER);//テキストの配置方法

  //囲み線の記述
  for (int i=0; i<10; i++) {
    if (press[i]==true && enterflg==true) {
      fill(255, 255, 0);//黄色で塗りつぶす
      press[i]=false;
    } else {
      fill(0);//黒色で塗り潰す
    }
    rect(100+70*i, 200, 70, 70);
  }
  for (int i=0; i<9; i++) {
    if (press[i+10]==true && enterflg==true) {
      fill(255, 255, 0);//黄色で塗りつぶす
      press[i+10]=false;
    } else {
      fill(0);//黒色で塗り潰す
    }
    rect(150+70*i, 270, 70, 70);
  }
  for (int i=0; i<7; i++) {
    if (press[i+19]==true && enterflg==true) {
      fill(255, 255, 0);//黄色で塗りつぶす
      press[i+19]=false;
    } else {
      fill(0);//黒色で塗り潰す
    }
    rect(200+70*i, 340, 70, 70);
  }
  //テキストの記述
  fill(255);//文字の色
  for (int i=0; i<10; i++) {
    text(keyboard_key[i], 135+70*i, 235);
  }
  for (int i=0; i<9; i++) {
    text(keyboard_key[i+10], 185+70*i, 305);
  }
  for (int i=0; i<7; i++) {
    text(keyboard_key[i+19], 235+70*i, 375);
  }
}
//-----
void keyReleased() {
  for (int i=0; i<26; i++) {
    if (keyCode==keyboard_key[i]) {
      if (nyuuryoku_key1[keynum]==' ') {
        nyuuryoku_key1[keynum]=keyboard_key[i];
      }
      if (nyuuryoku_key1[keynum]==nyuuryoku_key[keynum]) {
        if (keynum<level-1) {
          keynum++;
        } else {
          keynum=level-1;
        }
      }
      press[i]=true;//
    }
  }
  if (keyCode==ENTER) {
    if (enterflg==false) {
      enterflg=true;//キーを入力できるようにする
    } else {
      //入力されたキーが全て正しく押されたかどうか
      for (int i=0; i<level; i++) {
        if (nyuuryoku_key[i]==nyuuryoku_key1[i]) {
          perfectflg++;
        }
      }
      if ((keynum+1)==level && perfectflg==level) {
        countnum++;//時間を格納している配列の要素数を一つ増やす
        enterflg=false;//キーの入力を終える
      }
      perfectflg=0;
    }
  }
  if (keyCode==UP) {
    if (enterflg==false) {
      if (level<16) {
        level++;//タイピングレベルを増やす
      } else {
        level=16;//タイピンレベルを16にする
      }
    }
  }
  if (keyCode==DOWN) {
    if (enterflg==false) {
      if (level>1) {
        level--;//タイピングレベルを減らす
      } else {
        level=1;//タイピングレベルを1にする
      }
    }
  }
  if (keyCode==BACKSPACE) {
    if (enterflg==true) {
      if (keynum>=0 ) {
        nyuuryoku_key1[keynum]=' ';
      }
    }
  }
}
//-----
