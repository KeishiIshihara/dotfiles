# dotfiles
This dotfiles repository is made by drawing on: [b4b4r07/dotfiles](https://github.com/b4b4r07/dotfiles)  
Currently, I tend to have several workplaces and I use both macOS and Ubuntus with different CUDA versions, so at the moment it is necessary to maintain and host dotfiles at a remote repository. Therefore, these dotfiles are tuned for such platforms.  


## Features
Here is my current macOS environment features.
- **tmux**: 3.0a
- **zsh**: zsh 5.7.1 (x86_64-apple-darwin17.7.0)

## Installation
The easiest way to install the dotfiles with one-liner command:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/KeishiIshihara/dotfiles/master/etc/init/install)" -s init
```
However, the above command is equivalent to following typical procedures: 
```bash
$ git clone --recursive https://github.com/KeishiIshihara/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ make init # install packages and setup according to OS
$ make deploy # smlink dot files under the home directory 
```

**Note:** The dotfiles directory should be named as `~/dotfile`, not `~/.dotfile`.  

**Note:** If you are using macOS and you have not installed Xcode Command-line Tools, you would want to do this first:  
```terminal.app
$ xcode-select --install
```

## Primary commands
The dotfiles mostly go with `make` command. See `make help` for more targets infomation. Here is frequently used commands.
```bash
$ make shell   # show current os or env and set EXCLUSIONS
$ make list    # show dot files to be deployed
$ make deploy  # create symbolic link to home directory
$ make show    # show all dot files
$ make init    # setup environmental settings
```

## Setup

#### macOS
When setting up a new Mac, you might want to install Xcode Command-line Tools first.
```terminal.app
$ xcode-select --install
```
Second, install Homebrew which is a package manager (or you can just run the above one-liner installation command insted.)
```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
You also might not have new version of zsh. Download it with:
```bash
$ brew install zsh
```
Then, you have to edit /etc/shells
```bash
$ sudo vi /etc/shells
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/usr/local/bin/zsh  ## just add this line
```

#### Zsh
To change your shell to Zsh, use `chsh` command.
```bash
$ chsh -s $(which zsh)
```
**Note:** The shell that you wish to use must be present in the /etc/shells file. You can get the list of available shells or you may have to edit it:
```bash
$ sudo vi /etc/shells
```

## Remove dotfiles
You can also easily remove the entire dotfiles that are smlinked on home directory with a `~/dotfiles` directory altogether with one-liner:
```bash
$ make clean-dotfiles
```


**Note:** Normally, executing `rm -rf` command inadvertently is super dangerous, so I personally do not want to run it in a script, but it is necessary to have `make clean`. Therefore, there is an additional command for your safety:
```bash
$ make clean # This does nothing
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

## Troubleshooting 
#### Backspace not working 
For example, when you're asked username or password in shell, but you can not modify any of those you typed, just do:
```bash
$ stty erase "^?"
```

#### Remove selfmade functions or aliases
If you want to remove environment variables or functions you defined in a rc files, just do:
```bash
$ unalias alias-name
$ alias # confirm: alias list

$ unfunction func-name
$ which func-name # confirm: self-made function
```

### TODO
- [x] Installing test in an unseen environment(macOS).
- [x] Cleaning up test of this whole dotfile. 
- [x] Install via one line command
- [x] Pyenv install script
- [ ] Make sure which shell will be initialized after installing dotfiles. For such case that you are working on somewhere you don't want or must not change to zsh.
- [ ] Revise tmux-powerline
- [ ] Installing test at Ubuntu and modify documents accordingly.
- [ ] Installation docker, nvidia-docker, and cuda.
- [ ] Make it optional if some big software is needed (maybe for ubuntu).
- [ ] zgen

## References
1. [b4b4r07/dotfiles: A repository that gathered files starting with dot](https://github.com/b4b4r07/dotfiles)
2. [dotfiels (forked one from 1's repository)](https://github.com/amien8/dotfiles-b4b4r07)
3. [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
4. [さいつよのターミナル環境を構築しよう](https://qiita.com/b4b4r07/items/09815eda8ef72e0b472e)
