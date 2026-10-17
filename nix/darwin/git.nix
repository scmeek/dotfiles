{ ... }:

{
  programs.git = {
    settings = {
      user.signingkey = "8F73E7B76CBD3188";
      commit.gpgsign = true;
    };
  };
}
