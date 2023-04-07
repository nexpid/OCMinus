local HTTPs = game:GetService("HttpService")
local plr = game.Players.LocalPlayer

local OCDTLast = tick()
_G.OCDTLast = OCDTLast
local function exitt()
    if _G.OCDTLast ~= OCDTLast then return error("reloaded") end
end

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "OC Donation Thing",
    LoadingTitle = "OC Donation Thing",
    LoadingSubtitle = "by nexx",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "OCScripts",
       FileName = "OC Donation Thing"
    },
    Discord = {
        Enabled = true,
        Invite = "Mpw6b7vQfJ",
        RememberJoins = true
    },
    KeySystem = false,
})

local userLEL

local isDoing = false
local user, userI = plr.Name, plr.UserId
local function setUser()
	userLEL:Set(("Current User: @%s (%s)"):format(user, userI))
end

local function notify(title, content)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = 2,
        Actions = {
            Ignore = {
                Name = "Dismiss",
                Callback = function() end
            }
        }
    })
end

local Tab = Window:CreateTab("Main")

Tab:CreateInput({
    Name = "Enter User",
    PlaceholderText = "Enter the user",
    RemoveTextAfterFocusLost = true,
    Callback = function(txt)
        if isDoing then return end

		userLEL:Set("...")
        local scs, id = pcall(game.Players.GetUserIdFromNameAsync, game.Players, txt)
        if not scs or not id then notify("Error", "Invalid user!"); return setUser() end

        local scss, userr = pcall(game.Players.GetNameFromUserIdAsync, game.Players, id)
        if not scs or not id then notify("Error", "Invalid user!"); return setUser() end

        user, userI = userr, id
        setUser()
    end
})

userLEL = Tab:CreateLabel("")
setUser()

local statusEL
local status = false
local function updateStatus()
    statusEL:Set(("Status: %s"):format(status or "-"))
end

local ui = plr.PlayerGui.Edit.PropertiesFrame.GlobalFrame.Donations.ScrollingFrame
local function getDonationsNum()
    return #ui:GetChildren() - 1
end
local function getFirstDonation()
    for _, x in pairs(ui:GetChildren()) do
        if x ~= ui.AddFrame then return x end
    end
end
local function updateDono(num, data)
    return game.ReplicatedStorage.Events.UpdateDonations:InvokeServer(num, data)
end
local function updateAlign(reduce)
    if reduce then reduce = tonumber(reduce) end

    local list = 0
    for _, x in pairs(ui:GetChildren()) do
        local num = tonumber(x.Name)
        if x ~= ui.AddFrame and num then
            if reduce and num <= reduce then list = math.max(num, list); continue end
            
            if reduce then num -= 1; end
            x.Name = num
            x.Position = UDim2.new(0, 0, (num-1) * 0.09, 0)

            list = math.max(num, list)
        end
    end

    ui.AddFrame.Position = UDim2.new(0, 0, list * 0.09, 0)
end
local function makeDono(num, name)
    if name then
        if not ui:FindFirstChild(num) then
            local frm = ui.Parent.ExampleFrame:Clone()
            frm.Name = num
            frm.Position = UDim2.new(0, 0, num - 1 * 0.09, 0)
            frm.NameFrame.Title.Text = name
            frm.Visible = true
            frm.DeleteButton.Activated:Connect(function()
                if isDoing then return end

                if updateDono(tonumber(frm.Name)) then
                    frm:Destroy()
                    updateAlign(tonumber(frm.Name))
                end
            end)
            frm.Parent = ui
            updateAlign()
            return
        end
    else
        num = tostring(num)
        if ui:FindFirstChild(num) then
            ui[num]:Destroy()
            updateAlign(num)
            return
        end
    end

    updateAlign()
end
updateAlign()

local clearButtonEL = Tab:CreateButton({
    Name = "Clear All Donations",
    Callback = function()
        if isDoing then return end

        isDoing = true
        status = "Preparing..."
        updateStatus()

        local toDid, toDo = 0, getDonationsNum()
        while true do
            exitt()
            toDo = math.max(getDonationsNum(), toDo)
            if toDid >= toDo then break end
            local fist = getFirstDonation()
            if not fist then break end

            status = ("Clearing Donations: %s/%s"):format(toDid, toDo)
            updateStatus()

            local num = tonumber(fist.Name)
            if updateDono(num) then
                makeDono(num)
                toDid += 1
                task.wait(0.25)
            end
            task.wait()
        end

        isDoing, status = false, false
        updateStatus()
    end
})

local donationSort
local makeDonationSortEL = Tab:CreateDropdown({
    Name = "Player Donation Sort",
    Options = {"Cheap First", "Expensive First"},
    CurrentOption = "Cheap First",
    MultipleOptions = false,
    Flag = "PDonationSort",
    Callback = function(option)
        donationSort = option
    end
})
local makeButtonEL = Tab:CreateButton({
    Name = "Make Player Donations",
    Callback = function()
        if isDoing then return end

        isDoing = true
        status = "Preparing..."
        updateStatus()

        status = "Fetching..."
        updateStatus()

        local cursor = ""
        local page = 0
        local stuff = {}
        local hasPrice = {}
        local function makeRequest()
            exitt()

            -- use roproxy.com if used in-game wink wink
            local red = game:HttpGet(("https://www.roblox.com/users/inventory/list-json?assetTypeId=34&itemsPerPage=100&pageNumber=1&userId=%s&cursor=%s"):format(userI, cursor))
            local scs, json = pcall(HTTPs.JSONDecode, HTTPs, red)
            if not scs or not json then return end

            if not json.Data or not json.Data.Items then return notify("Error", ("%s doesn't have their inventory enabled!"):format(user)) end

            for _, x in pairs(json.Data.Items) do
                if not x.Product then continue end
                if x.Creator.Id ~= userI then continue end
                if not x.Product.IsForSale then continue end
                if x.Product.PriceInRobux < 1 then continue end

                if hasPrice[x.Product.PriceInRobux] then continue end
                hasPrice[x.Product.PriceInRobux] = true

                stuff[#stuff+1] = {
                    id = x.Item.AssetId,
                    price = x.Product.PriceInRobux,
                    name = ("%s | [%s]"):format(x.Item.Name, x.Product.PriceInRobux)
                }
            end
            
            page += 1
            status = ("Fetching... (page %s, items %s)"):format(page, #stuff)
            updateStatus()

            if #json.Data.Items ~= 100 then return end
            if not json.Data.nextPageCursor then return end

            cursor = json.Data.nextPageCursor
            return makeRequest()
        end

        makeRequest()
        table.sort(stuff, function(a, b)
            return (donationSort == "Cheap First") and b.price > a.price or a.price > b.price
        end)

        local i = 1
        while true do
            exitt()
            if i > 10 then break end
            if i >= #stuff then break end

            status = ("Adding: %s/%s"):format(i-1, #stuff)
            updateStatus()

            local stu = stuff[i]
            local cur = getDonationsNum()+1
            if updateDono(cur, stu.id) then
                makeDono(cur, stu.name)
                i += 1
                task.wait(0.25)
            end
            task.wait()
        end

        isDoing, status = false, false
        updateStatus()
    end
})
statusEL = Tab:CreateLabel("")

updateStatus()