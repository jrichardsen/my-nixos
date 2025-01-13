{
  helpers,
  pkgs,
  utils,
  ...
}:
{
  # NOTE: make wrapping and spelling depend on the filetype (aucmd?)
  # NOTE: figure out spelling (different spelllangs)
  # NOTE: debugging (dap)?
  # NOTE: performance optimizations?
  imports = [
    ./coding
    ./editor
    ./style
  ];

  config = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    clipboard.register = "unnamedplus";

    opts = {
      autowrite = true;
      confirm = true;
      cursorline = true;
      grepformat = "%f:%l:%c:%m";
      grepprg = "${pkgs.ripgrep}/bin/rg --vimgrep";
      hlsearch = false;
      ignorecase = true;
      inccommand = "split";
      laststatus = 3;
      linebreak = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      mouse = "a";
      number = true;
      relativenumber = true;
      scrolloff = 10;
      shiftround = true;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = true;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      updatetime = 250;
      virtualedit = "block";
      wrap = true;
    };

    # NOTE: unify descriptions of keymaps
    keymaps = [
      (utils.mkToggleMapN "<leader>ul" "number" "Line numbers")
      (utils.mkToggleMapN "<leader>uL" "relativenumber" "Relative line numbers")
      (utils.mkToggleMapN "<leader>uw" "wrap" "Wrap")
      (utils.mkToggleMapN "<leader>us" "spell" "Spelling")
      (utils.mkToggleMapN "<leader>uh" "list" "Hidden characters")
      (utils.mkCmdMapN "<leader>ut" "<cmd>TSToggle highlight<cr>" "Toggle Treesitter highlight")
      # NOTE: terminal mode settings
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          desc = "Down";
          expr = true;
          silent = true;
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          desc = "Up";
          expr = true;
          silent = true;
        };
      }
      (utils.mkCmdMapN "<A-j>" "<cmd>m .+1<cr>==" "Move Line Down")
      (utils.mkCmdMapN "<A-k>" "<cmd>m .-2<cr>==" "Move Line Up")
      (utils.mkCmdMap "i" "<A-j>" "<esc><cmd>m .+1<cr>==gi" "Move Line Down")
      (utils.mkCmdMap "i" "<A-k>" "<esc><cmd>m .-2<cr>==gi" "Move Line Up")
      (utils.mkCmdMap "v" "<A-j>" "<cmd>m '>+1<cr>gv=gv" "Move Line Down")
      (utils.mkCmdMap "v" "<A-k>" "<cmd>m '<-2<cr>gv=gv" "Move Line Up")
      (utils.mkCmdMapN "<leader>ur" "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><CR>"
        "Redraw / Clear hlsearch / Diff Update"
      )
      # Additional breakpoints in insert mode
      (utils.mkCmdMap "i" "," ",<c-g>u" null)
      (utils.mkCmdMap "i" "." ".<c-g>u" null)
      (utils.mkCmdMap "i" ";" ";<c-g>u" null)
      # Reselect after indentation
      (utils.mkCmdMap "v" "<" "<gv" null)
      (utils.mkCmdMap "v" ">" ">gv" null)
    ];

    autoCmd = [
      {
        desc = "Highlight when yanking (copying) text";
        event = "TextYankPost";
        callback = helpers.mkRaw "function() vim.highlight.on_yank() end";
      }
      {
        desc = "Check if we need to reload the file when it changes";
        event = [
          "FocusGained"
          "TermClose"
          "TermLeave"
        ];
        callback = helpers.mkRaw ''
          function()
            if vim.o.buftype ~= "nofile" then
              vim.cmd("checktime")
            end
          end
        '';
      }
      {
        desc = "Close some filetypes with <q>";
        event = "FileType";
        pattern = [
          "help"
          "lspinfo"
          "checkhealth"
          "gitsigns.blame"
        ];
        callback = helpers.mkRaw ''
          function(event)
            vim.bo[event.buf].buflisted = false;
            vim.keymap.set("n", "q", "<cmd>close<cr>", {
              buffer = event.buf,
              silent = true,
              desc = "Quit buffer",
            })
          end
        '';
      }
      {
        desc = "Auto create intermediate directories when saving a file";
        event = "BufWritePre";
        callback = helpers.mkRaw ''
          function(event)
            if event.match:match("^%w%w+:[\\/][\\/]") then
              return
            end
            local file = vim.uv.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      }
    ];
  };
}
