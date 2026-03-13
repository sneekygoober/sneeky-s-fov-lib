local cloneref = cloneref or function(i: Instance) return i; end;

local GS: GuiService = cloneref(game:GetService("GuiService"));
local Players: Players = cloneref(game:GetService("Players"));
local _ = cloneref(game:GetService("CoreGui"));
local hui = _:FindFirstChild("RobloxGui") or _;
if gethui then local s, r = pcall(gethui); if s then hui = cloneref(r); end; end;

local plr = Players.LocalPlayer;

local code = function(n: string): string
    if crypt and crypt.base64encode then
        return crypt.base64encode(n);
    end;
    return n;
end;

local get_id = loadstring(game:HttpGet("https://raw.githubusercontent.com/sneekygoober/sneeky-s-fov-lib/refs/heads/main/get_id.luau"))();

local SG = loadstring(game:HttpGet("https://raw.githubusercontent.com/sneekygoober/sneeky-s-notifications/refs/heads/main/main.luau"))();
local Drawlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sneekygoober/sneeky-s-fov-lib/refs/heads/main/lib.luau"))();
local info = loadstring(game:HttpGet("https://raw.githubusercontent.com/sneekygoober/sneeky-s-fov-lib/refs/heads/main/info.luau"))();
local discord_link = info.discord_link;
local key = code(info.ggKey);

return function(sFOV: number, tFunc: (origin: Vector3?) -> BasePart?, mCenter: boolean?, colour: Color3?)
    if getgenv()[key] then
        if getgenv()[key]["draw_instance"] and getgenv()[key]["connections"] and getgenv()[key]["p_instance"] then
            getgenv()[key]["draw_instance"]:terminate();
            for _, v in next, getgenv()[key]["connections"] do v:Disconnect(); end;
            table.clear(getgenv()[key]["connections"]);
            getgenv()[key]["p_instance"]:Destroy();
            table.clear(getgenv()[key]);
            getgenv()[key] = nil;
        else
            plr:Kick("Don't tamper with that getgenv key. If you believe this kick a mistake please join the Discord server and report it!\nDiscord Server Link: " .. discord_link);
        end;
    end;

    local draw = Drawlib.new(sFOV, tFunc, mCenter, colour);
    local on = true;

    local p = Instance.new("ScreenGui", hui);
    p.Name = code(p:GetDebugId());

    local menu = Instance.new("CanvasGroup", p)
    menu.Name = code(menu:GetDebugId());
    menu.AnchorPoint = Vector2.new(0.5, 0.5);
    menu.Position = UDim2.new(0.5, 0, 0.5, 0);
    menu.Size = UDim2.new(0.3, 0, 0.3, 0);
    menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
    menu.BorderMode = Enum.BorderMode.Outline;
    menu.BorderColor3 = Color3.fromRGB(50, 25, 25);
    menu.BorderSizePixel = 3;
    menu.Active = true;
    menu.Draggable = true;
    menu.ClipsDescendants = true;

    --[[local _ = Instance.new("UICorner", menu);
    _.Name = code(_:GetDebugId());
    _.CornerRadius = UDim.new(0.03, 0);

    local __ = Instance.new("UIStroke", menu);
    __.Name = code(__:GetDebugId());
    __.Color = Color3.fromRGB(50, 25, 25);
    __.Thickness = 3;
    __.LineJoinMode = Enum.LineJoinMode.Round;
    __.Transparency = 0;]]

    local external_close = Instance.new("ImageButton", p)
    external_close.Name = code(external_close:GetDebugId());
    external_close.AnchorPoint = Vector2.new(0, 0.5);
    external_close.Position = UDim2.new(0, 0, 0.5, 0);
    external_close.Size = UDim2.new(0, 64, 0, 64);
    external_close.BackgroundTransparency = 1;
    external_close.Image = get_id("close");
    external_close.Visible = GS.MenuIsOpen;

    local top = Instance.new("Frame", menu)
    top.Name = code(top:GetDebugId());
    top.Size = UDim2.new(1, 0, 0.5, 0);
    top.BackgroundTransparency = 1;

    local drag = Instance.new("TextLabel", top);
    drag.Name = code(drag:GetDebugId());
    drag.AnchorPoint = Vector2.new(0.5, 0.5);
    drag.Position = UDim2.new(0.5, 0, 0.5, 0);
    drag.Size = UDim2.new(0.3, 0, 0.3, 0);
    drag.BackgroundTransparency = 1;
    drag.TextScaled = true;
    drag.TextColor3 = Color3.new(1, 1, 1);
    drag.Text = "HOLD TO DRAG";

    local logo = Instance.new("ImageButton", top)
    logo.Name = code(logo:GetDebugId());
    logo.Size = UDim2.new(0, 64, 0, 64);
    logo.BackgroundTransparency = 1;
    logo.Image = get_id("logo");

    local internal_close = Instance.new("ImageButton", top)
    internal_close.Name = code(internal_close:GetDebugId());
    internal_close.AnchorPoint = Vector2.new(1, 0);
    internal_close.Position = UDim2.new(1, 0);
    internal_close.Size = UDim2.new(0, 64, 0, 64);
    internal_close.BackgroundTransparency = 1;
    internal_close.Image = get_id("close");

    local toggle = Instance.new("TextButton", menu);
    toggle.Name = code(toggle:GetDebugId());
    toggle.Position = UDim2.new(0, 0, 0.5, 0);
    toggle.Size = UDim2.new(1, 0, 0.5, 0);
    toggle.BackgroundColor3 = on and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
    toggle.TextScaled = true;
    toggle.Text = on and "FOV Enabled" or "FOV Disabled";

    local link = function()
        if setclipboard then
            setclipboard(discord_link);
            SG["info"]("Discord server link copied to clipboard!");
        else
            SG["info"]("Discord server link: " .. discord_link);
        end;
    end;

    local _toggle = function()
        on = not on;
        toggle.BackgroundColor3 = on and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
        toggle.Text = on and "FOV Enabled" or "FOV Disabled";
        if on then
            draw:start();
        else
            draw:stop();
        end;
    end;

    local e_close = function()
        if GS.MenuIsOpen then
            if not menu.Visible then
                external_close.Visible = true;
            else
                external_close.Visible = false;
            end;
        else
            external_close.Visible = false;
        end;
    end;

    local i_close = function()
        menu.Visible = not menu.Visible;

        if not menu.Visible then
            SG["info"]("FOV Menu closed, enter the escape menu and press the X button on the left to reopen the FOV Menu.");

            if GS.MenuIsOpen then
                external_close.Visible = true;
            end;
        else
            external_close.Visible = false;
        end;
    end;

    getgenv()[key] = {
        ["draw_instance"] = draw,
        ["connections"] = {
            GS.MenuOpened:Connect(e_close),
            GS.MenuClosed:Connect(e_close),

            external_close.MouseButton1Up:Connect(i_close),
            toggle.MouseButton1Up:Connect(_toggle),
            logo.MouseButton1Up:Connect(link),
            internal_close.MouseButton1Up:Connect(i_close),
            external_close.TouchTap:Connect(i_close),
            toggle.TouchTap:Connect(_toggle),
            logo.TouchTap:Connect(link),
            internal_close.TouchTap:Connect(i_close)
        },
        ["p_instance"] = p
    };

    draw:start();
end;
