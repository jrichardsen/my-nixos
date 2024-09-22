{
  config = {
    services.libinput.touchpad = {
      disableWhileTyping = true;
      naturalScrolling = true;
      additionalOptions = ''
        Option "PalmDetection" "True"
      '';
    };
  };
}
