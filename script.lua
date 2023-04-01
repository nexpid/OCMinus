-- Services n stuff
local RNs = game:GetService("RunService")
local CAs = game:GetService("ContextActionService")
local TWNs = game:GetService("TweenService")

local plr = game.Players.LocalPlayer

local hui = gethui and gethui() or game.CoreGui
local asset = getcustomasset or getsynasset

-- Init
if workspace:FindFirstChild("cstatus") then workspace.cstatus:Destroy() end
if hui:FindFirstChild("ocminus") then hui.ocminus:Destroy() end
if game.CoreGui:FindFirstChild("ocminus") then game.CoreGui.ocminus:Destroy() end

local ocminus = Instance.new("ScreenGui", hui)
ocminus.Name = "ocminus"
ocminus.DisplayOrder = 6969
ocminus.IgnoreGuiInset = true
ocminus.ResetOnSpawn = false

local bandicam = Instance.new("ImageLabel", ocminus)
bandicam.BackgroundTransparency = 1
bandicam.Name = "bandicam"
bandicam.Size = UDim2.new(1, 0, 0.08, 0)
bandicam.ScaleType = Enum.ScaleType.Fit
bandicam.Visible = false

local function ntf(text, color, time)
	plr.PlayerGui.LocalOutput:Fire(text, color or Color3.new(1, 1, 1), time or 5)
end
local function restricted()
	return ntf("This function has been restricted by OC-!", Color3.new(1, 0.2, 0.2), 6)
end

for _, x in pairs(_G.OCMevs or {}) do
	x:Disconnect()
end
_G.OCMevs = {}

local function evn(e)
	_G.OCMevs[#_G.OCMevs+1] = e
end

local status = Instance.new("Message", workspace)
status.Name = "cstatus"
status.Text = "loading"

local function sstatus(act, ...)
	local args = {...}
	if act == "download" then status.Text = ("Downloading Files %s/%s"):format(args[1], args[2]) end
end

local rootLink = "https://raw.githubusercontent.com/Gabe616/OCMinus/main/"
local function ghLink(x)
	return rootLink.."assets/links/"..x
end
local links = {
	videos = {
		intro = ghLink("videos/intro.webm"),
		intro1 = ghLink("videos/intro1.webm"),
		intro2 = ghLink("videos/intro2.webm"),
		intro3 = ghLink("videos/intro3.webm"),
		intro4 = ghLink("videos/intro4.webm"),
		intro5 = ghLink("videos/intro5.webm"),
	},
	familyguy = {
		vid1 = ghLink("familyguy/vid1.webm"),
		vid2 = ghLink("familyguy/vid2.webm"),
		vid3 = ghLink("familyguy/vid3.webm"),
		vid4 = ghLink("familyguy/vid4.webm"),
		vid5 = ghLink("familyguy/vid5.webm"),
		vid6 = ghLink("familyguy/vid6.webm"),
		vid7 = ghLink("familyguy/vid7.webm"),
		vid8 = ghLink("familyguy/vid8.webm"),
		vid9 = ghLink("familyguy/vid9.webm"),
		vid10 = ghLink("familyguy/vid10.webm"),
		vid11 = ghLink("familyguy/vid11.webm"),
		vid12 = ghLink("familyguy/vid12.webm"),
		vid13 = ghLink("familyguy/vid13.webm"),
		vid14 = ghLink("familyguy/vid14.webm"),
		vid15 = ghLink("familyguy/vid15.webm")
	}
}
local atts = {
	videos = ".webm",
	familyguy = ".webm"
}
local maxFiles = 21
local files = 0

-- File Loader
sstatus("download", 0, maxFiles)
if not isfolder("ocminus") then makefolder("ocminus") end

for A, B in pairs(links) do
	local a = atts[A]
	if not isfolder("ocminus/"..A) then makefolder("ocminus/"..A) end
	for f, x in pairs(B) do
		sstatus("download", files, maxFiles)
		local path = "ocminus/"..A.."/"..f..a
		if not isfile(path) then
			writefile(path, game:HttpGet(x))
			asset(path)
		end
		files += 1
		sstatus("download", files, maxFiles)
	end
end

bandicam.Image = "rbxassetid://12956416057"

local function playVideo(video)
	local vid = Instance.new("VideoFrame")
	vid.Parent = ocminus
	vid.Name = "video"
	vid.BackgroundTransparency = 1
	vid.Size = UDim2.new(1, 0, 1, 0)
	vid.Video = video
	vid.Visible = true
	vid.Volume = 2

	repeat task.wait() until vid.IsLoaded

	vid:Play()
	vid.Ended:Wait()
	vid:Destroy()
end

status.Parent = nil

-- trolling
local ui = plr.PlayerGui.Edit
local settings = ui.SettingsFrame

settings.ThisFrame.CameraSens.Visible = false
settings.ThisFrame.Copyrighted.Visible = false
settings.ThisFrame.DarkMode.Visible = false
settings.ThisFrame.DayValue.Visible = false
settings.ThisFrame.DragEnabled.Visible = false
settings.ThisFrame.InvisiblePlayers.Visible = false
settings.ThisFrame.IsGodMode.Visible = false
settings.ThisFrame.MoveUnderground.Visible = false
settings.ThisFrame.SnapRotation.Visible = false
settings.ThisFrame.TeamRequests.Visible = false

local incr = settings.ThisFrame.Increments
incr.Visible = true
if incr:FindFirstChild("MoveBoxA") then incr.MoveBoxA:Destroy() end
if incr:FindFirstChild("RotateBoxA") then incr.RotateBoxA:Destroy() end
if incr:FindFirstChild("Block") then incr.Block:Destroy() end

incr.MoveBox.Visible = false
incr.RotateBox.Visible = false

local faint = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local rotateBoxA = Instance.new("TextLabel", incr)
rotateBoxA.Name = "RotateBoxA"
rotateBoxA.FontFace = faint
rotateBoxA.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
rotateBoxA.BorderSizePixel = 0
rotateBoxA.AnchorPoint = Vector2.new(0, 0.5)
rotateBoxA.Position = UDim2.new(0.55, 0, 0.5, 0)
rotateBoxA.Size = UDim2.new(0.45, 0, 1, 0)
rotateBoxA.TextScaled = true
rotateBoxA.TextColor3 = Color3.new(1, 1, 1)
rotateBoxA.Text = "90"
rotateBoxA.ZIndex = 3
incr.RotateBox.Title:Clone().Parent = rotateBoxA

local moveBoxA = rotateBoxA:Clone()
moveBoxA.Parent = incr
moveBoxA.Name = "MoveBoxA"
moveBoxA.Position = UDim2.new(0, 0, 0.5, 0)
moveBoxA:ClearAllChildren()
moveBoxA.Text = "1"
incr.MoveBox.Title:Clone().Parent = moveBoxA

local block = Instance.new("TextButton", incr)
block.Name = "Block"
block.Active = true
block.BackgroundTransparency = 1
block.Text = ""
block.Size = UDim2.new(1, 0, 1, 0)
block.Position = UDim2.new()
block.Activated:Connect(restricted)

for _, x in pairs(getconnections(settings.TutorialButton.Activated)) do
	x:Disable()
end
evn(settings.TutorialButton.Activated:Connect(restricted))

local music = settings.ThisFrame.MusicFrame
music.Position = UDim2.new(0.25, 0, 0.875, 0)
music.Mute.Position = music.Back1.Position
music.Back1.Visible = false
music.Back10.Visible = false
music.Skip1.Visible = false
music.Skip10.Visible = false
music.TextLabel.TextXAlignment = Enum.TextXAlignment.Left

local frm = settings.ThisFrame.Frame
local choose = ui.ChooseFrame
local selfr = ui.SelectionFrame
local plugingui = plr.PlayerGui.PluginGui.BackFrame

firesignal(choose.Buttons.Basic.Activated)

if game.SoundService:FindFirstChild("gang") then game.SoundService.gang:Destroy() end
local gang = Instance.new("SoundGroup", game.SoundService)
gang.Volume = 1
gang.Name = "gang"

plr.PlayerGui.Music.CurrentlyPlaying.SoundGroup = gang

local shop = ui.GamepassesFrame.Shop
for _, x in pairs(shop:GetChildren()) do
	if not x:IsA("TextButton") then continue end

	for _, y in pairs(getconnections(x.Activated)) do
		y:Disable()
	end
	evn(x.Activated:Connect(function()
		restricted()
		shop.Parent.Visible = false
	end))
end

local mptel = plr.PlayerGui["Money+Tele"]
evn(RNs.RenderStepped:Connect(function()
	for _, x in pairs(choose.Buttons:GetChildren()) do
		if x:IsA("TextButton") then x.Visible = x.Name == "Basic" end
	end

	plr.leaderstats.Cash.Value = 80085
	plr.leaderstats.Gems.Value = 80085
	
	settings.TutorialButton.Position = settings.ClearButton.Position
	settings.PermissionButton.Visible = false
	settings.RevertButton.Visible = false
	settings.ClearButton.Visible = false
	settings.TutorialButton.AutoButtonColor = false

	frm["Buttons"].Text = "Buttons: 0/∞"
	frm["Character Models"].Text = "Character Models: 0/∞"
	frm["Conveyors"].Text = "Conveyors: 0/∞"
	frm["Moving Parts"].Text = "Moving Parts: 0/∞"
	frm["Push Parts"].Text = "Push Parts: 0/∞"
	frm["Spin Parts"].Text = "Spin Parts: 0/∞"
	frm["Timed Parts"].Text = "Timed Parts: 0/∞"
	frm["Water"].Text = "Water: 0/∞"

	mptel.TeleButton.MoneyLabel.Text = "$∞"
	mptel.TeleButton.MoneyLabel["Cash Limit"].Visible = false

	selfr.DeleteButton.Visible = false
	selfr.MultiButton.Visible = false
	selfr.TeleButton.Visible = false
	selfr.SettingsButton.Position = UDim2.new(0.4, -5, 1, -10)
	selfr.CloneButton.Position = UDim2.new(0.5, 0, 1, -10)
	selfr.ModeButton.Position = UDim2.new(0.6, 5, 1, -10)
	selfr.LocalImage.Position = UDim2.new(0.7, 5, 1, -10)

	for _, x in pairs(plugingui.Frame.MainFrame:GetChildren()) do
		if x:IsA("Frame") then x.Visible = false end
	end

	bandicam.Visible = plr.PlayerGui.ScreenshotMode.Value

	plr.PlayerGui.DidYouKnow.Frame.Desc.Text = "OC- is the best and only Obby Creator enhancement!"
end))

CAs:UnbindAction("Tilt/Teleport")
CAs:UnbindAction("Rotate")
CAs:UnbindAction("Delete")

-- gaslight gatekeep girlboss
local metaID = tick()
_G.ocmMetaID = metaID

local tpObby = "304346361#13"

local OLD
OLD = hookmetamethod(game, "__namecall", function(...)
	if _G.ocmMetaID ~= metaID then return OLD(...) end
	local args = {...}

	if getnamecallmethod() == "FireServer" or getnamecallmethod() == "InvokeServer" then
		if tostring(args[1]) == "LoadObby" then
			args[2] = tpObby
		elseif tostring(args[1]) == "LoadRandomObby" then
			args[1] = game.ReplicatedStorage.Events.LoadObby
			args[2] = tpObby
		end
	end

	return OLD(unpack(args))
end)

-- hardest part - family guy clips
local canSpawn = true
task.spawn(function()
	while _G.ocmMetaID == metaID do
		if Random.new():NextNumber(0, 1) < 0.5 and canSpawn then
			local vid = Random.new():NextInteger(1, 15)
			task.spawn(function()
				local vid = Instance.new("VideoFrame", ocminus)
				vid.Name = "famiyl guy!!!!!!!!!"
				vid.BackgroundTransparency = 1
				vid.Size = UDim2.new(0, 15, 0, 15)
				vid.Video = asset("ocminus/familyguy/vid"..tostring(vid)..".webm")
				vid.Visible = true
			
				repeat task.wait() until vid.IsLoaded and vid.Resolution.Magnitude > 3

				local res = vid.Resolution.X / vid.Resolution.Y
				local sX, sY = res*0.5, 0.5
				vid.Size = UDim2.new(sX, 0, sY, 0)
				vid.SizeConstraint = Enum.SizeConstraint.RelativeYY

				vid.Volume = 2

				local left, right = 0, 1-sX
				local top, bottom = 0, 1-sY
				local x, y = Random.new():NextNumber(left, right), Random.new():NextNumber(top, bottom)

				local spd = 0.003
				local dX, dY = 1, -1

				local evan = RS.RenderStepped:Connect(function()
					x += dX*spd
					y += dY*spd

					if x >= 1 then
						x = 1 + (1-x)
						dX = -1
					elseif x < 0 then
						x = math.abs(x)
						dX = 1
					end
					
					if y >= 1 then
						y = 1 + (1-y)
						dY = -1
					elseif y < 0 then
						y = math.abs(y)
						dY = 1
					end

					vid.Position = UDim2.new(x, 0, y, 0)
					vid.AnchorPoint = Vector2.new(x, y)
				end)
				evn(evan)

				vid:Play()
				vid.Ended:Wait()
				vid:Destroy()
				evan:Disconnect()
			end)
		end

		task.wait(Random.new():NextNumber(2, 6))
	end
end)

-- Play Intro Video Lmao
if not _G.ocmLoaded then
	_G.ocmLoaded = true
	canSpawn = false
	local loaded = "intro"
	local random = Random.new():NextInteger(1, 6)-1
	if random ~= 0 then loaded ..= tostring(random) end

	TWNs:Create(gang, TweenInfo.new(0.6), {
		Volume = 0
	}):Play()
	playVideo(
		asset("ocminus/videos/"..loaded..".webm")
	)
	TWNs:Create(gang, TweenInfo.new(0.6), {
		Volume = 1
	}):Play()
	canSpawn = true
end