return function(asset: string)
    if getcustomasset and isfolder and makefolder and isfile and writefile then
        local path = "sneekys_scripts_assets";

        if not isfolder("sneekys_scripts_assets") then
            makefolder("sneekys_scripts_assets");
        end;

        path = path .. "/" .. asset .. ".png";

        if not isfile(path) then
            writefile(path, game:HttpGet("https://raw.githubusercontent.com/sneekygoober/sneeky-s-fov-lib/refs/heads/main/" .. asset .. ".png"));
        end;

        return getcustomasset(path);
    end;

    return asset == "logo" and "rbxassetid://135051411499830" or "rbxassetid://98007778578768";
end;
