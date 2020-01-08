# dotfiles
Cool dotfiles  


## Release
Please refer to [Change log](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles/blob/master/CHANGELOG.md)  
version 2.0


## Deploy dotfiles
Clone this repository onto your home directory.
```bash
$ git clone --recursive https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ make init
$ make deploy
```

## Primary commands
This dotfile mostly runs with `make`. See `make help` for more info.
```bash
$ make shell   # show current os or env and set EXCLUSIONS
$ make list    # show dot files to be deployed
$ make deploy  # create symbolic link to home directory
$ make show    # show all dot files
$ make init    # setup environmental settings
```

## Testing on Docker (not confirmed)
for more checking purpose in advance.
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

## あったら便利な機能とか
- [x] tmux,vimなどをカスタマイズ
- [x] zsh導入(mac)
- [x] マルチプラットフォーム化（aisl, mllab, macOSに対応）
- [ ] ワンコマンド環境構築(`curl -L`コマンド)

## References
1. [common/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/common/dotfiles)
2. [MotokiKojima/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/MotokiKojima/dotfiles)
3. [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
4. [さいつよのターミナル環境を構築しよう](https://qiita.com/b4b4r07/items/09815eda8ef72e0b472e)
