{
  lib,
  config,
  ...
}: let
in {
  options = {
    zen-browser.enable =
      lib.mkEnableOption "config files for zen browser";
  };

  config = lib.mkIf config.zen-browser.enable {
    home.file = {
      ".zen/x1nm9cs7.Default Profile/chrome/userChrome.css" = {
        text =
          /*
          css
          */
          ''
            @import "rose-pine-main.css";

            #zen-main-app-wrapper {
              background-color: var(--base) !important;
            }

            #appMenu-mainView {
              background-color: var(--overlay) !important;
            }

            #appmenu-moreTools {
              background-color: var(--overlay) !important;
            }

            #PanelUI-button {
              --button-active-bgcolor: black !important;
            }

            toolbox#navigator-toolbox {
              background-color: var(--base) !important;
            }

            #zen-appcontent-navbar-container {
              background-color: var(--base) !important;
            }

            .menu-text {
              color: var(--text) !important;
            }

            .menuitem-iconic {
              color: var(--love) !important;
            }

            :not(:not(menubar) > menu, #ContentSelectDropdown)
              > menupopup
              > menuitem:not(
                .menuitem-iconic,
                [type="checkbox"],
                [type="radio"],
                .in-menulist,
                .in-menulist menuitem,
                .unified-nav-current
              ),
            :not(:not(menubar) > menu, #ContentSelectDropdown)
              > menupopup
              > menu:not(
                .menu-iconic,
                [type="checkbox"],
                [type="radio"],
                .in-menulist,
                .in-menulist menu,
                .unified-nav-current
              ),
            #toggle_toolbar-menubar,
            #PanelUI-history toolbarbutton,
            #unified-extensions-context-menu menuitem {
              fill: var(--text) !important;
            }

            html#main-window {
              --lwt-text-color: var(--text) !important;
              --toolbarbutton-icon-fill: var(--love) !important;
              --toolbar-field-color: var(--pine) !important;
              --toolbar-field-focus-color: var(--pine) !important;
              --toolbar-field-background-color: var(--surface) !important;
              --toolbar-field-focus-background-color: var(--surface) !important;

              --zen-colors-primary: var(--rose) !important;
              --zen-colors-secondary: var(--overlay) !important;
              --zen-colors-tertiary: var(--base) !important;
              --zen-colors-border: var(--base) !important;
              --zen-dialog-background: var(--overlay) !important;

              --arrowpanel-color: var(--text) !important;
            }

            #tabbrowser-tabbox {
              border-top-left-radius: 10px !important;
              border-left-width: 1px !important;
              border-top-width: 1px !important;
              border-color: var(--overlay) !important;
              border-style: solid !important;
            }

            #urlbar-background {
              border: 1px solid var(--overlay) !important;
            }
          '';
      };

      ".zen/x1nm9cs7.Default Profile/chrome/rose-pine-main.css" = {
        text =
          /*
          css
          */
          ''
            * {
              --base:           #191724;
              --surface:        #1f1d2e;
              --overlay:        #26233a;
              --muted:          #6e6a86;
              --subtle:         #908caa;
              --text:           #e0def4;
              --love:           #eb6f92;
              --gold:           #f6c177;
              --rose:           #ebbcba;
              --pine:           #31748f;
              --foam:           #9ccfd8;
              --iris:           #c4a7e7;
              --highlightLow:   #21202e;
              --highlightMed:   #403d52;
              --highlightHigh:  #524f67;
            }
          '';
      };

      ".zen/h6r8euma.Default Profile/chrome/userChrome.css" = {
        text =
          /*
          css
          */
          ''
            @import "rose-pine-main.css";

            #zen-main-app-wrapper {
              background-color: var(--base) !important;
            }

            #appMenu-mainView {
              background-color: var(--overlay) !important;
            }

            #appmenu-moreTools {
              background-color: var(--overlay) !important;
            }

            #PanelUI-button {
              --button-active-bgcolor: black !important;
            }

            toolbox#navigator-toolbox {
              background-color: var(--base) !important;
            }

            #zen-appcontent-navbar-container {
              background-color: var(--base) !important;
            }

            .menu-text {
              color: var(--text) !important;
            }

            .menuitem-iconic {
              color: var(--love) !important;
            }

            :not(:not(menubar) > menu, #ContentSelectDropdown)
              > menupopup
              > menuitem:not(
                .menuitem-iconic,
                [type="checkbox"],
                [type="radio"],
                .in-menulist,
                .in-menulist menuitem,
                .unified-nav-current
              ),
            :not(:not(menubar) > menu, #ContentSelectDropdown)
              > menupopup
              > menu:not(
                .menu-iconic,
                [type="checkbox"],
                [type="radio"],
                .in-menulist,
                .in-menulist menu,
                .unified-nav-current
              ),
            #toggle_toolbar-menubar,
            #PanelUI-history toolbarbutton,
            #unified-extensions-context-menu menuitem {
              fill: var(--text) !important;
            }

            html#main-window {
              --lwt-text-color: var(--text) !important;
              --toolbarbutton-icon-fill: var(--love) !important;
              --toolbar-field-color: var(--pine) !important;
              --toolbar-field-focus-color: var(--pine) !important;
              --toolbar-field-background-color: var(--surface) !important;
              --toolbar-field-focus-background-color: var(--surface) !important;

              --zen-colors-primary: var(--rose) !important;
              --zen-colors-secondary: var(--overlay) !important;
              --zen-colors-tertiary: var(--base) !important;
              --zen-colors-border: var(--base) !important;
              --zen-dialog-background: var(--overlay) !important;

              --arrowpanel-color: var(--text) !important;
            }

            #tabbrowser-tabbox {
              border-top-left-radius: 10px !important;
              border-left-width: 1px !important;
              border-top-width: 1px !important;
              border-color: var(--overlay) !important;
              border-style: solid !important;
            }

            #urlbar-background {
              border: 1px solid var(--overlay) !important;
            }
          '';
      };

      ".zen/h6r8euma.Default Profile/chrome/rose-pine-main.css" = {
        text =
          /*
          css
          */
          ''
            * {
              --base:           #191724;
              --surface:        #1f1d2e;
              --overlay:        #26233a;
              --muted:          #6e6a86;
              --subtle:         #908caa;
              --text:           #e0def4;
              --love:           #eb6f92;
              --gold:           #f6c177;
              --rose:           #ebbcba;
              --pine:           #31748f;
              --foam:           #9ccfd8;
              --iris:           #c4a7e7;
              --highlightLow:   #21202e;
              --highlightMed:   #403d52;
              --highlightHigh:  #524f67;
            }
          '';
      };
    };
  };
}
