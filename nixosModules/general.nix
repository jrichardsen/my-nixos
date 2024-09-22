# TODO: figure out where to put this
{
  config = {
    # don't shutdown when power button is short-pressed
    services.logind.extraConfig = ''
      HandlePowerKey = ignore
    '';
  };
}
