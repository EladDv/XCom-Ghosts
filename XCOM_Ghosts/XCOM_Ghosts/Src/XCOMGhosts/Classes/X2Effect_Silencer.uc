// This is an Unreal Script
                           
class X2Effect_Silencer extends X2Effect_Persistent;

var array<int> EnemiesToReturnToGreen;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit SourceUnitState, EnemyInSoundRangeUnitState , unit;
	local XComGameState_Item WeaponState;
	local int SoundRange;
	local TTile SoundTileLocation;
	local Vector SoundLocation;
	local array<StateObjectReference> Enemies;
	local StateObjectReference EnemyRef;
	local XComGameStateHistory History;
	local int WeaponSilencerPerc;
	local X2WeaponUpgradeTemplate WeaponSilencerTemplate;
	local array<X2WeaponUpgradeTemplate> WeaponUpgradeTemplates;
	local name SilencerName;
	History=`XCOMHistory;
	SoundLocation=ApplyEffectParameters.AbilityInputContext.TargetLocations[0];
	WeaponState= XComGameState_Item(History.GetGameStateForObjectID(ApplyEffectParameters.ItemStateObjectRef.ObjectID));
	if(WeaponState.GetTileLocation()==`XWORLD.GetTileCoordinatesFromPosition(SoundLocation))
	{
		WeaponUpgradeTemplates=WeaponState.GetMyWeaponUpgradeTemplates();
		foreach WeaponUpgradeTemplates(WeaponSilencerTemplate)
		{
			if(WeaponSilencerTemplate.DataName=='Silencer_Bsc')
				WeaponSilencerPerc=WeaponSilencerPerc+Class'X2Item_SilencedWeapons'.default.SILENCER_RANGE_REDUCTION_MULTIPLIER;
			
		}
		`log("WeaponSilencerPerc:"@WeaponSilencerPerc);
		SoundRange=WeaponState.GetItemSoundRange()*(1-WeaponSilencerPerc);

		if( SoundRange > 0 )
		{
			if( WeaponState.SoundOriginatesFromOwnerLocation() &&  ApplyEffectParameters.AbilityInputContext.TargetLocations.Length > 0 )
			{
				SoundLocation = ApplyEffectParameters.AbilityInputContext.TargetLocations[0];
				SoundTileLocation = `XWORLD.GetTileCoordinatesFromPosition(SoundLocation);
			}
			else
			{
				XComGameState_Unit(History.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID)).GetKeystoneVisibilityLocation(SoundTileLocation);
			}
			GetEnemiesInRange(WeaponState,SoundTileLocation, SoundRange, Enemies);
		}
		foreach Enemies(EnemyRef)
		{
			EnemyInSoundRangeUnitState = XComGameState_Unit(History.GetGameStateForObjectID(EnemyRef.ObjectID));
			if(XComGameState_AIUnitData(NewGameState.CreateStateObject(class'XComGameState_AIUnitData', EnemyInSoundRangeUnitState.GetAIUnitDataID())).YellowAlertCause==eAC_DetectedSound)
			{
				if(EnemiesToReturnToGreen.Find(EnemyRef.ObjectID)==-1)
					EnemiesToReturnToGreen.AddItem(EnemyRef.ObjectID);
				`log("Found Unit in yellow and added it!");
			}
			else if(XComGameState_AIUnitData(NewGameState.CreateStateObject(class'XComGameState_AIUnitData',EnemyInSoundRangeUnitState.GetAIUnitDataID())).YellowAlertCause!=eAC_None)
			{
				if(EnemiesToReturnToGreen.Find(EnemyRef.ObjectID)!=-1)
					EnemiesToReturnToGreen.RemoveItem(EnemyRef.ObjectID);
			}
		}
	
		`log("Added Silencer Effect to a Unit");
	
		foreach `XCOMHistory.IterateByClassType(class'XComGameState_Unit', Unit)
		{
			if(Unit.GetTeam() == eTeam_Alien)
			{
				`log("eStat_AlertLevel"@Unit.GetCurrentStat(eStat_AlertLevel)); 
				`log("HP"@Unit.GetCurrentStat(eStat_HP));
			//	`log("Red"@`ALERT_LEVEL_RED);
				`log("");
			//	if(Unit.GetCurrentStat(eStat_AlertLevel) >= `ALERT_LEVEL_RED && Unit.GetCurrentStat(eStat_HP)>0)	
			//		Return True;
			}
		}
	}
}

simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local int					EnemyID;
	local XComGameState_Unit	EnemyInSoundRangeUnitState , Unit;
	
	`log("Number of units in Yellow:"@EnemiesToReturnToGreen.Length);
	`log("Meters to tiles:"@`METERSTOUNITS(27)/96);

	foreach EnemiesToReturnToGreen(EnemyID)
	{
		EnemyInSoundRangeUnitState = XComGameState_Unit(`XCOMHistory.GetGameStateForObjectID(EnemyID));
		
		if(EnemyInSoundRangeUnitState.GetCurrentStat(eStat_AlertLevel)==`ALERT_LEVEL_YELLOW)
			EnemyInSoundRangeUnitState.SetCurrentStat(eStat_AlertLevel,`ALERT_LEVEL_GREEN);
	}
	EnemiesToReturnToGreen.Length=0;
	foreach `XCOMHistory.IterateByClassType(class'XComGameState_Unit', Unit)
	{
		if(Unit.GetTeam() == eTeam_Alien)
		{
			`log("eStat_AlertLevel"@Unit.GetCurrentStat(eStat_AlertLevel)); 
			`log("eStat_HearingRadius"@Unit.GetCurrentStat(eStat_HearingRadius)); 
			`log("HP"@Unit.GetCurrentStat(eStat_HP));
		//	`log("Red"@`ALERT_LEVEL_RED);
			`log("");
		//	if(Unit.GetCurrentStat(eStat_AlertLevel) >= `ALERT_LEVEL_RED && Unit.GetCurrentStat(eStat_HP)>0)	
		//		Return True;
		}
	}
}

function GetEnemiesInRange(XComGameState_Item item,TTile kLocation, int nMeters, out array<StateObjectReference> OutEnemies)
{
	local vector vCenter, vLoc;
	local float fDistSq;
	local XComGameState_Unit kUnit, thisUnit;
	local XComGameStateHistory History;
	local float AudioDistanceRadius, UnitHearingRadius, RadiiSumSquared,RadiiSumSquaredMax;

	thisUnit= XComGameState_Unit(History.GetGameStateForObjectID(item.AttachedUnitRef.ObjectID));
	History = `XCOMHISTORY;
	vCenter = `XWORLD.GetPositionFromTileCoordinates(kLocation);
	AudioDistanceRadius = `METERSTOUNITS(nMeters);
	fDistSq = Square(AudioDistanceRadius);

	foreach History.IterateByClassType(class'XComGameState_Unit', kUnit)
	{
		if(thisUnit.IsEnemyUnit(kUnit) && kUnit.IsAlive() )
		{
			vLoc = `XWORLD.GetPositionFromTileCoordinates(kUnit.TileLocation);
			UnitHearingRadius = kUnit.GetCurrentStat(eStat_HearingRadius);

			RadiiSumSquared = fDistSq;
			RadiiSumSquaredMax=Square(`METERSTOUNITS(item.GetItemSoundRange()));
			if( UnitHearingRadius != 0 )
			{
				RadiiSumSquared = Square(AudioDistanceRadius + UnitHearingRadius);
				RadiiSumSquaredMax =Square(`METERSTOUNITS(item.GetItemSoundRange()) + UnitHearingRadius);
			}

			if( VSizeSq(vLoc - vCenter) <= RadiiSumSquaredMax && VSizeSq(vLoc - vCenter)> RadiiSumSquared )
			{
				OutEnemies.AddItem(kUnit.GetReference());
			}
		}
	}
}