{
  config,
  pkgs,
  inputs,
  system,
  ...
}: {
  home.username = "rafaeljacov";
  home.homeDirectory = "/home/rafaeljacov";

  xdg.userDirs = let
    HOME = config.home.homeDirectory;
  in {
    enable = true;
    createDirectories = true; # optional - will create them if missing
    desktop = "${HOME}/Desktop";
    documents = "${HOME}/Documents";
    download = "${HOME}/Downloads";
    music = "${HOME}/Music";
    pictures = "${HOME}/Pictures";
    publicShare = "${HOME}/Public";
    templates = "${HOME}/Templates";
    videos = "${HOME}/Videos";
  };

  home.sessionVariables = let
    HOME = config.home.homeDirectory;
    editor = "nvim";
  in {
    EDITOR = editor;
    VISUAL = editor;

    # Don't forget to run 'protonup'!
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${HOME}/.steam/root/compatabilitytools.d";
  };

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

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
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

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.packages = with pkgs; [
    ags
    air
    bat
    black
    bottles
    btop
    chafa
    ciscoPacketTracer8
    deno
    devenv
    eza
    fish
    gofumpt
    golangci-lint
    goose
    gotools
    grim
    inputs.zen-browser.packages.${system}.beta
    krabby
    mypy
    neovim
    nodePackages.prettier
    nodejs_23
    protonup
    ripgrep
    rustup
    slurp
    sqlc
    sqlfluff
    starship
    swappy
    swww
    tailwindcss_4
    teams-for-linux
    templ
    tldr
    typstyle
    udiskie
    watchman
    webcord
    yazi
    zoxide
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
