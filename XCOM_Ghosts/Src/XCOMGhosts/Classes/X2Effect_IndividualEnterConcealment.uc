// This is an Unreal Script
class X2Effect_IndividualEnterConcealment extends X2Effect_Persistent;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	`log("Added X2Effect_IndividualEnterConcealment"); 
}


simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local bool					HasE_Enemies,bToPass;
	local XComGameState_Unit	OwningUnit;

	OwningUnit=XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	HasE_Enemies=HasEngagedEnemies(OwningUnit);
	if(HasE_Enemies==false) {`log("Redoing Individual Concealment"); bToPass=true;}
	else {`log("Failed doing Individual Concealment"); bToPass=false;}

	ApplySquadConceal(OwningUnit, NewGameState, bToPass);
}
function ApplySquadConceal(XComGameState_Unit Unit,XComGameState NewGameState,optional bool ReConceale=false)
{
	local array<XComGameState_Unit>	AttachedUnits;
	local XComGameState_Unit		GremlinUnit;

	// enable individual concealment on the unit
	if(Unit!=none && ReConceale && Unit.GetTeam()==ETeam_XCom && !Unit.IsConcealed() && !Unit.IsSquadConcealed() )
	{
		`XEVENTMGR.TriggerEvent('EffectEnterUnitConcealment', Unit, Unit, NewGameState);
		Unit.GetAttachedUnits(AttachedUnits);
		foreach AttachedUnits(GremlinUnit)
		{
			`XEVENTMGR.TriggerEvent('EffectEnterUnitConcealment', GremlinUnit, GremlinUnit, NewGameState);
		}
	}
}

function bool HasEngagedEnemies(XComGameState_Unit ThisUnitState)
{
	local XComGameState_Unit				Unit;
	local X2GameRulesetVisibilityManager	VisibilityMgr;
	local GameRulesCache_VisibilityInfo		VisibilityInfoFromOtherUnit;
	
	VisibilityMgr = `TACTICALRULES.VisibilityMgr;

	foreach `XCOMHistory.IterateByClassType(class'XComGameState_Unit', Unit)
	{
		if(Unit.GetTeam() == eTeam_Alien)
		{
		//	`log("eStat_AlertLevel"@Unit.GetCurrentStat(eStat_AlertLevel)); 
		//	`log("HP"@Unit.GetCurrentStat(eStat_HP));
		//	`log("Red"@`ALERT_LEVEL_RED);
		//	`log("");
			
			VisibilityMgr.GetVisibilityInfo(ThisUnitState.ObjectID, Unit.ObjectID, VisibilityInfoFromOtherUnit);
			if((Unit.GetCurrentStat(eStat_AlertLevel) >= `ALERT_LEVEL_RED && Unit.GetCurrentStat(eStat_HP)>0 ) && VisibilityInfoFromOtherUnit.bVisibleGameplay)	
				Return True;
		}
	}
	return false;
}
