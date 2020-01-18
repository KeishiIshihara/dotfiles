# dotfiles
Cool dotfiles  
This dotfiles repository is made based on: [b4b4r07/dotfiles](https://github.com/b4b4r07/dotfiles)


## Installation
The easiest way to install the dotfiles:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/KeishiIshihara/dotfiles/master/etc/init/install)" -s init
```
However, the above command is equivalent to following typical procedures: 
```bash
$ git clone --recursive https://github.com/KeishiIshihara/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ make init # install packages and setup
$ make deploy # smlink dot files to home directory 
```
**Note:** the dotfiles directory should be named as `~/dotfile`, not `~/.dotfile`.  

**Note:** If you are using macOS and you have not installed Xcode, you would want to do this first:  
```terminal.app
$ xcode-select --install
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

## Setup
#### Zsh
To change your shell to Zsh, use `chsh` command.
```bash
$ chsh -s $(which zsh)
```
**Note:** The shell that you wish to use must be present in the /etc/shells file. You can get the list of available shells:
```bash
$ cat /etc/shells
```

#### macOS
When setting up a new Mac, you might want to install Xcode command-line tools first.
```terminal.app
$ xcode-select --install
```

### Trial on Docker (not confirmed)
for more checking purpose in advance.
```
$ cd Docker
$ docker build -t dotfile/test .
$ docker run -it --name dotfile dotfile/test bash

## On the container
# git config --global http.sslVerify false
# git clone https://github.com/KeishiIshihara/dotfiles.git /root/dotfiles
# cd /root/dotfiles
# make init_docker
# make deploy
```

### TODO
- [x] Installing test in an unseen environment(macOS).
- [x] Cleaning up test of this whole dotfile. 
- [x] Install via one line command
- [x] Pyenv install script
- [ ] Make sure which shell will be initialized after installing dotfiles. For such case that you are working on somewhere you don't want or must not change to zsh.

## Troubleshooting 
- Backspace not working when you're asked username or password in shell, just do:
```bash
$ stty erase "^?"
```
- Remove selfmade functions or aliases
```bash
# alias
$ unalias alias-name
$ alias # show alias list
# self-made function
$ unfunction func-name
$ which func-name # show self-made function
```

## References
1. [b4b4r07/dotfiles: A repository that gathered files starting with dot](https://github.com/b4b4r07/dotfiles)
2. [dotfiels (forked one from 1's repository)](https://github.com/amien8/dotfiles-b4b4r07)
3. [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
4. [さいつよのターミナル環境を構築しよう](https://qiita.com/b4b4r07/items/09815eda8ef72e0b472e)
