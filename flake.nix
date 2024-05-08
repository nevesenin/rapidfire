{
  description = "RoR";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };
    nixpkgs-ruby = {
      url = "github:bobvanderlinden/nixpkgs-ruby";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mk-shell-bin = { url = "github:rrbutani/nix-mk-shell-bin"; };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devenv.shells.default = {
          name = "Dev shell for rapidfire";

          packages = with pkgs; [
            libcxx
            libyaml
          ];

          languages = {
            ruby = {
              enable = true;
              version = "3.3.0";
              bundler.enable = false;
            };
          };

          services = {
            postgres = {
              enable = true;
              listen_addresses = "127.0.0.1";
              initialDatabases = [
                { name = "rapidfire_development"; }
                { name = "rapidfire_test"; }
              ];
              initdbArgs = [
                "--locale=C"
                "--encoding=UTF8"
                "--auth-host=password"
              ];
              initialScript = ''
                CREATE USER postgres SUPERUSER;
                CREATE USER rapidfire_development PASSWORD '1234qwer';
                CREATE USER rapidfire_test PASSWORD '1234qwer';
                ALTER USER rapidfire_development CREATEDB;
                ALTER USER rapidfire_test CREATEDB;
                ALTER DATABASE rapidfire_development owner to rapidfire_development;
                ALTER DATABASE rapidfire_test owner to rapidfire_test;
                GRANT CONNECT ON DATABASE rapidfire_development to rapidfire_development;
                GRANT CONNECT ON DATABASE rapidfire_test to rapidfire_test;
              '';
            };
          };
        };
      };
    };
}
