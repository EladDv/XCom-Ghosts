// Useless Class so far
                           
class UI_Listener_UIMission_MoreCivis extends UIScreenListener config(Ghosts); // NOT WORKING!

struct CivCountRandomiser
{
	var int	MinCivCount;
	var int	MaxCivCount;
};

var class<UIScreen> ScreenClass;				//causes warning but needed to trigger OnReceiveFocus()
var config bool					UseMoreCivis;
var config CivCountRandomiser	CiviliansCounts;

//var	UITacticalHUD MyScreen;	
event OnReceiveFocus(UIScreen Screen)
{
//	local Object ThisObj;
	local XComGameState_MissionSite MissionSite,NewSite;
	local XComGameState NewGameState;
	local int i,RandomNum;
	local XComGameState_HeadquartersXCom XComHQ;

//	ThisObj=self;
	//MyScreen=UITacticalHUD(Screen);
//	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnBegun', DrawFoVCone, ELD_OnStateSubmitted,70);			
//	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnEnded', DrawFoVCone, ELD_OnStateSubmitted,70);	
  	//`XEVENTMGR.RegisterForEvent(ThisObj,'MissionDoneBuilding', InsertCivisToMissions ,10);
	if(Screen.IsA('UISquadSelect'))
	{
		`log("----------------------------------------------------------------------",true,'DragonPunk Stealth Mod');	
		`log("Inserting Civis To Missions Listener",true,'DragonPunk Stealth Mod');	
		`log("----------------------------------------------------------------------",true,'DragonPunk Stealth Mod');	
		i=0;
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding New Missions");
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class' XComGameState_HeadquartersXCom'));
		MissionSite= XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
		if(MissionSite.GeneratedMission.Mission.MinCivilianCount<0 && MissionSite!=none)
		{
			NewSite=XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite', MissionSite.ObjectID));
			i++;	
			RandomNum= CiviliansCounts.MinCivCount+ Rand((CiviliansCounts.MaxCivCount- CiviliansCounts.MinCivCount) +1);
			NewSite.GeneratedMission.Mission.MinCivilianCount=40;//RandomNum;
			NewGameState.AddStateObject(NewSite);
			`log("Inserting Civis To Missions, Number:"@i,true,'DragonPunk Stealth Mod');	
		}
		if(NewGameState.GetNumGameStateObjects() > 0 )
			`XCOMHISTORY.AddGameStateToHistory(NewGameState);
		else
			`XCOMHISTORY.CleanupPendingGameState(NewGameState);

		UISquadSelect(Screen).UpdateMissionInfo();

	}
	   //NOT WORKING!
	
}


defaultproperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	ScreenClass=none;
}	