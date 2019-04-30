# Change Log

## 1.1.0
Released on 2019-04-30
変更点
* tmux-powerlineをカスタマイズ 

コメント
* tmux-powerlineのカスタマイズ方法
    - theme/に自分用のテーマを書いたシェルスクリプトを入れる
    - powerline.sh (right or left)の出力に従ってステータスバーが表示される
    - 各々の表示を細かく編集したい場合はconfig/defaults.sh内のテーマ名を指定した後に，
       generate_rc.shを実行し.tmux-powerlinerc.defaultを作成
       その後，.tmux-powerlinercという名前でコピーを作成
* 今回は.tmux-powerlinercがうまく実行できなかったので，天気の表示などはあきらめた．wifi(自作コマンド)の表示はできた．


## 1.0.0 
Released on 2019-04-03

変更点
* 初期ツールのインストールはUbuntuとmacOSで分離
* tmux, vimをプラグイン込みである程度カスタマイズ  
  wifi強度, battery残量の表示, Backspaceの動作修正
* zshを導入（macOSのみ）  
    プロンプト，プラグイン，フォントなどの設定

次回予定
- [ ] tmuxinator起動時の動作の修正  
  デフォルトコマンド，画面配置など
- [x] Powerlineの修正
* [x] fontsのインストール設定修正
* [Powerline fontsをインストール](https://qiita.com/park-jh/items/557a9d5b470947aef2f5#powerline-fonts%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB) を参考にpowerlineのフォントインストールを自動化 (install.shの実行)
* [ ] ubuntuでtestする
