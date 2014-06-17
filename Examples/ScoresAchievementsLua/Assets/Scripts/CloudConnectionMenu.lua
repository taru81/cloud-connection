-- This Script file processes the actions for a GUI that demonstrate Google Play Games basic functions
-- Signin/out, show highscore, show achievements, submit a high score, unlocking an achievement
-- See MainMenu.xml for the definition of the menu items
-- For tutorial on how to use the GUI system in lua then please see http://www.projectanarchy.com/guis-lua

--this is the ID of the achievement that this demo unlocks
--get this from the google developer console when you create your achievements
local ACHIEVEMENT_ID = "CggI9__cunsQAhAB"     

--this is the ID of the leaderboard that this demo will submit a score to
--get this from the google developer console when you create your leaderboard
local LEADERBOARD_ID = "CggI9__cunsQAhAC" 

function OnAfterSceneLoaded()  
  -- adding listener for CloudConnection callbacks for to this script
  local ccClient = CloudConnection:GetClient()
  ccClient:AddScriptCallbackListener()    
         
  -- Enable debug output in the log file so we can see that callbacks are working
  Debug:Enable(true)
     
  -- test that we can get an acheivement via 'OnAchievementFetched' callback
  ccClient:GetAchievement( ACHIEVEMENT_ID )
end

function OnBeforeSceneUnloaded()
  
  -- removing listener for CloudConnection callbacks for to this script
  local ccClient = CloudConnection:GetClient()
  ccClient:RemoveScriptCallbackListener()    
end

-- called when an item in the menu is clicked
function OnItemClicked(self, uiItem, buttons, mousePosX, mousePosY)
  -- get the cloud connection client
  local ccClient = CloudConnection:GetClient()
        
  -- action the button that was pressed
  if uiItem:GetID() == GUI:GetID("SIGNIN") then  
    -- show the user sign-in dialog
    ccClient:BeginUserInitiatedSignIn() 
    
  elseif uiItem:GetID() == GUI:GetID("SIGNOUT") then  
    -- signs the user out
    ccClient:SignOut()
    
  elseif uiItem:GetID() == GUI:GetID("ALLACH") then  
    -- show the UI for all achievements for the signed in player
    ccClient:ShowAchievements()
    
  elseif uiItem:GetID() == GUI:GetID("UNLOCKACH") then  
    -- unlocks an achievements for the signed in player
    ccClient:UnlockAchievement( ACHIEVEMENT_ID )
    
  elseif uiItem:GetID() == GUI:GetID("ALLLEAD") then  
    -- shows the UI for all leaderboards for the signed in player
    ccClient:ShowLeaderboards()
    
  elseif uiItem:GetID() == GUI:GetID("SUBMITSCORE") then  
    -- submits a high score to a leaderboard
    local highScore = 12346;      
    ccClient:SubmitScore( LEADERBOARD_ID, highScore )
    
  end
  
end

--This callback is made to the script when the Cloud Connection
--Client has started the authorisation process
function OnAuthActionStarted()
  Debug:Log("OnAuthActionStarted callback was successfully made to Lua script")
end

--This callback is made to the script when the Cloud Connection
--Client has finsihed the authorisation process, either succesfully or unsucesfully
function OnAuthActionFinished()
  Debug:Log("OnAuthActionFinished callback was successfully made to Lua script")
end

--This callback is made to the script when the Cloud Connection
--Client has retrived the player data, this means that calls
--to GetUserDisplayName() will now return a valid value
function OnPlayerDataFetched()
  Debug:Log("OnPlayerDataFetched callback was successfully made to Lua script")
end

--This callback is made to the script when the Cloud Connection
--Client has retrived achievement data via the GetAchievement( id ) call
function OnAchievementFetched( id, name, description, achtype, achstate, totalsteps, currentsteps )
  Debug:Log("OnAchievementFetched callback was successfully made to Lua script")
  Debug:Log("ID=")
  Debug:Log(id)
  Debug:Log(name)
  Debug:Log(description)
  Debug:Log(achtype)
  Debug:Log(achstate)
  Debug:Log(totalsteps)
  Debug:Log(currentsteps)
end


function AuthenticationChanged()

  if G.basicGUI ~= nil then
    --Get the instance of the cloud connection client
    local ccClient = CloudConnection:GetClient()
    local isAutenticated = ccClient:IsAuthenticated()

    SetButtonStatus("SIGNIN", not isAutenticated );          
    SetButtonStatus("ALLACH", isAutenticated );        
    SetButtonStatus("UNLOCKACH", isAutenticated );
    SetButtonStatus("ALLLEAD", isAutenticated );
    SetButtonStatus("SUBMITSCORE", isAutenticated );
    SetButtonStatus("SIGNOUT", isAutenticated );
  end
  
end

--[[
function SetButtonStatus( buttonID, enabled )
  if G.basicGUI ~= nil then

    --find the text label to display the text in
	  VMenuItemCollection* items = &spMainDlg->Items();

    --enable the signout button if we are authenticated
	  VDlgControlBasePtr vdlg = items->FindItem( VGUIManager::GetID( buttonID ) );
	  VASSERT_MSG( vdlg != NULL, "The dialog does not have a label with ID '%s'", buttonID );
	  VPushButton* pButton = vstatic_cast<VPushButton*>(vdlg);      	--check this is a VPushButton and set enable/disable
	  pButton->SetEnabled( enabled ); 
  end
end
]]--
