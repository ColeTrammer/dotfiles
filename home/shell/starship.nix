{
  config,
  lib,
  ...
}: {
  options = {
    shell.starship = {
      enable =
        lib.mkEnableOption "starship"
        // {
          default = config.shell.enable;
        };
      localIp = lib.mkEnableOption "show local ip over hostname";
    };
  };

  config = lib.mkIf config.shell.starship.enable {
    programs.starship = {
      enable = true;
      settings = {
        # Global config
        command_timeout = 1000;
        format = "$character";
        right_format = "$all";
        add_newline = false;

        # Module config
        aws.disabled = true;
        localip.disabled = config.shell.starship.localIp;
        hostname.disabled = !config.shell.starship.localIp;
        nix_shell = {
          style = "bold cyan";
          format = "via [$symbol$name]($style) ";
        };
        directory = {
          style = "bold blue";
        };

        # No runtime versions preset + color overrides.
        bun = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        buf = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        cmake = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        cobol = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        crystal = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        daml = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        dart = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        deno = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        dotnet = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        elixir = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        elm = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        erlang = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        fennel = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        golang = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        gradle = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        haxe = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        helm = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        java = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        julia = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        kotlin = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        lua = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        meson = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        nim = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        nodejs = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        ocaml = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        opa = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        perl = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        php = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        pulumi = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        purescript = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        python = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        quarto = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        raku = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        red = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        rlang = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        ruby = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        rust = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        solidity = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        typst = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        swift = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        vagrant = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        vlang = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };
        zig = {
          format = "via [$symbol]($style)";
          style = "bold cyan";
        };

        # NerdFont preset
        aws.symbol = "  ";
        buf.symbol = " ";
        c.symbol = " ";
        conda.symbol = " ";
        crystal.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " 󰌾";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        fennel.symbol = " ";
        fossil_branch.symbol = " ";
        git_branch.symbol = " ";
        golang.symbol = " ";
        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = " ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        kotlin.symbol = " ";
        lua.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        ocaml.symbol = " ";
        os.symbols.Alpaquita = " ";
        os.symbols.Alpine = " ";
        os.symbols.AlmaLinux = " ";
        os.symbols.Amazon = " ";
        os.symbols.Android = " ";
        os.symbols.Arch = " ";
        os.symbols.Artix = " ";
        os.symbols.CentOS = " ";
        os.symbols.Debian = " ";
        os.symbols.DragonFly = " ";
        os.symbols.Emscripten = " ";
        os.symbols.EndeavourOS = " ";
        os.symbols.Fedora = " ";
        os.symbols.FreeBSD = " ";
        os.symbols.Garuda = "󰛓 ";
        os.symbols.Gentoo = " ";
        os.symbols.HardenedBSD = "󰞌 ";
        os.symbols.Illumos = "󰈸 ";
        os.symbols.Kali = " ";
        os.symbols.Linux = " ";
        os.symbols.Mabox = " ";
        os.symbols.Macos = " ";
        os.symbols.Manjaro = " ";
        os.symbols.Mariner = " ";
        os.symbols.MidnightBSD = " ";
        os.symbols.Mint = " ";
        os.symbols.NetBSD = " ";
        os.symbols.NixOS = " ";
        os.symbols.OpenBSD = "󰈺 ";
        os.symbols.openSUSE = " ";
        os.symbols.OracleLinux = "󰌷 ";
        os.symbols.Pop = " ";
        os.symbols.Raspbian = " ";
        os.symbols.Redhat = " ";
        os.symbols.RedHatEnterprise = " ";
        os.symbols.RockyLinux = " ";
        os.symbols.Redox = "󰀘 ";
        os.symbols.Solus = "󰠳 ";
        os.symbols.SUSE = " ";
        os.symbols.Ubuntu = " ";
        os.symbols.Unknown = " ";
        os.symbols.Void = " ";
        os.symbols.Windows = "󰍲 ";
        package.symbol = "󰏗 ";
        perl.symbol = " ";
        php.symbol = " ";
        pijul_channel.symbol = " ";
        python.symbol = " ";
        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        rust.symbol = " ";
        scala.symbol = " ";
        swift.symbol = " ";
        zig.symbol = " ";
      };
    };
  };
}
