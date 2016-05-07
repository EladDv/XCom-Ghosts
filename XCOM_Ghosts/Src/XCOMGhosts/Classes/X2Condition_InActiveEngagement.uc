// This is an Unreal Script

class X2Condition_InActiveEngagement extends X2Condition;

Static function bool HasEngagedEnemies()
{
	local XComGameState_AIGroup GroupState;

	foreach `XCOMHistory.IterateByClassType(class'XComGameState_AIGroup', GroupState)
	{
		if(GroupState.m_kStats.m_iInitialMemberCount!=GroupState.m_kStats.m_arrDead.Length)
		{
			if(GroupState.bProcessedScamper||GroupState.bPendingScamper)	{Return True;}
		}
	}
	return false;
}
event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{ 
	if(HasEngagedEnemies())
		return 'AA_IsEngaging';

	return 'AA_Success';
}

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource) 
{ 
	if(HasEngagedEnemies())
		return 'AA_IsEngaging';

	return 'AA_Success';
	
}