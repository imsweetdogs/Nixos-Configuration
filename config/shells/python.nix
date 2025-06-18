{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python";
  
  buildInputs = with pkgs; [
    python313
    poetry
    uv
  ];
  
  shellHook = ''
    export PS1="\[\033[01;32m\](python)\[\033[00m\] $PS1"

    export POETRY_VIRTUALENVS_IN_PROJECT=true
    
    echo "Python on!\nInclude uv and poetry. Base python version - 3.13=<3.14."
  '';
} 