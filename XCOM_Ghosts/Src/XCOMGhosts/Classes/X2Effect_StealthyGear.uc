// This is an Unreal Script
                           
class X2Effect_StealthyGear extends X2Effect_PersistentStatChange;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	if(m_aStatChanges[0].StatAmount==1||(XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID)).GetCurrentStat(eStat_DetectionModifier)<(class'X2Ability_Stealth'.default.MAX_DETECTION_DECREASE-class'X2Ability_Stealth'.default.CIVILIAN_CLOTHES_DETECTION_DECREASE)))
	{
		m_aStatChanges[0].StatAmount=Min(1-(XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID)).GetCurrentStat(eStat_DetectionModifier)),m_aStatChanges[0].StatAmount);
		NewEffectState.StatChanges = m_aStatChanges;
		super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
	}
}


