{
  config = {
    services.xserver.xkb = {
      layout = "de";
      variant = "neo_qwertz";
    };
    console.useXkbConfig = true;
  };
}
