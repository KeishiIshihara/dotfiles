# dotfiles
Awesome dotfiles including vim, tex, ros and tmux configs.  
Developing in progress.

## TODO
- [x] Makefile作成
- [x] とりあえずmacOSに最適化
- [ ] macOS版.tmux.configを作成
- [ ] Ubuntu用に処理を分ける
- [ ] マルチプラットフォーム化
- [ ] ワンコマンドで環境構築
- [ ] サブモジュール化する
- [ ] git pushなども自動化(?)
- [ ] その他のconfigを随時更新


Some dotfiles are **disabled** temporary.  
> .bashrc .ros_setup .vim .vimrc .ycm_extra_conf.py

## Install
Clone this repository onto your home directory.
```bash
$ cd && git clone https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git
$ cd dotfiles
$ make install
```
<!-- 
## Structure
```
dotfiles   
├ .tmuxinator
├ .vim
├ Ricty
├ etc
├ 
├  

``` -->

## Make your own customizations
Create your dotfile on root directory of this repository.
```
$ make deploy
```

## References

1. [common/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/common/dotfiles)
2. [MotokiKojima/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/MotokiKojima/dotfiles)
3. [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)