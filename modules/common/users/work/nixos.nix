{...}: {
  #users
  users.users.noahwilson = {
    home = "/Users/noahwilson";
  };

  security.pam.enableSudoTouchIdAuth = true;

  environment.variables = {
      EDITOR = "nvim";
      HOME = "/Users/noahwilson";
      Host = "aarch65-darwin";
      AWS_PROFILE = "sre_v1-prod";
      TF_SECRET = "terraform_builder";
    };
}
