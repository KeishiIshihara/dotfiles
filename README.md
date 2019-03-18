# dotfiles
Awesome dotfiles including vim, tex, ros and tmux configs.  
This dotfiles isn't completed yet. 

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
- [ ] dotfiles for dockerも作ろうかな

Some dotfiles are **disabled** temporary.  
> .bashrc .ros_setup .vim .vimrc .ycm_extra_conf.py

## Install
Clone this repository onto your home directory.
```bash
$ cd && git clone https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git
$ cd dotfiles
$ make install
```

## Directory structure
Directory structure is as follows.

```
.
├── .tmuxinator
├── .vim
├── .etc
│   └── init
│       └── init_for_ubuntu.sh
├── Ricty
│   ├── Inconsolata
│   │   ├── Inconsolata-Bold.ttf
│   │   ├── Inconsolata-Regular.ttf
│   │   └── OFL.txt
│   └── migu-1m-20150712
│       ├── ipag00303
│       ├── mplus-TESTFLIGHT-060
│       ├── migu-1m-bold.ttf
│       ├── migu-1m-regular.ttf
│       └── migu-README.txt
├── .gitignore

-----
├── docker
│   └── data_lab
│       ├── Dockerfile
│       └── docker-compose.yml
├── keys
│   └── gcloud-secret.json
├── requirements.txt
├── ..others..
└── src
    ├── labs/__init__.py
    └── labs/awesomes/hogehoge.py
```

## Make your own customizations
Create your dotfile on root directory of this repository.
```
$ make deploy
```

## Docker container
You can test this dotfile on the docker container.
```
$ docker run --rm -it ununtu:latest bash

## On the container
# cd && git clone https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git
# cd dotfiles
# make install
```


## References

1. [common/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/common/dotfiles)
2. [MotokiKojima/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/MotokiKojima/dotfiles)
3. [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
