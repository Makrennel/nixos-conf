{ config, lib, pkgs, ... }: let
  holdprogram = pkgs.writeShellScriptBin "holdprogram" ''
    tput smcup
    $@
    echo "Press return to continue..."
    
    while true; do
      if read -t 0; then
        read -n 1 char;
        echo -e "\nExiting...\n"
        break
      else
        sleep 0
      fi
    done
    
    tput rmcup
  '';
  run-image-viewer = pkgs.writeShellScriptBin "run-image-viewer" ''
    [ "$TERM" = "xterm-kitty" ] && ${holdprogram}/bin/holdprogram ${pkgs.kitty}/bin/kitten icat "$@" || QT_QPA_PLATFORM=linuxfb ${pkgs.qimgv}/bin/qimgv "$@"
  '';
  run-mpv = pkgs.writeShellScriptBin "run-mpv" ''
    [ "$TERM" = "xterm-kitty" ] && ${pkgs.mpv}/bin/mpv --vo=kitty --vo-kitty-use-shm "$@" || ${pkgs.mpv}/bin/mpv --vo=gpu "$@"
  '';
in {
  programs.ranger = {
    enable = true;
    mappings = {
      CR = "shell xdg-open %s &";
      "\\" = "shell xdg-open %s &";
    };
    rifle = [
      {
        condition = "mime ^image";
        command = "${run-image-viewer}/bin/run-image-viewer \"$@\"";
      }
      {
        condition = "mime ^text, label editor";
        command = "$EDITOR \"$@\"";
      }
      {
        condition = "mime ^ranger/x-terminal-emulator";
        command = "${pkgs.kitty}/bin/kitty \"$@\"";
      }
      {
        condition = "mime ^video, terminal";
        command = "${run-mpv}/bin/run-mpv \"$@\"";
      }
      {
        condition = "label open";
        command = "${pkgs.xdg-utils}/bin/xdg-open \"$@\"";
      }
    ];
    settings = {
      viewmode = "miller";
      column_ratios = "1,1,2,3";
      hidden_filter = "^\\.|\\.(?:pyc|pyo|bak|swp)$|^lost\\+found$|^__(py)?cache__$";
      show_hidden = false;
      confirm_on_delete = "multiple";
      use_preview_script = true;
      automatically_count_files = true;
      open_all_images = true;

      vcs_aware = true;
      vcs_backend_git = "enabled";
      vcs_backend_hg = "disabled";
      vcs_backend_bzr = "disabled";
      vcs_backend_svn = "disabled";
      vcs_msg_length = 50;
      
      preview_images = true;
      preview_images_method = "kitty";
      w3m_delay = 0.02;
      w3m_offset = 0;
      unicode_ellipsis = true;
      
      preview_files = true;
      preview_directories = true;
      collapse_preview = true;

      wrap_plaintext_previews = false;
      save_console_history = true;
      status_bar_on_top = false;
      draw_progress_bar_in_status_bar = true;
      draw_borders = "both";
      dirname_in_tabs = true;
      mouse_enabled = true;
      display_size_in_main_column = true;
      display_size_in_status_bar = true;
      display_free_space_in_status_bar = true;
      display_tags_in_all_columns = true;
      update_title = true;
      update_tmux_title = true;
      shorten_title = 3;
      hostname_in_titlebar = true;
      tilde_in_titlebar = false;
      padding_right = true;
      show_cursor = false;
      
      sort_reverse = false;
      sort_case_insensitive = true;
      sort_directories_first = true;
      sort_unicode = false;
      preview_max_size = 0;
      show_selection_in_titlebar = true;
      clear_filters_on_dir_change = false;
      line_numbers = false;
      relative_current_zero = false;
      one_indexed = false;
      wrap_scroll = false;
      nested_ranger_warning = true;
    };
  };
}
