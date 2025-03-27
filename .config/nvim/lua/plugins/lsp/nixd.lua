local nixos_opts = '(builtins.getFlake ("/home/rafaeljacov/dotfiles")).nixosConfigurations.huawei-nixos.options'

return {
    cmd = { 'nixd' },
    settings = {
        nixd = {
            nixpkgs = {
                expr = '(builtins.getFlake ("/home/rafaeljacov/dotfiles")).inputs.nixpkgs {}',
            },
            formatting = {
                command = { "alejandra" },
            },
            options = {
                nixos = {
                    expr = nixos_opts,
                },
                home_manager = {
                    expr = nixos_opts .. ".home-manager.users.type.getSubOptions []"
                },
            },
        }
    }
}
