--local names = loadstring(game:HttpGet("https://raw.githubusercontent.com/sneekygoober/sneeky-s-fov-lib/refs/heads/main/info.luau"))().names;

return function(asset: string)
    local a = asset == "logo" and "rbxassetid://135051411499830" or "rbxassetid://98007778578768";
    if getcustomasset and isfolder and makefolder and isfile and writefile then
        local path = "sneekys_scripts_assets";
        local s, isfo = pcall(isfolder, "sneekys_scripts_assets");
        if not s then return a; end;

        if not isfo then
            if not pcall(makefolder, "sneekys_scripts_assets") then return a; end;
        end;

        path = path .. "/" .. asset--[[names[asset]] .. ".png";
        local s2, isfi = pcall(isfile, path);
        if not s2 then return a; end;

        if not isfi then
            if not pcall(writefile, path, game:HttpGet("https://raw.githubusercontent.com/sneekygoober/sneeky-s-fov-lib/refs/heads/main/" .. asset .. ".png")) then return a; end;
        end;

        return pcall(getcustomasset, path) and getcustomasset(path) or a;
    end;

    return a;
end;
