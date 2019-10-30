#variables # Now suited to my mac
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
# EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml bin .tmux-powerlinerc.default .latexmkrc .bash_profile .bashrc .zsh .zshenv .zshrc .aisl_ssh_list .gitconfig
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

#command : here are for better understanding
find_files  = /bin/ls -dF $(val);
make_symlinks =  ln -sfnv $(abspath $(val)) $(HOME)/$(val);

# default target to run
.DEFAULT_GOAL := list

# all our targets are phony (no files to check).
.PHONY : shell show list deploy init init_docker update install help


shell: ## Show current os and set EXCLUSIONS
ifeq  ($(shell uname),Darwin) 
	@echo 'Hello Mac'
	$(eval ENV := $(shell uname))
	$(eval EXCLUSIONS := .DS_Store .git .gitignore .gitmodules bin .tmux-powerlinerc.default .vim)
	$(eval DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES)))
else
	@echo 'Hello Linux'
	$(eval ENV := $(shell uname))
	$(eval EXCLUSIONS := .DS_Store .git .gitignore .gitmodules bin .tmux-powerlinerc.default .latexmkrc .bash_profile .bashrc .zsh .zshenv .zshrc .aisl_ssh_list .vim)
	$(eval DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES)))
endif


show: ## Show all dotfiles
	@echo $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
	@echo $(wildcard .??*)

list: shell## Show dot files to be deployed
	@$(foreach val, $(DOTFILES), $(find_files))

deploy: shell ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), $(make_symlinks))

init: ## Setup environment settings 
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

init_docker: ## Setup environment settings 
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init_for_docker.sh

update: ## Fetch changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: update deploy init ## Run make update, deploy, init
	@exec $$SHELL

# clean: ## Remove the dot files and this repo
# 	@echo 'Remove dot files in your home directory...'
# 	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
# 	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
