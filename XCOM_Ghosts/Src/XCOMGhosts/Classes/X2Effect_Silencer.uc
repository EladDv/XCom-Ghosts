// This is an Unreal Script
                           
class X2Effect_Silencer extends X2Effect_Persistent;

var array<int> EnemiesToReturnToGreen;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local object ThisObj;

	ThisObj=self;
	`XEVENTMGR.RegisterForEvent(ThisObj, 'AbilityActivated', ActivateSilencer, ELD_OnStateSubmitted);
}
function EventListenerReturn ActivateSilencer(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState_Unit SourceUnitState, EnemyInSoundRangeUnitState , unit;
	local XComGameState_Item WeaponState;
	local int SoundRange;
	local TTile SoundTileLocation;
	local XComGameState_Ability ActivatedAbilityState;
	local Vector SoundLocation;
	local array<StateObjectReference> Enemies;
	local StateObjectReference EnemyRef;
	local XComGameStateHistory History;
	local int WeaponSilencerPerc;
	local X2WeaponUpgradeTemplate WeaponSilencerTemplate;
	local array<X2WeaponUpgradeTemplate> WeaponUpgradeTemplates;
	local XComGameStateContext_Ability ActivatedAbilityStateContext;

	local name SilencerName;
	History=`XCOMHistory;
	
	ActivatedAbilityStateContext = XComGameStateContext_Ability(GameState.GetContext()); //sets the ability context
	ActivatedAbilityState = XComGameState_Ability(EventData); // sets the ability state
	// Checks if the current ability flagged to make AI detectable sound
	if( ActivatedAbilityState.DoesAbilityCauseSound() )
	{
		//Checks that the context isnt empty and has a weapon attached
		if( ActivatedAbilityStateContext != None && ActivatedAbilityStateContext.InputContext.ItemObject.ObjectID > 0 )
		{
			SourceUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ActivatedAbilityStateContext.InputContext.SourceObject.ObjectID));
			WeaponState = XComGameState_Item(GameState.GetGameStateForObjectID(ActivatedAbilityStateContext.InputContext.ItemObject.ObjectID));
			WeaponUpgradeTemplates= WeaponState.GetMyWeaponUpgradeTemplates();
			// Cycles through all weapon upgrade templates on the weapon to find the silencer
			foreach WeaponUpgradeTemplates(WeaponSilencerTemplate)
			{
				if(WeaponSilencerTemplate.DataName=='Silencer_Bsc')
					WeaponSilencerPerc=WeaponSilencerPerc+Class'X2Item_SilencedWeapons'.default.SILENCER_RANGE_REDUCTION_MULTIPLIER;
			
			}
			`log("WeaponSilencerPerc:"@WeaponSilencerPerc);
			SoundRange=WeaponState.GetItemSoundRange()*(1-WeaponSilencerPerc);

			if( SoundRange > 0 )
			{
				if( WeaponState.SoundOriginatesFromOwnerLocation() &&  ActivatedAbilityStateContext.InputContext.TargetLocations.Length > 0 )
				{
					SoundLocation = ActivatedAbilityStateContext.InputContext.TargetLocations[0];
					SoundTileLocation = `XWORLD.GetTileCoordinatesFromPosition(SoundLocation); //gets the tile where the sound is coming from
				}
				else
				{
					SourceUnitState.GetKeystoneVisibilityLocation(SoundTileLocation);
				}
				GetEnemiesInRange(WeaponState,SoundTileLocation, SoundRange, Enemies); //Gets all enemies between the weapons iSoundRange and the reduce sound range.
			}
			foreach Enemies(EnemyRef) //Cycles through all the returned enemies to check whether their AI data contains a Yellow Alert which fits what we are looking for
			{
				EnemyInSoundRangeUnitState = XComGameState_Unit(History.GetGameStateForObjectID(EnemyRef.ObjectID));
				if(XComGameState_AIUnitData(GameState.CreateStateObject(class'XComGameState_AIUnitData', EnemyInSoundRangeUnitState.GetAIUnitDataID())).YellowAlertCause==eAC_DetectedSound)
				{ //The alert we are looking for was found, add to an array for later checking at the effect tick (End of turn).
					if(EnemiesToReturnToGreen.Find(EnemyRef.ObjectID)==-1)
						EnemiesToReturnToGreen.AddItem(EnemyRef.ObjectID);
					`log("Found Unit in yellow and added it!");
				}
				else if(XComGameState_AIUnitData(GameState.CreateStateObject(class'XComGameState_AIUnitData',EnemyInSoundRangeUnitState.GetAIUnitDataID())).YellowAlertCause!=eAC_None)
				{ // If found a referenced unit with a cause which is different to the sound one remove from the array because it was also alerted due to something else.
					if(EnemiesToReturnToGreen.Find(EnemyRef.ObjectID)!=-1)
						EnemiesToReturnToGreen.RemoveItem(EnemyRef.ObjectID);
				}
			}
	
			`log("Added Silencer Effect to a Unit");
	
			foreach `XCOMHistory.IterateByClassType(class'XComGameState_Unit', Unit) //Debug log lines for alert level
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
	return ELR_NoInterrupt;
}

simulated function bool OnEffectTicked(const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local int					EnemyID;
	local XComGameState_Unit	EnemyInSoundRangeUnitState , Unit;
	
	`log("Number of units in Yellow:"@EnemiesToReturnToGreen.Length);
	//`log("Meters to tiles:"@`METERSTOUNITS(27)/96);

	foreach EnemiesToReturnToGreen(EnemyID) //  Check all enemies in the array, return everyone at yellow to green
	{
		EnemyInSoundRangeUnitState = XComGameState_Unit(`XCOMHistory.GetGameStateForObjectID(EnemyID));
		
		if(EnemyInSoundRangeUnitState.GetCurrentStat(eStat_AlertLevel)==`ALERT_LEVEL_YELLOW)
			EnemyInSoundRangeUnitState.SetCurrentStat(eStat_AlertLevel,`ALERT_LEVEL_GREEN);
	}
	EnemiesToReturnToGreen.Length=0;
	foreach `XCOMHistory.IterateByClassType(class'XComGameState_Unit', Unit) //Debug log lines for alert levels
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
	return true;
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
	vCenter = `XWORLD.GetPositionFromTileCoordinates(kLocation); //get position of the sound source
	AudioDistanceRadius = `METERSTOUNITS(nMeters); //get the number of units of modified sound range
	fDistSq = Square(AudioDistanceRadius); //distance for the sound range

	foreach History.IterateByClassType(class'XComGameState_Unit', kUnit) // iterate through all units
	{
		if(thisUnit.IsEnemyUnit(kUnit) && kUnit.IsAlive() )
		{
			vLoc = `XWORLD.GetPositionFromTileCoordinates(kUnit.TileLocation);	//get the loc of the tile the unit is on
			UnitHearingRadius = kUnit.GetCurrentStat(eStat_HearingRadius);	// always 0. could be interesting to play with on units

			RadiiSumSquared = fDistSq;
			RadiiSumSquaredMax=Square(`METERSTOUNITS(item.GetItemSoundRange())); //gets the original sound range from the object template.
			if( UnitHearingRadius != 0 )
			{
				RadiiSumSquared = Square(AudioDistanceRadius + UnitHearingRadius);  //distance the modified audio gets to
				RadiiSumSquaredMax =Square(`METERSTOUNITS(item.GetItemSoundRange()) + UnitHearingRadius); //distance the weapon base distance gets to.
			}

			if( VSizeSq(vLoc - vCenter) <= RadiiSumSquaredMax && VSizeSq(vLoc - vCenter)> RadiiSumSquared )
			{
				OutEnemies.AddItem(kUnit.GetReference());
			}
		}
	}
}