-- LT2 Eğitim Paneli v3 | GitHub loadstring uyumlu

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting          = game:GetService("Lighting")
local UIS               = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local LP                = Players.LocalPlayer

-- PlayerGui'yi güvenli al
local PGui
local ok, err = pcall(function()
    PGui = LP:WaitForChild("PlayerGui", 10)
end)
if not ok or not PGui then
    -- Fallback: CoreGui dene
    pcall(function() PGui = game:GetService("CoreGui") end)
end
if not PGui then return end

-- Eski paneli temizle
local eski = PGui:FindFirstChild("LT2Panel")
if eski then eski:Destroy() end

local char, root, hum
local function cGun()
    char = LP.Character
    if not char then return end
    root = char:WaitForChild("HumanoidRootPart")
    hum  = char:WaitForChild("Humanoid")
end
cGun()
LP.CharacterAdded:Connect(function() task.wait(0.2) cGun() end)

-- Renkler
local C = {
    BG0 = Color3.fromRGB(12,12,18),
    BG1 = Color3.fromRGB(18,18,26),
    BG2 = Color3.fromRGB(26,26,38),
    BG3 = Color3.fromRGB(38,38,54),
    ACC = Color3.fromRGB(0,210,100),
    AC2 = Color3.fromRGB(0,150,70),
    TXT = Color3.fromRGB(220,220,230),
    TX2 = Color3.fromRGB(130,130,150),
    RED = Color3.fromRGB(220,60,60),
    ORN = Color3.fromRGB(220,140,0),
    BLU = Color3.fromRGB(60,120,220),
    BRD = Color3.fromRGB(40,40,58),
    WHT = Color3.fromRGB(255,255,255),
}

local function N(cls, props, par)
    local o = Instance.new(cls)
    if props then for k,v in pairs(props) do o[k]=v end end
    if par then o.Parent = par end
    return o
end
local function R(o,r) N("UICorner",{CornerRadius=UDim.new(0,r or 8)},o) end
local function S(o,t,c) N("UIStroke",{Thickness=t or 1,Color=c or C.BRD,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},o) end
local function T(o,p,s) TweenService:Create(o,TweenInfo.new(s or 0.15,Enum.EasingStyle.Quad),p):Play() end

-- ScreenGui
local sg = N("ScreenGui",{Name="LT2Panel",ResetOnSpawn=false,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling},PGui)

-- Ana pencere
local win = N("Frame",{
    Size=UDim2.new(1,-30,1,-30),
    Position=UDim2.new(0,15,0,15),
    BackgroundColor3=C.BG0,
    BorderSizePixel=0, ZIndex=2
},sg)
R(win,10) S(win,1.5,C.BRD)

-- Üst gradient şerit
local ug = N("Frame",{Size=UDim2.new(1,0,0,3),BackgroundColor3=C.ACC,BorderSizePixel=0,ZIndex=3},win)
R(ug,3)
N("UIGradient",{Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,255,130)),
    ColorSequenceKeypoint.new(0.5,C.ACC),
    ColorSequenceKeypoint.new(1,C.BLU),
})},ug)

-- Başlık
local tb = N("Frame",{Size=UDim2.new(1,0,0,46),Position=UDim2.new(0,0,0,3),
    BackgroundColor3=C.BG1,BorderSizePixel=0,ZIndex=3},win)

local logoF = N("Frame",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(0,12,0.5,-15),
    BackgroundColor3=C.ACC,BorderSizePixel=0,ZIndex=4},tb)
R(logoF,7)
N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
    Text="LT",TextColor3=C.BG0,TextSize=13,Font=Enum.Font.GothamBlack,ZIndex=5},logoF)

N("TextLabel",{Size=UDim2.new(1,-130,1,0),Position=UDim2.new(0,52,0,0),
    BackgroundTransparency=1,Text="Lumber Tycoon 2  •  Eğitim Paneli",
    TextColor3=C.TXT,TextSize=14,Font=Enum.Font.GothamBold,
    TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4},tb)

-- Kapat
local kaB = N("TextButton",{Size=UDim2.new(0,34,0,34),Position=UDim2.new(1,-44,0.5,-17),
    BackgroundColor3=Color3.fromRGB(50,18,18),BorderSizePixel=0,
    Text="✕",TextColor3=C.RED,TextSize=15,Font=Enum.Font.GothamBold,
    AutoButtonColor=false,ZIndex=4},tb)
R(kaB,7)
kaB.MouseEnter:Connect(function() T(kaB,{BackgroundColor3=C.RED,TextColor3=C.WHT}) end)
kaB.MouseLeave:Connect(function() T(kaB,{BackgroundColor3=Color3.fromRGB(50,18,18),TextColor3=C.RED}) end)
kaB.MouseButton1Click:Connect(function() win.Visible=not win.Visible end)

-- Küçült
local kuB = N("TextButton",{Size=UDim2.new(0,34,0,34),Position=UDim2.new(1,-82,0.5,-17),
    BackgroundColor3=Color3.fromRGB(50,40,10),BorderSizePixel=0,
    Text="—",TextColor3=C.ORN,TextSize=15,Font=Enum.Font.GothamBold,
    AutoButtonColor=false,ZIndex=4},tb)
R(kuB,7)
local kk=false
kuB.MouseButton1Click:Connect(function()
    kk=not kk
    T(win,{Size=kk and UDim2.new(1,-30,0,49) or UDim2.new(1,-30,1,-30)},0.2)
end)

-- İçerik
local ic = N("Frame",{Size=UDim2.new(1,0,1,-49),Position=UDim2.new(0,0,0,49),
    BackgroundTransparency=1,BorderSizePixel=0,ClipsDescendants=true,ZIndex=2},win)

-- Sol kenar
local kn = N("Frame",{Size=UDim2.new(0,158,1,0),BackgroundColor3=C.BG1,BorderSizePixel=0,ZIndex=3},ic)
N("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),
    BackgroundColor3=C.BRD,BorderSizePixel=0,ZIndex=4},kn)
N("TextLabel",{Size=UDim2.new(1,0,0,30),BackgroundColor3=C.BG0,BorderSizePixel=0,
    Text="  MENÜ",TextColor3=C.ACC,TextSize=11,Font=Enum.Font.GothamBlack,
    TextXAlignment=Enum.TextXAlignment.Left,ZIndex=4},kn)

-- Sağ
local sg2 = N("Frame",{Size=UDim2.new(1,-158,1,0),Position=UDim2.new(0,158,0,0),
    BackgroundColor3=C.BG0,BorderSizePixel=0,ZIndex=3},ic)

-- Durum
local dBar = N("Frame",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,1,-28),
    BackgroundColor3=C.BG1,BorderSizePixel=0,ZIndex=6},sg2)
N("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=C.BRD,BorderSizePixel=0,ZIndex=6},dBar)
local dDot = N("Frame",{Size=UDim2.new(0,8,0,8),Position=UDim2.new(0,10,0.5,-4),
    BackgroundColor3=C.ACC,BorderSizePixel=0,ZIndex=7},dBar)
R(dDot,4)
local dL = N("TextLabel",{Size=UDim2.new(1,-26,1,0),Position=UDim2.new(0,24,0,0),
    BackgroundTransparency=1,Text="Hazır.",TextColor3=C.ACC,TextSize=12,
    Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,
    TextWrapped=true,ZIndex=7},dBar)

local function D(m,e)
    local r=e and C.RED or C.ACC
    dL.Text=(e and "⚠ " or "✓ ")..m
    dL.TextColor3=r dDot.BackgroundColor3=r
end

-- Sayfa oluşturucu
local function mkPg(nm)
    local sf=N("ScrollingFrame",{Name=nm,Size=UDim2.new(1,0,1,-28),
        BackgroundTransparency=1,ScrollBarThickness=4,
        ScrollBarImageColor3=C.AC2,AutomaticCanvasSize=Enum.AutomaticCanvasSize.Y,
        CanvasSize=UDim2.new(0,0,0,0),Visible=false,ZIndex=4},sg2)
    N("UIListLayout",{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},sf)
    local pad=N("UIPadding",{},sf)
    pad.PaddingTop=UDim.new(0,12) pad.PaddingLeft=UDim.new(0,12)
    pad.PaddingRight=UDim.new(0,12) pad.PaddingBottom=UDim.new(0,12)
    return sf
end

local function mkH(p,t,ik)
    local f=N("Frame",{Size=UDim2.new(1,0,0,30),BackgroundColor3=C.BG2,BorderSizePixel=0,ZIndex=5},p)
    R(f,7) S(f,1,C.BRD)
    local b=N("Frame",{Size=UDim2.new(0,3,0,16),Position=UDim2.new(0,9,0.5,-8),
        BackgroundColor3=C.ACC,BorderSizePixel=0,ZIndex=6},f)
    R(b,2)
    N("TextLabel",{Size=UDim2.new(1,-18,1,0),Position=UDim2.new(0,18,0,0),
        BackgroundTransparency=1,Text=(ik and ik.."  " or "")..t,
        TextColor3=C.TXT,TextSize=13,Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6},f)
    return f
end

local function mkL(p,t)
    local l=N("TextLabel",{Size=UDim2.new(1,0,0,17),BackgroundTransparency=1,
        Text=t,TextColor3=C.TX2,TextSize=12,Font=Enum.Font.Gotham,
        TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=5},p)
    return l
end

local function mkB(p,t,rc,ik)
    local r=rc or C.BG2
    local btn=N("TextButton",{Size=UDim2.new(1,0,0,34),BackgroundColor3=r,
        BorderSizePixel=0,Text=(ik and ik.."  " or "")..t,TextColor3=C.TXT,
        TextSize=13,Font=Enum.Font.GothamSemibold,TextWrapped=true,
        AutoButtonColor=false,ZIndex=5},p)
    R(btn,7) S(btn,1,C.BRD)
    btn.MouseEnter:Connect(function() T(btn,{BackgroundColor3=C.BG3}) end)
    btn.MouseLeave:Connect(function() T(btn,{BackgroundColor3=r}) end)
    btn.MouseButton1Down:Connect(function() T(btn,{Size=UDim2.new(1,-4,0,32)}) end)
    btn.MouseButton1Up:Connect(function() T(btn,{Size=UDim2.new(1,0,0,34)}) end)
    return btn
end

local function mkSl(p,mn,mx,bs,et,cb)
    local kp=N("Frame",{Size=UDim2.new(1,0,0,50),BackgroundColor3=C.BG2,
        BorderSizePixel=0,ZIndex=5},p)
    R(kp,7) S(kp,1,C.BRD)
    N("TextLabel",{Size=UDim2.new(0.6,0,0,22),Position=UDim2.new(0,10,0,2),
        BackgroundTransparency=1,Text=et,TextColor3=C.TX2,TextSize=12,
        Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6},kp)
    local vL=N("TextLabel",{Size=UDim2.new(0.4,-10,0,22),Position=UDim2.new(0.6,0,0,2),
        BackgroundTransparency=1,Text=tostring(bs),TextColor3=C.ACC,TextSize=12,
        Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=6},kp)
    local iz=N("Frame",{Size=UDim2.new(1,-20,0,6),Position=UDim2.new(0,10,0,32),
        BackgroundColor3=C.BG3,BorderSizePixel=0,ZIndex=6},kp)
    R(iz,3)
    local dl=N("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=C.ACC,BorderSizePixel=0,ZIndex=7},iz)
    R(dl,3)
    local tp=N("Frame",{Size=UDim2.new(0,14,0,14),AnchorPoint=Vector2.new(0.5,0.5),
        Position=UDim2.new(0,0,0.5,0),BackgroundColor3=C.WHT,BorderSizePixel=0,ZIndex=8},iz)
    R(tp,7)
    local tpB=N("TextButton",{Size=UDim2.new(0,22,0,22),AnchorPoint=Vector2.new(0.5,0.5),
        Position=UDim2.new(0,0,0.5,0),BackgroundTransparency=1,Text="",ZIndex=9},iz)
    local drg=false
    local or2=math.clamp((bs-mn)/(mx-mn),0,1)
    local function upd(r2)
        r2=math.clamp(r2,0,1) or2=r2
        local px=r2*iz.AbsoluteSize.X
        dl.Size=UDim2.new(0,px,1,0)
        tp.Position=UDim2.new(0,px,0.5,0)
        tpB.Position=UDim2.new(0,px,0.5,0)
        vL.Text=tostring(math.floor(mn+r2*(mx-mn)))
        cb(math.floor(mn+r2*(mx-mn)))
    end
    upd(or2)
    tpB.MouseButton1Down:Connect(function() drg=true end)
    UIS.InputEnded:Connect(function(g) if g.UserInputType==Enum.UserInputType.MouseButton1 then drg=false end end)
    UIS.InputChanged:Connect(function(g)
        if drg and g.UserInputType==Enum.UserInputType.MouseMovement then
            upd((g.Position.X-iz.AbsolutePosition.X)/iz.AbsoluteSize.X)
        end
    end)
    return kp
end

local function mkTog(p,t,bs,cb)
    local f=N("Frame",{Size=UDim2.new(1,0,0,34),BackgroundColor3=C.BG2,BorderSizePixel=0,ZIndex=5},p)
    R(f,7) S(f,1,C.BRD)
    N("TextLabel",{Size=UDim2.new(1,-56,1,0),Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,Text=t,TextColor3=C.TXT,TextSize=13,
        Font=Enum.Font.GothamSemibold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6},f)
    local sw=N("Frame",{Size=UDim2.new(0,40,0,20),Position=UDim2.new(1,-48,0.5,-10),
        BackgroundColor3=C.BG3,BorderSizePixel=0,ZIndex=6},f)
    R(sw,10)
    local dt=N("Frame",{Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,2,0.5,-8),
        BackgroundColor3=C.TX2,BorderSizePixel=0,ZIndex=7},sw)
    R(dt,8)
    local ac=bs or false
    local function up()
        if ac then T(sw,{BackgroundColor3=C.AC2}) T(dt,{Position=UDim2.new(1,-18,0.5,-8),BackgroundColor3=C.WHT})
        else T(sw,{BackgroundColor3=C.BG3}) T(dt,{Position=UDim2.new(0,2,0.5,-8),BackgroundColor3=C.TX2}) end
        cb(ac)
    end
    up()
    local tb2=N("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=8},f)
    tb2.MouseButton1Click:Connect(function() ac=not ac up() end)
    return f
end

-- Sekmeler
local SKMR = {
    {ad="Hareket", lb="Hareket",  ik="🏃"},
    {ad="Agac",    lb="Ağaç",     ik="🌲"},
    {ad="Uzak",    lb="RemoteEvt",ik="📡"},
    {ad="Isinla",  lb="Işınla",   ik="🗺"},
    {ad="Isik",    lb="Işık",     ik="💡"},
    {ad="Hakkinda",lb="Hakkında", ik="📖"},
}
local PGS={} local SBT={}

for i,sk in ipairs(SKMR) do
    PGS[sk.ad]=mkPg(sk.ad)
    local btn=N("TextButton",{Size=UDim2.new(1,0,0,42),
        Position=UDim2.new(0,0,0,30+(i-1)*43),
        BackgroundColor3=C.BG1,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=4},kn)
    local ikK=N("Frame",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(0,10,0.5,-13),
        BackgroundColor3=C.BG2,BorderSizePixel=0,ZIndex=5},btn)
    R(ikK,6)
    N("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,
        Text=sk.ik,TextSize=13,ZIndex=6},ikK)
    local etL=N("TextLabel",{Size=UDim2.new(1,-46,1,0),Position=UDim2.new(0,44,0,0),
        BackgroundTransparency=1,Text=sk.lb,TextColor3=C.TX2,TextSize=12,
        Font=Enum.Font.GothamSemibold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5},btn)
    local akC=N("Frame",{Size=UDim2.new(0,3,0,0),AnchorPoint=Vector2.new(0,0.5),
        Position=UDim2.new(0,0,0.5,0),BackgroundColor3=C.ACC,BorderSizePixel=0,ZIndex=5},btn)
    R(akC,2)
    SBT[sk.ad]={btn=btn,ikK=ikK,etL=etL,akC=akC}
    btn.MouseEnter:Connect(function() if not PGS[sk.ad].Visible then T(btn,{BackgroundColor3=C.BG2}) end end)
    btn.MouseLeave:Connect(function() if not PGS[sk.ad].Visible then T(btn,{BackgroundColor3=C.BG1}) end end)
    btn.MouseButton1Click:Connect(function()
        for _,s in ipairs(SKMR) do
            PGS[s.ad].Visible=false
            T(SBT[s.ad].btn,{BackgroundColor3=C.BG1})
            T(SBT[s.ad].etL,{TextColor3=C.TX2})
            T(SBT[s.ad].ikK,{BackgroundColor3=C.BG2})
            T(SBT[s.ad].akC,{Size=UDim2.new(0,3,0,0)})
        end
        PGS[sk.ad].Visible=true
        T(SBT[sk.ad].btn,{BackgroundColor3=C.BG2})
        T(SBT[sk.ad].etL,{TextColor3=C.ACC})
        T(SBT[sk.ad].ikK,{BackgroundColor3=C.AC2})
        T(SBT[sk.ad].akC,{Size=UDim2.new(0,3,0,26)})
    end)
end
-- İlk sekme aç
PGS["Hareket"].Visible=true
SBT["Hareket"].btn.BackgroundColor3=C.BG2
SBT["Hareket"].etL.TextColor3=C.ACC
SBT["Hareket"].ikK.BackgroundColor3=C.AC2
SBT["Hareket"].akC.Size=UDim2.new(0,3,0,26)

-- ============ HAREKET ============
local hP=PGS["Hareket"]
local cWS,cJP=16,50
mkH(hP,"Yürüme Hızı","⚡")
mkSl(hP,16,500,16,"WalkSpeed",function(v) cWS=v if hum then hum.WalkSpeed=v end end)
mkH(hP,"Zıplama Gücü","↑")
mkSl(hP,50,700,50,"JumpPower",function(v) cJP=v if hum then hum.JumpPower=v end end)
RunService.Stepped:Connect(function() if hum then hum.WalkSpeed=cWS hum.JumpPower=cJP end end)
mkH(hP,"Uçuş","✈")
mkL(hP,"F tuşu aç/kapat | WASD yön | Boşluk/Ctrl yukarı/aşağı")
local fly,bV,bG=false,nil,nil
local function flyOn()
    if not root then return end
    if bV then bV:Destroy() end if bG then bG:Destroy() end
    bV=N("BodyVelocity",{MaxForce=Vector3.new(1e5,1e5,1e5),P=1e4,Velocity=Vector3.zero},root)
    bG=N("BodyGyro",{MaxTorque=Vector3.new(1e5,1e5,1e5),P=1e4,D=100,CFrame=root.CFrame},root)
    fly=true D("Uçuş AÇIK")
end
local function flyOff()
    if bV then bV:Destroy() bV=nil end
    if bG then bG:Destroy() bG=nil end
    fly=false D("Uçuş KAPALI")
end
mkTog(hP,"Uçuş (F tuşu)",false,function(a) if a then flyOn() else flyOff() end end)
local cam2=workspace.CurrentCamera
RunService.Heartbeat:Connect(function()
    if not fly or not bV or not root then return end
    local f=cam2.CFrame.LookVector
    local r=cam2.CFrame.RightVector
    local d=Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then d=d+f end
    if UIS:IsKeyDown(Enum.KeyCode.S) then d=d-f end
    if UIS:IsKeyDown(Enum.KeyCode.D) then d=d+r end
    if UIS:IsKeyDown(Enum.KeyCode.A) then d=d-r end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then d=d-Vector3.new(0,1,0) end
    if d.Magnitude>0 then d=d.Unit end
    bV.Velocity=d*60 bG.CFrame=CFrame.new(root.Position,root.Position+f)
end)
UIS.InputBegan:Connect(function(g,il)
    if il then return end
    if g.KeyCode==Enum.KeyCode.F then if fly then flyOff() else flyOn() end end
end)

-- ============ AĞAÇ ============
local aP=PGS["Agac"]
local AGAC={"CypressTree","ElmTree","OakTree","CherryTree","BirchTree",
    "GreenTree","PineTree","SnowGlowTree","GoldTree","FrostTree",
    "VolcanoTree","KoaTree","WalnutTree","SpookyTree","CaveCrawlerTree"}
local MKNE={"Sawmill","Planer","Painter","Cutter"}
local sAgac,sMkne="CypressTree","Sawmill"
local kayCF=nil local uzF=2 local vSay=40

mkH(aP,"Ağaç Türü","🌲")
local aSecL=mkL(aP,"Seçili: "..sAgac)
local aGrid=N("Frame",{Size=UDim2.new(1,0,0,10),BackgroundTransparency=1,ZIndex=5},aP)
local aUL=N("UIGridLayout",{CellSize=UDim2.new(0.5,-4,0,27),
    CellPadding=UDim2.new(0,5,0,5),SortOrder=Enum.SortOrder.LayoutOrder},aGrid)
aUL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    aGrid.Size=UDim2.new(1,0,0,aUL.AbsoluteContentSize.Y+4)
end)
local aBtns={}
for i,ad in ipairs(AGAC) do
    local b=N("TextButton",{BackgroundColor3=C.BG2,BorderSizePixel=0,Text=ad,
        TextColor3=C.TX2,TextSize=10,Font=Enum.Font.Gotham,TextWrapped=true,
        AutoButtonColor=false,ZIndex=6,LayoutOrder=i},aGrid)
    R(b,5) S(b,1,C.BRD) aBtns[ad]=b
    b.MouseButton1Click:Connect(function()
        for _,x in pairs(aBtns) do T(x,{BackgroundColor3=C.BG2,TextColor3=C.TX2}) end
        T(b,{BackgroundColor3=C.AC2,TextColor3=C.WHT})
        sAgac=ad aSecL.Text="Seçili: "..ad D("Ağaç: "..ad)
    end)
end

mkH(aP,"Makine Seç","🔧")
local mSecL=mkL(aP,"Seçili: "..sMkne)
local mGrid=N("Frame",{Size=UDim2.new(1,0,0,68),BackgroundTransparency=1,ZIndex=5},aP)
N("UIGridLayout",{CellSize=UDim2.new(0.5,-4,0,28),CellPadding=UDim2.new(0,5,0,5),
    SortOrder=Enum.SortOrder.LayoutOrder},mGrid)
local mBtns={}
for i,ad in ipairs(MKNE) do
    local b=N("TextButton",{BackgroundColor3=C.BG2,BorderSizePixel=0,Text=ad,
        TextColor3=C.TX2,TextSize=12,Font=Enum.Font.GothamSemibold,
        AutoButtonColor=false,ZIndex=6,LayoutOrder=i},mGrid)
    R(b,5) S(b,1,C.BRD) mBtns[ad]=b
    b.MouseButton1Click:Connect(function()
        for _,x in pairs(mBtns) do T(x,{BackgroundColor3=C.BG2,TextColor3=C.TX2}) end
        T(b,{BackgroundColor3=C.BLU,TextColor3=C.WHT})
        sMkne=ad mSecL.Text="Seçili: "..ad D("Makine: "..ad)
    end)
end

mkH(aP,"Ayarlar","⚙")
mkSl(aP,10,80,40,"Vuruş Sayısı",function(v) vSay=v end)
mkSl(aP,1,10,2,"Uzatma Faktörü",function(v) uzF=v end)

local function enYA(tur)
    if not root then return nil end
    local en,enU=nil,math.huge
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("Model") and o.Name==tur then
            local pp=o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart")
            if pp then local u=(pp.Position-root.Position).Magnitude if u<enU then en,enU=o,u end end
        end
    end
    return en
end

local function enYM(tur)
    if not root then return nil end
    local en,enU=nil,math.huge
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("Model") and o.Name:find(tur) then
            local pp=o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart")
            if pp then local u=(pp.Position-root.Position).Magnitude if u<enU then en,enU=o,u end end
        end
    end
    return en
end

mkH(aP,"Işın, Kes ve Getir","⚡")
mkL(aP,"Ağaç ve makine seçtikten sonra butona bas.")
local kBtn=mkB(aP,"▶  Işınlan → Kes → Getir",Color3.fromRGB(0,65,32),"🌲")
kBtn.MouseButton1Click:Connect(function()
    if not root then D("Karakter yok!",true) return end
    local agac=enYA(sAgac)
    if not agac then D(sAgac.." bulunamadı!",true) return end
    local pp=agac.PrimaryPart or agac:FindFirstChildWhichIsA("BasePart")
    if not pp then D("BasePart yok",true) return end
    kayCF=root.CFrame
    local ap=pp.Position
    root.CFrame=CFrame.new(ap+Vector3.new(4,4,0))
    task.wait(0.5)
    local alet=char and char:FindFirstChildOfClass("Tool")
    if not alet then D("Alet tut!",true) root.CFrame=kayCF return end
    local proxy=nil
    pcall(function()
        proxy=ReplicatedStorage:WaitForChild("Interaction",3):WaitForChild("RemoteProxy",3)
    end)
    if not proxy then D("RemoteProxy yok!",true) root.CFrame=kayCF return end
    local prc={}
    for _,p in ipairs(agac:GetDescendants()) do
        if p:IsA("BasePart") then table.insert(prc,p) end
    end
    if not table.find(prc,pp) then table.insert(prc,pp) end
    local rp=RaycastParams.new()
    rp.FilterType=Enum.RaycastFilterType.Include
    rp.FilterDescendantsInstances=prc
    D("Kesiliyor... ("..vSay.." vuruş)")
    local bas=0
    for i=1,vSay do
        local ac=(i/vSay)*math.pi*2
        local ox=ap.X+math.cos(ac)*4 local oz=ap.Z+math.sin(ac)*4
        local bg=Vector3.new(ox,ap.Y+8,oz)
        local dv=Vector3.new(ap.X-ox,-2,ap.Z-oz).Unit*15
        local hit=workspace:Raycast(bg,dv,rp)
        local hP2=hit and hit.Instance or prc[math.random(1,#prc)]
        local hPos=hit and hit.Position or (hP2 and hP2.Position or ap)
        local hN=hit and hit.Normal or Vector3.new(0,1,0)
        if hP2 then pcall(function() proxy:FireServer(alet,hP2,hPos,hN) end) bas=bas+1 end
        task.wait(0.05)
    end
    D("Kesme bitti ("..bas.."). Toplanıyor...")
    task.wait(1.5)
    local top=0
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Name=="WoodSection" then
            if (o.Position-ap).Magnitude<80 then
                o.CFrame=kayCF*CFrame.new(math.random(-5,5),1,math.random(-5,5))
                top=top+1
            end
        end
    end
    root.CFrame=kayCF
    D(top.." odun getirildi ✓")
end)

local oBtn=mkB(aP,"Odunları Geri Getir",Color3.fromRGB(55,32,0),"📦")
oBtn.MouseButton1Click:Connect(function()
    if not root then D("Karakter yok!",true) return end
    if not kayCF then D("Önce kes!",true) return end
    local n=0
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Name=="WoodSection" then
            if (o.Position-root.Position).Magnitude<300 then
                o.CFrame=kayCF*CFrame.new(math.random(-6,6),1,math.random(-6,6)) n=n+1
            end
        end
    end
    D(n.." odun getirildi.")
end)

mkH(aP,"Odun Uzat & Makineye","📏")
local uzBtn=mkB(aP,"Uzat ve Seçili Makineye Sok",Color3.fromRGB(65,42,0),"🔧")
uzBtn.MouseButton1Click:Connect(function()
    if not root then D("Karakter yok!",true) return end
    if not sMkne or sMkne=="" then D("Makine seç!",true) return end
    local enO,enOU=nil,math.huge
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") and o.Name=="WoodSection" then
            local u=(o.Position-root.Position).Magnitude
            if u<enOU then enO,enOU=o,u end
        end
    end
    if not enO then D("WoodSection yok!",true) return end
    local mak=enYM(sMkne)
    if not mak then D(sMkne.." bulunamadı!",true) return end
    local eb=enO.Size
    enO.Size=Vector3.new(eb.X,eb.Y,eb.Z*uzF)
    local mp=mak.PrimaryPart or mak:FindFirstChildWhichIsA("BasePart")
    if mp then enO.CFrame=mp.CFrame*CFrame.new(0,2,0) D(("%.1f→%.1f, %s"):format(eb.Z,enO.Size.Z,mak.Name)) end
end)

mkH(aP,"Arsa Büyütme","🏗")
local arBtn=mkB(aP,"Arsayı Full Büyüt",Color3.fromRGB(0,45,90),"🏗")
arBtn.MouseButton1Click:Connect(function()
    if not root then D("Karakter yok!",true) return end
    local n=0
    for _,o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") then
            local nm=o.Name
            if nm:find("Plot") or nm:find("Land") or nm:find("Plat") or nm=="Baseplate" then
                local s=o.Size
                o.Size=Vector3.new(math.min(s.X*2,2048),s.Y,math.min(s.Z*2,2048)) n=n+1
            end
        end
    end
    D(n>0 and n.." parça büyütüldü." or "Arsa bulunamadı!",n==0)
end)

-- ============ REMOTEEVENT ============
local uP=PGS["Uzak"]
mkH(uP,"Kaydet (Boşluk Yöntemi)","💾")
mkL(uP,"Y=-10 → düş → Y≤-45 → SaveSystem → kick")
local bCn=nil
local svBtn=mkB(uP,"Kaydet",Color3.fromRGB(0,45,110),"💾")
svBtn.MouseButton1Click:Connect(function()
    if not root then D("Karakter yok!",true) return end
    if bCn then bCn:Disconnect() bCn=nil end
    root.CFrame=CFrame.new(root.Position.X,-10,root.Position.Z)
    D("Düşülüyor...")
    bCn=RunService.Heartbeat:Connect(function()
        if not root then return end
        if root.Position.Y<=-45 then
            bCn:Disconnect() bCn=nil
            local se=nil pcall(function()
                se=ReplicatedStorage.Transactions.ClientToServer.SaveSystem
            end)
            if se then
                local ok2=pcall(function() se:FireServer() end)
                D(ok2 and "SaveSystem atıldı!" or "Hata!",not ok2)
            else D("SaveSystem yok!",true) end
            task.wait(1.8)
            LP:Kick("Kaydedildi.")
        end
    end)
end)

-- ============ IŞINLANMA ============
local iP=PGS["Isinla"]
mkH(iP,"Hızlı Işınlanma","📍")
local KNM={
    {ad="Wood R Us",x=265,y=5,z=57},{ad="Testere",x=120,y=5,z=80},
    {ad="Yanardağ",x=-1585,y=625,z=1140},{ad="Orman",x=70,y=5,z=280},
    {ad="Doğuş",x=0,y=5,z=0},{ad="Altın Ağacı",x=-750,y=140,z=900},
    {ad="Kar Ormanı",x=-1150,y=200,z=400},{ad="Mağara",x=-380,y=5,z=690},
}
for _,k in ipairs(KNM) do
    local b=mkB(iP,("%s  (%d,%d,%d)"):format(k.ad,k.x,k.y,k.z),Color3.fromRGB(20,20,48),"📍")
    b.MouseButton1Click:Connect(function()
        if not root then D("Karakter yok!",true) return end
        root.CFrame=CFrame.new(k.x,k.y+3,k.z) D(k.ad.." ✓")
    end)
end

-- ============ IŞIK ============
local lP=PGS["Isik"]
mkH(lP,"Gece/Gündüz Döngüsü","🔄")
local dSure,dSaat,dCn=60,12,nil
mkSl(lP,5,300,60,"Döngü Süresi (sn)",function(v) dSure=v end)
mkTog(lP,"Otomatik Döngü",false,function(a)
    if a then
        dCn=RunService.Heartbeat:Connect(function(dt)
            dSaat=(dSaat+dt/dSure*24)%24
            local s=math.floor(dSaat) local d=math.floor((dSaat-s)*60)
            Lighting.TimeOfDay=("%02d:%02d:00"):format(s,d)
        end)
        D("Döngü başladı.")
    else
        if dCn then dCn:Disconnect() dCn=nil end D("Döngü durdu.")
    end
end)

mkH(lP,"Manuel Saat","🕐")
local sGrid=N("Frame",{Size=UDim2.new(1,0,0,130),BackgroundTransparency=1,ZIndex=5},lP)
N("UIGridLayout",{CellSize=UDim2.new(0.5,-4,0,34),CellPadding=UDim2.new(0,5,0,5),
    SortOrder=Enum.SortOrder.LayoutOrder},sGrid)
local SAAT={{"☀ Öğle","12:00:00"},{"🌅 Gün Doğumu","06:00:00"},
    {"🌇 Akşam","18:00:00"},{"🌙 Gece","00:00:00"},
    {"🌤 Sabah","08:00:00"},{"🌆 Alacakaranlık","20:00:00"}}
for i,z in ipairs(SAAT) do
    local b=N("TextButton",{BackgroundColor3=C.BG2,BorderSizePixel=0,Text=z[1],
        TextColor3=C.TXT,TextSize=11,Font=Enum.Font.GothamSemibold,
        AutoButtonColor=false,ZIndex=6,LayoutOrder=i},sGrid)
    R(b,6) S(b,1,C.BRD)
    b.MouseEnter:Connect(function() T(b,{BackgroundColor3=C.BG3}) end)
    b.MouseLeave:Connect(function() T(b,{BackgroundColor3=C.BG2}) end)
    b.MouseButton1Click:Connect(function()
        Lighting.TimeOfDay=z[2]
        dSaat=tonumber(z[2]:sub(1,2)) or 12
        D("Saat: "..z[1])
    end)
end

mkH(lP,"Ortam","🌫")
mkTog(lP,"Sisi Kaldır",false,function(a)
    Lighting.FogEnd=a and 9e9 or 1000 D(a and "Sis yok." or "Sis geri.")
end)
mkTog(lP,"Parlak Ortam",false,function(a)
    Lighting.Ambient=a and Color3.fromRGB(180,180,180) or Color3.fromRGB(70,70,70)
    Lighting.OutdoorAmbient=a and Color3.fromRGB(220,220,220) or Color3.fromRGB(140,140,140)
    D(a and "Tam aydınlık." or "Normal ışık.")
end)
mkSl(lP,0,30,10,"Parlaklık (x0.1)",function(v) Lighting.Brightness=v/10 end)

-- ============ HAKKINDA ============
local hP2=PGS["Hakkinda"]
mkH(hP2,"LT2 Eğitim Paneli v3","📖")
for _,t in ipairs({
    "✓ Tam ekran modern dark GUI","✓ Animasyonlu sekmeler",
    "✓ WalkSpeed/JumpPower slider","✓ Uçuş sistemi (F)",
    "✓ 15 ağaç + 4 makine grid seçimi","✓ Otomatik kes & getir",
    "✓ Odun uzat & makineye sok","✓ Arsa büyütme",
    "✓ 8 ışınlanma noktası","✓ Otomatik gece/gündüz döngüsü",
    "✓ Saniyelik döngü ayarı","✓ Sis & parlaklık kontrolü",
}) do mkL(hP2,t) end

D("Panel hazır ✓")
print("[LT2 Panel] Yüklendi!")
```

**Dosya adı:** `version_1.0` (uzantısız, `.lua` ekleme)

**Kullanım:**
```
loadstring(game:HttpGet('https://raw.githubusercontent.com/KULLANICI_ADIN/REPO_ADIN/main/version_1.0'))()
