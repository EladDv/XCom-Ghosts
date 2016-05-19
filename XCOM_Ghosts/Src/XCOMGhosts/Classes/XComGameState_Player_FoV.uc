// This is an Unreal Script
                           
Class XComGameState_Player_FoV extends XComGameState_Player;


var  int  TurnsSinceEnemySeen;

function EventListenerReturn OnObjectVisibilityChanged(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local X2GameRulesetVisibilityInterface SourceObject;
	local XComGameState_Unit_FoV SeenUnit;
	local XComGameState_Unit_FoV SourceUnit;
	local GameRulesCache_VisibilityInfo VisibilityInfo;
	local X2GameRulesetVisibilityManager VisibilityMgr;
	local XComGameState NewGameState;
	local XComGameState_Player_FoV UpdatedPlayerState;
	local float mySign,UnitFoV ,orientation,ConcealmentDetectionDistance;
	local Vector aFacing,aToB;

	VisibilityMgr = `TACTICALRULES.VisibilityMgr;

	SourceObject = X2GameRulesetVisibilityInterface(EventSource); 
	if(SourceObject.GetAssociatedPlayerID() == ObjectID)
	{
		SeenUnit = XComGameState_Unit_FoV(EventData); // we only care about enemy units
		if(SeenUnit != none && SourceObject.TargetIsEnemy(SeenUnit.ObjectID))
		{
			SourceUnit = XComGameState_Unit_FoV(SourceObject);
			if(SourceUnit != none && GameState != none)
			{
				VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, SeenUnit.ObjectID, VisibilityInfo, GameState.HistoryIndex);
				if(VisibilityInfo.bVisibleGameplay)
				{
					if(TurnsSinceEnemySeen > 0 && SeenUnit.IsAlive())
					{
						NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("PlayerRecordEnemiesSeen");
						UpdatedPlayerState = XComGameState_Player_FoV(NewGameState.CreateStateObject(class'XComGameState_Player_FoV', ObjectID));
						UpdatedPlayerState.TurnsSinceEnemySeen = 0;
						NewGameState.AddStateObject(UpdatedPlayerState);
						`GAMERULES.SubmitGameState(NewGameState);
					}

					//Inform the units that they see each other
					class'XComGameState_Unit_FoV'.static.UnitASeesUnitB(SourceUnit, SeenUnit, GameState);
				}
				else if (VisibilityInfo.bVisibleBasic)
				{
					//If the target is not yet gameplay-visible, it might be because they are concealed.
					//Check if the source should break their concealment due to the new conditions.
					//(Typically happens in XComGameState_Unit when a unit moves, but there are edge cases,
					//like blowing up the last structure between two units, when it needs to happen here.)
					if (SeenUnit.IsConcealed() && SeenUnit.UnitBreaksConcealment(SourceUnit) && VisibilityInfo.TargetCover == CT_None)
					{
						ConcealmentDetectionDistance = SeenUnit.GetConcealmentDetectionDistance(SourceUnit);
						aFacing=Normal(Vector(XGUnit(SourceUnit.GetVisualizer()).GetPawn().Rotation));
						// Get the vector from A to B
						aToB=XGUnit(SeenUnit.GetVisualizer()).GetPawn().Location -XGUnit(SourceUnit.GetVisualizer()).GetPawn().Location;
 
						orientation = aFacing dot Normal(aToB);
						
						UnitFoV=aCos(orientation);
							
						`log("OnObjectVisChanged Check Unit Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV);		
						if(UnitFoV>1.2215 || UnitFoV<-1.2215)
						{
							mySign=0.0f;
						}
						else
						{
							mySign=1.0f;
						}
						if( VisibilityInfo.DefaultTargetDist <= mySign*Square(ConcealmentDetectionDistance*(Sqrt(mySign*(1-(0.67*(UnitFoV*UnitFoV) ) ) ) ) ))
						{
							`log("This Unit Broke Concealement- Facing Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@mySign*Square(ConcealmentDetectionDistance*(Sqrt(mySign*(1-(0.67*(UnitFoV*UnitFoV) ) ) ) ) ) @"DefTargetDist:"@VisibilityInfo.DefaultTargetDist);			

							SeenUnit.BreakConcealment(SourceUnit, VisibilityInfo.TargetCover == CT_None);
						}
					}
				}
			}
		}
	}

	return ELR_NoInterrupt;
}