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
	local Object ThisObj;
	local XComGameState_MissionSite MissionSite;
	local int i,RandomNum;

	ThisObj=self;
	//MyScreen=UITacticalHUD(Screen);
//	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnBegun', DrawFoVCone, ELD_OnStateSubmitted,70);			
//	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnEnded', DrawFoVCone, ELD_OnStateSubmitted,70);	
  	//`XEVENTMGR.RegisterForEvent(ThisObj,'MissionDoneBuilding', InsertCivisToMissions ,10);
	`log("----------------------------------------------------------------------",true,'DragonPunk Stealth Mod');	
	`log("Inserting Civis To Missions Listener",true,'DragonPunk Stealth Mod');	
	`log("----------------------------------------------------------------------",true,'DragonPunk Stealth Mod');	
	i=0;
	/*Foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_MissionSite',MissionSite)
	{
		i++;	
		RandomNum= CiviliansCounts.MinCivCount+ Rand((CiviliansCounts.MaxCivCount- CiviliansCounts.MinCivCount) +1);
		MissionSite.GeneratedMission.Mission.MinCivilianCount=40;//RandomNum;
	}
	`log("Inserting Civis To Missions, Number:"@i,true,'DragonPunk Stealth Mod');	
	*/ 
	   //NOT WORKING!
	
}


defaultproperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	ScreenClass=UISquadSelect;
}	