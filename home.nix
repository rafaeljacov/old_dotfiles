{
  config,
  pkgs,
  ...
}: {
  home.username = "rafaeljacov";
  home.homeDirectory = "/home/rafaeljacov";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # home.sessionPath = [
  #       "$ANDROID_HOME/emulator"
  #       "$ANDROID_HOME/platform-tools"
  # ];

  home.stateVersion = "24.11"; # match your system.stateVersion

  programs.bash = {
    enable = true;

    # Use fish as shell through bash
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Catppuccin Mocha Theme
      set -g status-position bottom
      set -g status-style bg=#1e1e2e,fg=#cdd6f4
      set -g message-style bg=#1e1e2e,fg=#cdd6f4
      set -g message-command-style bg=#1e1e2e,fg=#cdd6f4
      set -g pane-border-style fg=#313244
      set -g pane-active-border-style fg=#cba6f7
      set -g status-left '#[bg=#89b4fa,fg=#1e1e2e,bold] #S #[bg=#1e1e2e,fg=#89b4fa,nobold]'
      set -g status-right '#[fg=#a6e3a1,bg=#1e1e2e] %Y-%m-%d  %H:%M '
    '';
  };

  programs.git = {
    enable = true;
    userName = "Rafael Jacov Medel";
    userEmail = "medelrafjac@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      core.autocrlf = "input";
      alias.stats = "status -s";
      pull.ff = "only";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  home.packages = with pkgs; [
    neovim
    btop
    ripgrep
    fish
    eza
    grim
    slurp
    swww
    swappy
    air
    templ
    sqlc
    goose
    udiskie
    typstyle
    black
    sqlfluff
    mypy
    nodePackages.prettier
    golangci-lint
    starship
    deno
    zoxide
    bat
    krabby
    nodejs_23
    tailwindcss_4
    watchman
    rustup
    gofumpt
    gotools
    php
    webcord
    tldr
    chafa
  ];
}
