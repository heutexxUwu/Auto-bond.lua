--Plzzzz give us credit:c
--by Käthe
print("Made by Tomato and Käthe")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local Players = game:GetService("Players")
           local UserInputService = game:GetService("UserInputService")
     local TweenService = game:GetService("TweenService")
               local LocalPlayer = Players.LocalPlayer

local EcsWorld = require(ReplicatedStorage.Shared.Universe.ECS.world)
    local EcsComponents = require(ReplicatedStorage.Shared.Universe.ECS.components)
           local ClientReplicator = require(ReplicatedStorage.Client.Universe.Replication.clientReplicator)
 local NetworkRemotes = require(ReplicatedStorage.Shared.Universe.Remotes)
                 local PlayerData = require(ReplicatedStorage.Client.Universe.PlayerDataController)
local ActionEvent = ReplicatedStorage.Shared.Universe.Network.RemoteEvent.Actionable

local sgui = Instance.new("ScreenGui")
  sgui.Name = "TomatoFarmMenu"
     sgui.ResetOnSpawn = false
                 sgui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local openBtn = Instance.new("TextButton")
      openBtn.Size = UDim2.new(0, 130, 0, 45)
 openBtn.Position = UDim2.new(0, 20, 0.65, 0)
              openBtn.Text = "★ Menu"
    openBtn.Font = Enum.Font.SourceSansBold
         openBtn.TextSize = 20
openBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    openBtn.TextColor3 = Color3.fromRGB(0, 190, 255)
             openBtn.Active = true
  openBtn.Parent = sgui

local openCorner = Instance.new("UICorner")
 openCorner.CornerRadius = UDim.new(0, 14)
       openCorner.Parent = openBtn

local openStroke = Instance.new("UIStroke")
      openStroke.Thickness = 2
  openStroke.Color = Color3.fromRGB(0, 220, 255)
            openStroke.Parent = openBtn

local mainFrame = Instance.new("Frame")
 mainFrame.Size = UDim2.new(0, 260, 0, 230)
              mainFrame.Position = UDim2.new(0.5, -130, 0.4, -115)
   mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
    mainFrame.Active = true
            mainFrame.Parent = sgui

local panelCorner = Instance.new("UICorner")
      panelCorner.CornerRadius = UDim.new(0, 20)
 panelCorner.Parent = mainFrame

local panelStroke = Instance.new("UIStroke")
   panelStroke.Thickness = 2.5
          panelStroke.Color = Color3.fromRGB(0, 220, 255)
 panelStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
      titleLabel.Size = UDim2.new(1, 0, 0, 28)
 titleLabel.Position = UDim2.new(0, 0, 0, 12)
           titleLabel.Text = "★ TOMATOUNU V1 ★"
  titleLabel.Font = Enum.Font.SourceSansBold
              titleLabel.TextSize = 22
    titleLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
         titleLabel.BackgroundTransparency = 1
titleLabel.Parent = mainFrame

local authorLabel = Instance.new("TextLabel")
    authorLabel.Size = UDim2.new(1, 0, 0, 18)
          authorLabel.Position = UDim2.new(0, 0, 0, 40)
  authorLabel.Text = "by Käthe"
             authorLabel.Font = Enum.Font.SourceSansItalic
 authorLabel.TextSize = 15
      authorLabel.TextColor3 = Color3.fromRGB(255, 102, 178)
            authorLabel.BackgroundTransparency = 1
  authorLabel.Parent = mainFrame

local autoBondBtn = Instance.new("TextButton")
      autoBondBtn.Size = UDim2.new(0, 210, 0, 48)
 autoBondBtn.Position = UDim2.new(0.5, -105, 0, 80)
            autoBondBtn.Text = "Auto Bond [OFF]"
  autoBondBtn.Font = Enum.Font.SourceSansBold
       autoBondBtn.TextSize = 19
autoBondBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoBondBtn.BackgroundColor3 = Color3.fromRGB(0, 190, 255)
             autoBondBtn.Active = true
  autoBondBtn.Parent = mainFrame

local bondCorner = Instance.new("UICorner")
 bondCorner.CornerRadius = UDim.new(0, 12)
       bondCorner.Parent = autoBondBtn

local lobbyBtn = Instance.new("TextButton")
      lobbyBtn.Size = UDim2.new(0, 210, 0, 48)
 lobbyBtn.Position = UDim2.new(0.5, -105, 0, 145)
            lobbyBtn.Text = "Return to Lobby"
  lobbyBtn.Font = Enum.Font.SourceSansBold
       lobbyBtn.TextSize = 19
lobbyBtn.TextColor3 = Color3.fromRGB(0, 150, 220)
    lobbyBtn.BackgroundColor3 = Color3.fromRGB(230, 247, 255)
             lobbyBtn.Active = true
  lobbyBtn.Parent = mainFrame

local lobbyCorner = Instance.new("UICorner")
 lobbyCorner.CornerRadius = UDim.new(0, 12)
       lobbyCorner.Parent = lobbyBtn

local lobbyStroke = Instance.new("UIStroke")
      lobbyStroke.Thickness = 1.5
  lobbyStroke.Color = Color3.fromRGB(0, 210, 255)
            lobbyStroke.Parent = lobbyBtn

openBtn.MouseButton1Click:Connect(function()
 mainFrame.Visible = not mainFrame.Visible
end)

local function makeDraggable(guiObject)
 local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
 dragStart = input.Position
             startPos = guiObject.Position
        input.Changed:Connect(function()
          if input.UserInputState == Enum.UserInputState.End then
            dragging = false
          end
        end)
      end
    end)
 guiObject.InputChanged:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
     dragInput = input
   end
 end)
 UserInputService.InputChanged:Connect(function(input)
   if input == dragInput and dragging then
     local delta = input.Position - dragStart
          guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
   end
 end)
end

makeDraggable(mainFrame)
makeDraggable(openBtn)

local autoBondEnabled = false

autoBondBtn.MouseButton1Click:Connect(function()
 autoBondEnabled = not autoBondEnabled
  if autoBondEnabled then
        autoBondBtn.Text = "Auto Bond [ON]"
    autoBondBtn.BackgroundColor3 = Color3.fromRGB(0, 230, 180)
  else
        autoBondBtn.Text = "Auto Bond [OFF]"
    autoBondBtn.BackgroundColor3 = Color3.fromRGB(0, 190, 255)
  end
end)

task.spawn(function()
 while true do
   if autoBondEnabled then
     local clientState = EcsWorld:get_resource(EcsComponents.ClientStateResource)
     local characterEntity = clientState and clientState.localCharacter

     if characterEntity then
       if not EcsWorld:has(characterEntity, EcsComponents.Sack) then
         EcsWorld:add(characterEntity, EcsComponents.Sack)
         EcsWorld:set(characterEntity, EcsComponents.Sack, { 
           contents = {}, 
           maxContents = 10 
         })
       end

       for entityId = 1, 100000 do
         local isStorable = EcsWorld:has(entityId, EcsComponents.Storable)
         local objectId = EcsWorld:get(entityId, EcsComponents.ObjectId)

         if isStorable and objectId == "bond" then
           local serverEntity = ClientReplicator:get_server_entity(entityId)
           if serverEntity and serverEntity ~= entityId then
             NetworkRemotes.Store:FireServer(serverEntity)
             NetworkRemotes.Store:FireServer()
             ActionEvent:FireServer(serverEntity)
           end
         end
       end
     end
   end
   task.wait(1)
 end
end)

lobbyBtn.MouseButton1Click:Connect(function()
 pcall(function()
   if NetworkRemotes and NetworkRemotes.ReturnToLooby then
     NetworkRemotes.ReturnToLooby:FireServer()
   else
     local remote = ReplicatedStorage:FindFirstChild("ReturnToLooby", true)
     if remote and remote:IsA("RemoteEvent") then
       remote:FireServer()
     end
   end
 end)
end)
Print("🇩🇪welovegermanyofc🇪🇺)
