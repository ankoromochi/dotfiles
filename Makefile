DOTFILES_EXCLUEDS := .DS_Store .git .gitmodules
DOTFILES_TARGET   := $(wildcard .??*)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUEDS), $(DOTFILES_TARGET))

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sv $(abspath $(val)) $(HOME)/$(val);)
