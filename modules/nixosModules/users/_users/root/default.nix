{ config, ... }: {
    users.mutableUsers = false;

    users.users.root = {
        hashedPassword = config.myConfig.rootPassword;
        home = "/root";
    };
}
