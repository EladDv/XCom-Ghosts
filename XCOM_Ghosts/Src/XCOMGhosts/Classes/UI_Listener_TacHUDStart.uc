// Just spawns the Actor which deals with concealment tiles

class UI_Listener_TacHUDStart extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local Object ThisObj;
	local X2_Actor_CTE_Group ACTEG;

	ThisObj=self;
/*  `XEVENTMGR.RegisterForEvent(ThisObj, 'ObjectMoved', FixVisibility, ELD_OnStateSubmitted,70);	
	`XEVENTMGR.RegisterForEvent(ThisObj, 'ObjectMoved', TestReturnStuff, ELD_OnStateSubmitted);	
	`XEVENTMGR.RegisterForEvent(ThisObj, 'ObjectVisibilityChanged', OnObjectVisibilityChanged,ELD_OnStateSubmitted,70 );
*/
	ACTEG=`BATTLE.Spawn(class'X2_Actor_CTE_Group');
	`log("-----------Registered for Object Moved-----------");	
	
	
}
function EventListenerReturn TestReturnStuff(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	`log("---------------------IT DIDNT WORK! TEST FAILED!-----------------------");
	
	return ELR_NoInterrupt;
}
function EventListenerReturn FixVisibility(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState_Unit OtherUnitState, ThisUnitState;
	local XComGameStateHistory History;
	local X2GameRulesetVisibilityManager VisibilityMgr;
	local GameRulesCache_VisibilityInfo VisibilityInfoFromThisUnit, VisibilityInfoFromOtherUnit;
	local float ConcealmentDetectionDistance, UnitFoV ,orientation;
	local XComGameState_AIGroup AIGroupState;
	local XComGameStateContext_Ability SourceAbilityContext;
	local XComGameState_InteractiveObject InteractiveObjectState;
	local XComWorldData WorldData;
	local Vector CurrentPosition, TestPosition, aFacing,aToB;
	local TTile CurrentTileLocation;
	local XComGameState_Effect EffectState;
	local X2Effect_Persistent PersistentEffect;
	local XComGameState NewGameState;
	local XComGameStateContext_EffectRemoved EffectRemovedContext;
	local int ObjectID2;
	`log("-------------------Entered Tile!-------------------");

	WorldData = `XWORLD;
	History = `XCOMHISTORY;
	
	ObjectID2=XComGameState_Unit(EventData).ObjectID;

	ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));

	// cleanse burning on entering water
	ThisUnitState.GetKeystoneVisibilityLocation(CurrentTileLocation);
	if( ThisUnitState.IsBurning() && WorldData.IsWaterTile(CurrentTileLocation) )
	{
		foreach History.IterateByClassType(class'XComGameState_Effect', EffectState)
		{
			if( EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID == ObjectID2 )
			{
				PersistentEffect = EffectState.GetX2Effect();
				if( PersistentEffect.EffectName == class'X2StatusEffects'.default.BurningName )
				{
					EffectRemovedContext = class'XComGameStateContext_EffectRemoved'.static.CreateEffectRemovedContext(EffectState);
					NewGameState = History.CreateNewGameState(true, EffectRemovedContext);
					EffectState.RemoveEffect(NewGameState, NewGameState, true); //Cleansed

					`TACTICALRULES.SubmitGameState(NewGameState);
				}
			}
		}
	}

	SourceAbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if( SourceAbilityContext != None )
	{
		// concealment for this unit is broken when stepping into a new tile if the act of stepping into the new tile caused environmental damage (ex. "broken glass")
		// if this occurred, then the GameState will contain either an environmental damage state or an InteractiveObject state
		if( ThisUnitState.IsConcealed() && SourceAbilityContext.ResultContext.bPathCausesDestruction )
		{
			ThisUnitState.BreakConcealment();
		}

		ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));

		// check if this unit is a member of a group waiting on this unit's movement to complete 
		// (or at least reach the interruption step where the movement should complete)
		AIGroupState = ThisUnitState.GetGroupMembership();
		if( AIGroupState != None &&
			AIGroupState.IsWaitingOnUnitForReveal(ThisUnitState) &&
			(SourceAbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt ||
			(AIGroupState.FinalVisibilityMovementStep > INDEX_NONE &&
			AIGroupState.FinalVisibilityMovementStep <= SourceAbilityContext.ResultContext.InterruptionStep)) )
		{
			AIGroupState.StopWaitingOnUnitForReveal(ThisUnitState);
		}
	}

	// concealment may be broken by moving within range of an interactive object 'detector'
	if( ThisUnitState.IsConcealed() )
	{
		ThisUnitState.GetKeystoneVisibilityLocation(CurrentTileLocation);
		CurrentPosition = WorldData.GetPositionFromTileCoordinates(CurrentTileLocation);
		
		foreach History.IterateByClassType(class'XComGameState_InteractiveObject', InteractiveObjectState)
		{
			if( InteractiveObjectState.DetectionRange > 0.0 && !InteractiveObjectState.bHasBeenHacked )
			{
				TestPosition = WorldData.GetPositionFromTileCoordinates(InteractiveObjectState.TileLocation);

				if( VSizeSq(TestPosition - CurrentPosition) <= Square(InteractiveObjectState.DetectionRange) )
				{
					ThisUnitState.BreakConcealment();
					ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));
					break;
				}
			}
		}
	}

	// concealment may also be broken if this unit moves into detection range of an enemy unit
	VisibilityMgr = `TACTICALRULES.VisibilityMgr;
	foreach History.IterateByClassType(class'XComGameState_Unit', OtherUnitState)
	{
		// don't process visibility against self
		if( OtherUnitState.ObjectID == ThisUnitState.ObjectID )
		{
			continue;
		}

		VisibilityMgr.GetVisibilityInfo(ThisUnitState.ObjectID, OtherUnitState.ObjectID, VisibilityInfoFromThisUnit);

		if( VisibilityInfoFromThisUnit.bVisibleBasic )
		{
			// check if the other unit is concealed, and this unit's move has revealed him
			if( OtherUnitState.IsConcealed() && !OtherUnitState.IsCivilian() &&
			    OtherUnitState.UnitBreaksConcealment(ThisUnitState) &&
				VisibilityInfoFromThisUnit.TargetCover == CT_None )
			{
				ConcealmentDetectionDistance = OtherUnitState.GetConcealmentDetectionDistance(ThisUnitState);
				// What direction is A facing in?
				aFacing=Normal(Vector(XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Rotation));
				// Get the vector from A to B
				aToB=XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Location- XGUnit(ThisUnitState.GetVisualizer()).GetPawn().Location ;
 
				orientation = aFacing dot Normal(aToB);

				UnitFoV=aCos(orientation);
				`log("OtherConcealed Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV);			
				if( VisibilityInfoFromThisUnit.DefaultTargetDist <=sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) )
				{
					`log("Other Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			

					OtherUnitState.BreakConcealment(ThisUnitState, true);

				// have to refresh the unit state after broken concealment
				OtherUnitState = XComGameState_Unit(History.GetGameStateForObjectID(OtherUnitState.ObjectID));
				}
				else
				{
					`log("Other Unit Didnt Break Concealement- Facing Angle Deg:" @"ConcealmentDist:"@sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			
				}
			}

			// generate alert data for this unit about other units
			if(!ThisUnitState.IsConcealed()&&!OtherUnitState.IsConcealed())
			{
				`log("WE Both Broke Concealment" @ThisUnitState.GetFullName() @OtherUnitState.GetFullName());
				OtherUnitState.UnitASeesUnitB(ThisUnitState, OtherUnitState, GameState);
			}
		}
		// only need to process visibility updates from the other unit if it is still alive
		if( OtherUnitState.IsAlive() )
		{
			VisibilityMgr.GetVisibilityInfo(OtherUnitState.ObjectID, ThisUnitState.ObjectID, VisibilityInfoFromOtherUnit);

			if( VisibilityInfoFromOtherUnit.bVisibleBasic )
			{
				// check if this unit is concealed and that concealment is broken by entering into an enemy's detection tile
				if( ThisUnitState.IsConcealed() && ThisUnitState.UnitBreaksConcealment(OtherUnitState) )
				{
					ConcealmentDetectionDistance = ThisUnitState.GetConcealmentDetectionDistance(OtherUnitState);
					aFacing=Normal(Vector(XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Rotation));
					// Get the vector from A to B
					aToB=XGUnit(ThisUnitState.GetVisualizer()).GetPawn().Location -XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Location;
 
					orientation = aFacing dot Normal(aToB);

					UnitFoV=aCos(orientation);		
					`log("IsAlive Check Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV);			
					if( VisibilityInfoFromOtherUnit.DefaultTargetDist <= sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) )
					{
						`log("This Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			
						ThisUnitState.BreakConcealment(OtherUnitState);

						// have to refresh the unit state after broken concealment
						ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));
					}
					else
					{
						`log("This Unit Didnt Break Concealement- Facing Angle Deg:" @"ConcealmentDist:"@sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			
					}
				}

				// generate alert data for other units that see this unit
				if( VisibilityInfoFromOtherUnit.bVisibleBasic && !ThisUnitState.IsConcealed() )
				{
					`log("I Broke Concealment"@ThisUnitState.GetFullName() @OtherUnitState.GetFullName());
					//  don't register an alert if this unit is about to reflex
					AIGroupState = OtherUnitState.GetGroupMembership();
					if (AIGroupState == none || AIGroupState.EverSightedByEnemy)
						ThisUnitState.UnitASeesUnitB(OtherUnitState, ThisUnitState, GameState);
				}
			}
		}
	}

	return ELR_InterruptEventAndListeners;
}

function EventListenerReturn OnObjectVisibilityChanged(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local X2GameRulesetVisibilityInterface SourceObject;
	local XComGameState_Unit SeenUnit;
	local XComGameState_Unit SourceUnit;
	local GameRulesCache_VisibilityInfo VisibilityInfo ;
	local X2GameRulesetVisibilityManager VisibilityMgr;
	local XComGameState NewGameState;
	local XComGameState_Player UpdatedPlayerState;
	local Vector aFacing,aToB;
	local float ConcealmentDetectionDistance, UnitFoV ,orientation;

	VisibilityMgr = `TACTICALRULES.VisibilityMgr;

	SourceObject = X2GameRulesetVisibilityInterface(EventSource); 
	SeenUnit = XComGameState_Unit(EventData); // we only care about enemy units
	if(SeenUnit != none &&SourceObject!= none)
	{
		if(SeenUnit != none && SourceObject.TargetIsEnemy(SeenUnit.ObjectID))
		{
			SourceUnit = XComGameState_Unit(SourceObject);
			if(SourceUnit != none && GameState != none)
			{
				VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, SeenUnit.ObjectID, VisibilityInfo, GameState.HistoryIndex);
				if(true)
				{
					`log("WE have a good Vis Info");
					if(VisibilityInfo.bVisibleGameplay)
					{
						/*if(XComGameState_Player(GameState.GetGameStateForObjectID(SourceObject.GetAssociatedPlayerID())).TurnsSinceEnemySeen > 0 && SeenUnit.IsAlive())
						{
							NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("PlayerRecordEnemiesSeen");
							UpdatedPlayerState = XComGameState_Player(NewGameState.CreateStateObject(Class'XComGameState_Player', SourceObject.GetAssociatedPlayerID()));
							NewGameState.AddStateObject(UpdatedPlayerState);
							`GAMERULES.SubmitGameState(NewGameState);
						}*/
						`log("Check Seen Object and Source Object");
						//Inform the units that they see each other
						//class'XComGameState_Unit'.static.UnitASeesUnitB(SourceUnit, SeenUnit, GameState);
					}
					else if (VisibilityInfo.bVisibleBasic)
					{
						//If the target is not yet gameplay-visible, it might be because they are concealed.
						//Check if the source should break their concealment due to the new conditions.
						//(Typically happens in XComGameState_Unit when a unit moves, but there are edge cases,
						//like blowing up the last structure between two units, when it needs to happen here.)
						if (SeenUnit.IsConcealed() && SeenUnit.UnitBreaksConcealment(SourceUnit))
						{
							`log("There is Visibility to source unit");
							ConcealmentDetectionDistance = SeenUnit.GetConcealmentDetectionDistance(SourceUnit);
							aFacing=Normal(Vector(XGUnit(SourceUnit.GetVisualizer()).GetPawn().Rotation));
							// Get the vector from A to B
							aToB=XGUnit(SeenUnit.GetVisualizer()).GetPawn().Location -XGUnit(SourceUnit.GetVisualizer()).GetPawn().Location;
 
							orientation = aFacing dot Normal(aToB);

							UnitFoV=aCos(orientation);		
							`log("IsAlive Check Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV);			
							if( VisibilityInfo.DefaultTargetDist <= sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) )
							{
								`log("This Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) @"DefTargetDist:"@VisibilityInfo.DefaultTargetDist);			
								SeenUnit.BreakConcealment(SourceUnit, VisibilityInfo.TargetCover == CT_None);
							}
						}
					}
				}
			}
		}
	}
	return ELR_InterruptEventAndListeners;
}

/*
function EventListenerReturn OnUnitEnteredTile(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState_Unit OtherUnitState, ThisUnitState;
	local XComGameStateHistory History;
	local X2GameRulesetVisibilityManager VisibilityMgr;
	local GameRulesCache_VisibilityInfo VisibilityInfoFromThisUnit, VisibilityInfoFromOtherUnit;
	local float ConcealmentDetectionDistance, UnitFoV ,orientation;
	local XComGameState_AIGroup AIGroupState;
	local XComGameStateContext_Ability SourceAbilityContext;
	local XComGameState_InteractiveObject InteractiveObjectState;
	local XComWorldData WorldData;
	local Vector CurrentPosition, TestPosition, aFacing,aToB;
	local TTile CurrentTileLocation;
	local XComGameState_Effect EffectState;
	local X2Effect_Persistent PersistentEffect;
	local XComGameState NewGameState;
	local XComGameStateContext_EffectRemoved EffectRemovedContext;
	local int ObjectID2;

	`log("-------------------Entered Tile!-------------------");
	
	WorldData = `XWORLD;
	History = `XCOMHISTORY;

	ObjectID2=XComGameState_Unit(EventData).ObjectID;
	ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));

	// cleanse burning on entering water
	ThisUnitState.GetKeystoneVisibilityLocation(CurrentTileLocation);
	if( ThisUnitState.IsBurning() && WorldData.IsWaterTile(CurrentTileLocation) )
	{
		foreach History.IterateByClassType(class'XComGameState_Effect', EffectState)
		{
			if( EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID == ObjectID2 )
			{
				PersistentEffect = EffectState.GetX2Effect();
				if( PersistentEffect.EffectName == class'X2StatusEffects'.default.BurningName )
				{
					EffectRemovedContext = class'XComGameStateContext_EffectRemoved'.static.CreateEffectRemovedContext(EffectState);
					NewGameState = History.CreateNewGameState(true, EffectRemovedContext);
					EffectState.RemoveEffect(NewGameState, NewGameState, true); //Cleansed

					`TACTICALRULES.SubmitGameState(NewGameState);
				}
			}
		}
	}

	SourceAbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if( SourceAbilityContext != None )
	{
		`log("SourceAbilityContext isnt Empty");
		// concealment for this unit is broken when stepping into a new tile if the act of stepping into the new tile caused environmental damage (ex. "broken glass")
		// if this occurred, then the GameState will contain either an environmental damage state or an InteractiveObject state
		if( ThisUnitState.IsConcealed() && SourceAbilityContext.ResultContext.bPathCausesDestruction )
		{
			ThisUnitState.BreakConcealment();
		}

		ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));

		// check if this unit is a member of a group waiting on this unit's movement to complete 
		// (or at least reach the interruption step where the movement should complete)
		AIGroupState = ThisUnitState.GetGroupMembership();
		if( AIGroupState != None &&
			AIGroupState.IsWaitingOnUnitForReveal(ThisUnitState) &&
			(SourceAbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt ||
			(AIGroupState.FinalVisibilityMovementStep > INDEX_NONE &&
			AIGroupState.FinalVisibilityMovementStep <= SourceAbilityContext.ResultContext.InterruptionStep)) )
		{
			AIGroupState.StopWaitingOnUnitForReveal(ThisUnitState);
		}
	}

	// concealment may be broken by moving within range of an interactive object 'detector'
	if( ThisUnitState.IsConcealed() )
	{
		ThisUnitState.GetKeystoneVisibilityLocation(CurrentTileLocation);
		CurrentPosition = WorldData.GetPositionFromTileCoordinates(CurrentTileLocation);
		
		foreach History.IterateByClassType(class'XComGameState_InteractiveObject', InteractiveObjectState)
		{
			if( InteractiveObjectState.DetectionRange > 0.0 && !InteractiveObjectState.bHasBeenHacked )
			{
				TestPosition = WorldData.GetPositionFromTileCoordinates(InteractiveObjectState.TileLocation);

				if( VSizeSq(TestPosition - CurrentPosition) <= Square(InteractiveObjectState.DetectionRange) )
				{
					ThisUnitState.BreakConcealment();
					ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));
					break;
				}
			}
		}
	}

	// concealment may also be broken if this unit moves into detection range of an enemy unit
	VisibilityMgr = `TACTICALRULES.VisibilityMgr;
	foreach History.IterateByClassType(class'XComGameState_Unit', OtherUnitState)
	{
		// don't process visibility against self
		if( OtherUnitState.ObjectID == ThisUnitState.ObjectID )
		{
			continue;
		}

		VisibilityMgr.GetVisibilityInfo(ThisUnitState.ObjectID, OtherUnitState.ObjectID, VisibilityInfoFromThisUnit);

		if( VisibilityInfoFromThisUnit.bVisibleBasic )
		{
			// check if the other unit is concealed, and this unit's move has revealed him
			if( OtherUnitState.IsConcealed() &&
			    OtherUnitState.UnitBreaksConcealment(ThisUnitState) &&
				VisibilityInfoFromThisUnit.TargetCover == CT_None )
			{
				ConcealmentDetectionDistance = OtherUnitState.GetConcealmentDetectionDistance(ThisUnitState);
				// What direction is A facing in?
				aFacing=Normal(Vector(XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Rotation));
				// Get the vector from A to B
				aToB=XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Location- XGUnit(ThisUnitState.GetVisualizer()).GetPawn().Location ;
 
				orientation = aFacing dot Normal(aToB);

				UnitFoV=aCos(orientation);
				`log("Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV);			
				if( VisibilityInfoFromThisUnit.DefaultTargetDist <=sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) )
				{
					`log("Other Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			
					OtherUnitState.BreakConcealment(ThisUnitState, true);

					// have to refresh the unit state after broken concealment
					OtherUnitState = XComGameState_Unit(History.GetGameStateForObjectID(OtherUnitState.ObjectID));
				}
			}
			`log("Here's the problem");
			//ThisUnitState.UnitASeesUnitB(ThisUnitState, OtherUnitState, GameState);
		}

		// only need to process visibility updates from the other unit if it is still alive
		if( OtherUnitState.IsAlive() )
		{
			VisibilityMgr.GetVisibilityInfo(OtherUnitState.ObjectID, ThisUnitState.ObjectID, VisibilityInfoFromOtherUnit);

			if( VisibilityInfoFromOtherUnit.bVisibleBasic )
			{
				// check if this unit is concealed and that concealment is broken by entering into an enemy's detection tile
				if( ThisUnitState.IsConcealed() && ThisUnitState.UnitBreaksConcealment(OtherUnitState) )
				{
					ConcealmentDetectionDistance = ThisUnitState.GetConcealmentDetectionDistance(OtherUnitState);
					aFacing=Normal(Vector(XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Rotation));
					// Get the vector from A to B
					aToB=XGUnit(ThisUnitState.GetVisualizer()).GetPawn().Location -XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Location;
 
					orientation = aFacing dot Normal(aToB);

					UnitFoV=aCos(orientation);		
					`log("Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV);			
					if( VisibilityInfoFromOtherUnit.DefaultTargetDist <= sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) )
					{
						`log("This Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@sgn(Cos((6/5)*UnitFoV))*Square(ConcealmentDetectionDistance*Cos((6/5)*UnitFoV)) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			
						ThisUnitState.BreakConcealment(OtherUnitState);
						
						// have to refresh the unit state after broken concealment
						ThisUnitState = XComGameState_Unit(History.GetGameStateForObjectID(ObjectID2));
					}
				}

				// generate alert data for other units that see this unit
				if( VisibilityInfoFromOtherUnit.bVisibleBasic && !ThisUnitState.IsConcealed() )
				{
					//  don't register an alert if this unit is about to reflex
					AIGroupState = OtherUnitState.GetGroupMembership();
					if (AIGroupState == none || AIGroupState.EverSightedByEnemy)
						`log("");//ThisUnitState.UnitASeesUnitB(OtherUnitState, ThisUnitState, GameState);
				}
			}
		}
	}

	return ELR_InterruptListeners;
}
*/
defaultproperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	ScreenClass=UITacticalHUD;
}	 