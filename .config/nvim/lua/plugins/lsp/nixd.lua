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
                    expr =
                    '(builtins.getFlake ("/home/rafaeljacov/dotfiles")).nixosConfigurations.huawei-nixos.options',
                },
                home_manager = {
                    expr =
                    '(builtins.getFlake ("/home/rafaeljacov/dotfiles")).homeConfigurations."rafaeljacov@huawei-nixos".options',
                },
            },
        }
    }
}
