// This is an Unreal Script

class X2Effect_SquadEnterConcealment extends X2Effect_Persistent;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	 `log("Added X2Effect_SquadEnterConcealment"); 
}


simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	 if(!HasEngagedEnemies()) {ApplySquadConceal(NewGameState);}// `log("Redoing Concealment");}
	// else {`log("Failed doing Concealment");}
}
function ApplySquadConceal(XComGameState NewGameState)
{
	local XComGameStateHistory History;
	local XComGameState_Player PlayerState;

	History = `XCOMHISTORY;

	// enable individual concealment on all XCom units
	foreach History.IterateByClassType(class'XComGameState_Player', PlayerState)
	{
		if( PlayerState.GetTeam() == eTeam_XCom )
		{
			PlayerState.SetSquadConcealmentNewGameState(true, NewGameState);
		}
	}
}

function bool HasEngagedEnemies()
{
	local XComGameState_Unit Unit;

	foreach `XCOMHistory.IterateByClassType(class'XComGameState_Unit', Unit)
	{
		if(Unit.GetTeam() == eTeam_Alien)
		{
		//	`log("eStat_AlertLevel"@Unit.GetCurrentStat(eStat_AlertLevel)); 
		//	`log("HP"@Unit.GetCurrentStat(eStat_HP));
		//	`log("Red"@`ALERT_LEVEL_RED);
		//	`log("");
			if(Unit.GetCurrentStat(eStat_AlertLevel) >= `ALERT_LEVEL_RED && Unit.GetCurrentStat(eStat_HP)>0)	
				Return True;
		}
	}
	return false;
}
