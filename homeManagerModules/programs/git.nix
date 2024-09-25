{
  config = {
    programs.git = {
      userName = "jrichardsen";
      userEmail = "jonas.richardsen@gmail.com";
      extraConfig = {
        core = {
          autocrlf = "input";
          editor = "nvim";
        };
      };
      ignores = [
        ".direnv"
        ".envrc"
      ];
    };
  };
}
