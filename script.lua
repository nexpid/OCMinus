-- Services n stuff
local plr = game.Players.LocalPlayer
local hui = (gethui) and gethui() or game.CoreGui
local asset = getcustomasset or getsynasset

-- Init
if hui:FindFirstChild("ocminus") then hui.ocminus:Destroy() end

local ocminus = Instance.new("ScreenGui", hui)
ocminus.Name = "ocminus"
ocminus.IgnoreGuiInset = true
ocminus.ResetOnSpawn = false

_G.OCMevs = {}
for _, x in pairs(_G.OCMevs or {}) do
	x:Disconnect()
end

local function evn(e)
	_G.OCMevs[#_G.OCMevs+1] = e
end

local status = Instance.new("Message", hui)
status.Name = "status"
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
		intro = ghLink("videos/intro.webm")
	},
	audios = {
		intro = ghLink("audios/intro.mp3")
	}
}
local atts = {
	videos = ".webm",
	audios = ".mp3"
}
local maxFiles = 3
local files = 0

-- File Loader
sstatus("download", 0, maxFiles)
if not isfolder("ocminus") then makefolder("ocminus") end

for A, B in pairs(links) do
	local a = atts[A]
	for f, x in pairs(B) do
		sstatus("download", files, maxFiles)
		local path = "ocminus/"..A.."/"..f..a
		if not isfile(path) then
			writefile(path, game:HttpGet(x))
			files += 1
		end
		sstatus("download", files, maxFiles)
	end
end

local function playVideo(video, audio)
	local vid = Instance.new("VideoFrame")
	vid.Parent = ocminus
	vid.Name = "video"
	vid.BackgroundTransparency = 1
	vid.Size = UDim2.new(1, 0, 1, 0)
	vid.Video = video
	vid.Visible = true
	local aud = Instance.new("Sound")
	aud.Name = "video audio"
	aud.Parent = ocminus
	aud.SoundId = audio

	repeat task.wait() until vid.IsLoaded and aud.IsLoaded

	vid:Play()
	aud:Play()
	vid.Ended:Wait()
	vid:Destroy()
	aud:Destroy()
end

status.Parent = nil

-- Play Intro Video Lmao
playVideo(
	asset("ocminus/videos/intro.webm"),
	asset("ocminus/audios/intro.mp3")
)