# dotfiles
Cool dotfiles  
This dotfiles repository is made based on: [b4b4r07/dotfiles](https://github.com/b4b4r07/dotfiles), [aisl common/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/common/dotfiles)

### Release
Please refer to [change log](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles/blob/master/CHANGELOG.md) for more info.  
version 2.1

### TODO:
- [x] Installing test in an unseen environment(macOS).
- [x] Cleaning up test of this whole dotfile. 
- [ ] Make sure which shell will be initialized after installing dotfiles. For such case that you are working on somewhere you don't want or must not change to zsh.
- [ ] Maintain pyenv's versions and each requirements lists.
- [ ] Pyenv install script
- [ ] Install via one line command

## Install and deploy dotfiles
Clone this repository onto your home directory.
```bash
# Note that this dotfiles project should be named as '~/dotfile', not '~/.dotfile'
$ git clone --recursive https://aisl-serv6.aisl.cs.tut.ac.jp:20443/KeishiIshihara/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ make init
$ make deploy
```

## Primary commands
This dotfiles mostly go with `make` command. See `make help` for more info. Here is frequently used commands.
```bash
$ make shell   # show current os or env and set EXCLUSIONS
$ make list    # show dot files to be deployed
$ make deploy  # create symbolic link to home directory
$ make show    # show all dot files
$ make init    # setup environmental settings
```

### Testing on Docker (not confirmed)
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

## Troubleshooting 
Backspace not working when you're asked username or password in shell, just do:
```bash
$ stty erase "^?"
```
Remove selfmade functions or aliases
```bash
# alias
$ unalias alias-name
$ alias # show alias list
# self-made function
$ unfunction func-name
$ which func-name # show self-made function
```

#### あったら便利な機能とか
- [x] zsh導入(mac), 
- [x] マルチプラットフォーム化（aisl, mllab, macOSに対応）
- [ ] ワンコマンド環境構築(`curl -L`コマンド)

## References
1. [b4b4r07/dotfiles: A repository that gathered files starting with dot](https://github.com/b4b4r07/dotfiles)
1. [AISL GitLab common/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/common/dotfiles)
2. [MotokiKojima/dotfiles](https://aisl-serv6.aisl.cs.tut.ac.jp:20443/MotokiKojima/dotfiles)
3. [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
4. [さいつよのターミナル環境を構築しよう](https://qiita.com/b4b4r07/items/09815eda8ef72e0b472e)
5. [dotfiels](https://github.com/amien8/dotfiles-b4b4r07)
