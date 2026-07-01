{ config, pkgs, self, ... }:

{
    services.openssh = {
        enable = true;
        settings = {
            # Разрешает вход для root только по SSH-ключам
            PermitRootLogin = "prohibit-password"; 
            PasswordAuthentication = true;
        };
    };

    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0eDGyp8gLfwNxmplD7m2HJ8m+rBBDVBY+3cOGJor/3"
    ];
}