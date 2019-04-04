# dotfiles
Awesome dotfiles including vim, tex, ros and tmux configs.  
This dotfiles isn't completed yet. 

Some dotfiles are **disabled** temporary.  
>.ros_setup .ycm_extra_conf.py

## Release
Please refer to [Change log]()  
version 1.0.0

## Install 
Clone this repository onto your home directory.
```bash
$ git clone -- recursive https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ make init
$ make deploy
```

## Directory structure
Directory structure is as follows.

```
.
├── .tmuxinator
├── .vim
├── .etc
│   └── init
│       ├── init_for_docker.md
│       └── init_for_ubuntu.sh
├── Ricty
├── Docker
│   ├── build_command.md
│   ├── Dockerfile
│   └── docker-compose.yml
├── .aisl_ssh_list
├── .bash_profile
├── .bashrc
├── .gitconfig
├── .gitignore
├── .latexmkrc
├── .ros_setup
├── .tmux-powerlinerc
├── .tmux.conf
├── .tmuxautorun
├── .vimrc
├── .ycm_extra_conf.py
├── Makefile
└── README.md
```

## Make your own customizations
Create your dotfile on root directory of this repository.
```
$ make deploy
```

## Test in Docker
You can test this dotfile on the docker container.
```
$ cd Docker
$ docker build -t dotfile/test .
$ docker run -it --name dotfile dotfile/test bash

## On the container
# git config --global http.sslVerify false
# git clone https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git /root/dotfiles
# cd /root/dotfiles
# make init_docker
# make deploy
```

## Future work
- [x] Docker上でテスト
- [x] tmux,vimなどをカスタマイズ
- [ ] dotfilesを`curl -L`コマンドでダウンロード
- [x] zshも使ってみたいなあ
- [x] マルチプラットフォーム化（ubuntuとmacOSに対応，最初のインストールのみ）
- [ ] ワンコマンドで環境構築
- [ ] サブモジュール化する

## References
1. [common/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/common/dotfiles)
2. [MotokiKojima/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/MotokiKojima/dotfiles)
3. [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
4. [さいつよのターミナル環境を構築しよう](https://qiita.com/b4b4r07/items/09815eda8ef72e0b472e)
