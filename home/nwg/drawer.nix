{ config, lib, pkgs, ... }:
  with config.lib.stylix.colors;
{
  xdg.configFile."nwg-drawer/drawer.css".text = ''
    window {
      background-color: rgba (${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.7);
      color: #${base05}
    }
  
    /* search entry */
    entry {
      background-color: rgba (${base01-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.2)
    }

    button, image {
      background: none;
      border: none
    }

    button:hover {
      background-color: rgba (${base04-rgb-r}, ${base04-rgb-g}, ${base04-rgb-b}, 0.7)
    }
      
    /* in case you wanted to give category buttons a different look */
    #category-button {
      margin: 0 10px 0 10px
    }

    pinned-box {
      padding-bottom: 5px;
      border-bottom: 1px dotted gray
    }

    #files-box {
      padding: 5px;
      border: 1px dotted gray;
      border-radius: 15px
    }
  '';
}

