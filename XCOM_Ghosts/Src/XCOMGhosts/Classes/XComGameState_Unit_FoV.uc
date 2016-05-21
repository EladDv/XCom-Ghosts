// This is an Unreal Script
                           
class XComGameState_Unit_FoV Extends XComGameState_Unit;

//var X2Actor_ConeTarget	ConeActor;

function EventListenerReturn OnUnitEnteredTile(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState_Unit_FoV OtherUnitState, ThisUnitState,unit;
	local XComGameStateHistory History;
	local X2GameRulesetVisibilityManager VisibilityMgr;
	local GameRulesCache_VisibilityInfo VisibilityInfoFromThisUnit, VisibilityInfoFromOtherUnit;
	local float ConcealmentDetectionDistance,UnitFoV ,orientation,mySign;
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
	local bool	HasConcealedUnits;
	WorldData = `XWORLD;
	History = `XCOMHISTORY;

	ThisUnitState = XComGameState_Unit_FoV(History.GetGameStateForObjectID(ObjectID));
	//if(ConeActor!=none)
	//	OtherUnitState.ConeActor.InitConeMesh(0.001,0.001);

	foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Unit_FoV',Unit)
	{
		if(Unit.IsConcealed()&& Unit.GetTeam()==ETeam_XCom)
		{
			HasConcealedUnits=true;
		}
	}
	if(GetTeam()!=ETeam_XCom)
		DrawFoVCone();
	// cleanse burning on entering water
	ThisUnitState.GetKeystoneVisibilityLocation(CurrentTileLocation);
	if( ThisUnitState.IsBurning() && WorldData.IsWaterTile(CurrentTileLocation) )
	{
		foreach History.IterateByClassType(class'XComGameState_Effect', EffectState)
		{
			if( EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID == ObjectID )
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

		ThisUnitState = XComGameState_Unit_FoV(History.GetGameStateForObjectID(ObjectID));

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
					ThisUnitState = XComGameState_Unit_FoV(History.GetGameStateForObjectID(ObjectID));
					break;
				}
			}
		}
	}

	// concealment may also be broken if this unit moves into detection range of an enemy unit
	VisibilityMgr = `TACTICALRULES.VisibilityMgr;
	foreach History.IterateByClassType(class'XComGameState_Unit_FoV', OtherUnitState)
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
				ConcealmentDetectionDistance = GetConcealmentDetectionDistance(OtherUnitState);
				// What direction is A facing in?
				aFacing=Normal(Vector(XGUnit(ThisUnitState.GetVisualizer()).GetPawn().Rotation));
				// Get the vector from A to B
				aToB=XGUnit(ThisUnitState.GetVisualizer()).GetPawn().Location- XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Location ;
 
				orientation = aFacing dot Normal(aToB);

				UnitFoV=aCos(orientation);
				if(UnitFoV>1.2215 || UnitFoV<-1.2215)
				{
					mySign=0.0f;
				}
				else
				{
					mySign=1.0f;
				}
				`log("OtherConcealed Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@mySign*Square(ConcealmentDetectionDistance*((mySign*(1-(0.67*(UnitFoV^2)) ))^0.5f) ) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist @(mySign*(1-(0.67*(UnitFoV^2)))) @(1-(0.67*(UnitFoV^2))) );
				if( VisibilityInfoFromThisUnit.DefaultTargetDist <=mySign*Square(ConcealmentDetectionDistance*((mySign*(1-(0.67*(UnitFoV^2)) ))^0.5f) ) )
				{
					`log("Other Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@mySign*Square(ConcealmentDetectionDistance*((mySign*(1-(0.67*(UnitFoV^2)) ))^0.5f) ) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			

					OtherUnitState.BreakConcealment(ThisUnitState, true);

					// have to refresh the unit state after broken concealment
					OtherUnitState = XComGameState_Unit_FoV(History.GetGameStateForObjectID(OtherUnitState.ObjectID));
				}
			}

			// generate alert data for this unit about other units
			UnitASeesUnitB(ThisUnitState, OtherUnitState, GameState);
		}

		// only need to process visibility updates from the other unit if it is still alive
		if( OtherUnitState.IsAlive() )
		{
			VisibilityMgr.GetVisibilityInfo(OtherUnitState.ObjectID, ThisUnitState.ObjectID, VisibilityInfoFromOtherUnit);
				
			if( VisibilityInfoFromOtherUnit.bVisibleBasic )
			{
				// check if this unit is concealed and that concealment is broken by entering into an enemy's detection tile
				if( ThisUnitState.IsConcealed() && UnitBreaksConcealment(OtherUnitState) )
				{
					
					ConcealmentDetectionDistance = GetConcealmentDetectionDistance(OtherUnitState);
					if(OtherUnitState.GetTeam()!=ETeam_XCom)
					OtherUnitState.DrawFoVCone(ConcealmentDetectionDistance);

					aFacing=Normal(Vector(XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Rotation));
					// Get the vector from A to B
					aToB=XGUnit(ThisUnitState.GetVisualizer()).GetPawn().Location -XGUnit(OtherUnitState.GetVisualizer()).GetPawn().Location;
 
					orientation = aFacing dot Normal(aToB);

					UnitFoV=aCos(orientation);	
					if(UnitFoV>1.2215 || UnitFoV<-1.2215)
					{
						mySign=0.0f;
					}
					else
					{
						mySign=1.0f;
					}	
					`log("IsAlive Check Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@mySign*Square(ConcealmentDetectionDistance*(Sqrt(mySign*(1-(0.67*(UnitFoV*UnitFoV) ) ) ) ) ) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist @(mySign*(1-(0.67*(UnitFoV^2)))) @(1-(0.67*(UnitFoV^2))) @"Rad:"@UnitFoV);			
					if( VisibilityInfoFromOtherUnit.DefaultTargetDist <= mySign*Square(ConcealmentDetectionDistance*(Sqrt(mySign*(1-(0.67*(UnitFoV*UnitFoV) ) ) ) ) ))
					{
						`log("This Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@mySign*Square(ConcealmentDetectionDistance*(Sqrt(mySign*(1-(0.67*(UnitFoV*UnitFoV) ) ) ) ) ) @"DefTargetDist:"@VisibilityInfoFromOtherUnit.DefaultTargetDist);			
						ThisUnitState.BreakConcealment(OtherUnitState);
						//OtherUnitState.ConeActor.Destroy();
						// have to refresh the unit state after broken concealment
						ThisUnitState = XComGameState_Unit_FoV(History.GetGameStateForObjectID(ObjectID));
					}
				}

				// generate alert data for other units that see this unit
				if( VisibilityInfoFromOtherUnit.bVisibleBasic && !ThisUnitState.IsConcealed() )
				{
					//OtherUnitState.ConeActor.InitConeMesh(0.001,0.001);
					//  don't register an alert if this unit is about to reflex
					AIGroupState = OtherUnitState.GetGroupMembership();
					if (AIGroupState == none || AIGroupState.EverSightedByEnemy)
						UnitASeesUnitB(OtherUnitState, ThisUnitState, GameState);
				}
			}
		}
	}

	return ELR_NoInterrupt;
}

function DrawFoVCone(optional float DetectionRadius)
{ 
/*
	local bool						DrewCone,HasConcealedUnits;
	local vector					EnemyLocation,Facing,FiringLocation;
	local float						ConeLength,ConeWidth;
	
	ConeActor.Destroy();
	`log("---------------000000--------------");
	ConeLength=(9*(GetBaseStat(eStat_DetectionRadius)-1)*class'XComWorldData'.const.WORLD_StepSize)/(3*11/3);
	`log("---------------05050505050--------------");
	ConeWidth=2*(Sin(70*PI/180)/Cos(70*PI/180))*ConeLength; 
	EnemyLocation=XGUnit(GetVisualizer()).GetPawn().Location;
	`log("---------------111111--------------");	
	Facing=Normal(Vector(XGUnit(GetVisualizer()).GetPawn().Rotation));
	FiringLocation=(EnemyLocation);
	FiringLocation.z-=0.995*class'XComWorldData'.const.WORLD_HalfFloorHeight;
	`log("---------------Drawing Cone--------------");
	ConeActor = `BATTLE.Spawn(class'X2Actor_ConeTarget');
	ConeActor.MeshLocation = "UI_3D.Targeting.ConeRange";
	ConeActor.InitConeMesh(ConeLength / class'XComWorldData'.const.WORLD_StepSize, ConeWidth / class'XComWorldData'.const.WORLD_StepSize);
	`log(ConeLength / class'XComWorldData'.const.WORLD_StepSize);
	ConeActor.SetLocation(FiringLocation);
	ConeActor.SetRotation(Rotator(Facing)); */
	
}