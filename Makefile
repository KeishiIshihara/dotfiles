#variables # Now suited to my mac
DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml bin .ros_setup .ycm_extra_conf.py
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

#command : here are for better understanding
find_files  = /bin/ls -dF $(val);
make_symlinks =  ln -sfnv $(abspath $(val)) $(HOME)/$(val);

# .DEFAULT_GOAL := help
.PHONY : test

test:
	@echo $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
	@echo $(wildcard .??*)

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), $(find_files))
	
deploy: ## Create symlink to home directory
	@echo 'Copyright (c) 2013-2015 BABAROT All Rights Reserved.'
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

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
