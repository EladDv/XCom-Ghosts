// This is an Unreal Script
                           
class X2_Actor_CTE_Group extends Actor 
		Placeable;

var array<TTile>	AllColoredTiles;
var int				ObjectID;
var float			TimeCounter;
var StaticMesh		targetMesh;

struct TileMatchMatrix
{
	var StateObjectReference							UnitReference;
	var array<TTile>									FoVTiles; 
	var array<X2_Actor_ConcealmentTileEffects>			TileEffects;	
	var array<X2_Actor_ConcealmentBreakingTileEffects>	BreakingTileEffects;	
};
var array<TileMatchMatrix> CTE_Tile_Matrix;

simulated event PostBeginPlay()
{
	local object thisobj;

	thisobj=self;
	TargetMesh = StaticMesh(DynamicLoadObject("UI_3D.Tile.ConcealmentTile_Enter", class'StaticMesh'));
	
	`XEVENTMGR.RegisterForEvent(ThisObj, 'UnitDied', OnUnitRemovedFromPlay, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'UnitRemovedFromPlay', OnUnitRemovedFromPlay, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'TacticalGameEnd', OnTacticalEnded, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'ObjectMoved', UpdateTiles, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'ObjectVisibilityChanged', UpdateTiles, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'OnTacticalBeginPlay', OnTacticalEnded, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnEnded', OnTacticalEnded, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnBegun', CleanSlate, ELD_Immediate, , ThisObj,true);
}

event Tick(float deltaTime)
{
	local XComPlayerController PlayerState;

	foreach LocalPlayerControllers(class'XComPlayerController',PlayerState)
	{
		(XComTacticalController(PlayerState)).m_kPathingPawn.UpdateConcealmentTilesVisibility(true);                               
	}	

	TimeCounter+=1;
	if( int(timeCounter)%(int(1/(2*deltaTime))) <2)
	{
		
		InitTiles();
		`log("deltaTime:"@deltaTime @"INITIALIZED TILES!");	
		timeCounter=1;
	}
	else
		`log("deltaTime:"@deltaTime);	
}
function InitTiles()
{
	local XComGameState_Unit_FoV					Unit,ControllingUnit;
	local X2_Actor_ConcealmentTileEffects			NewTileEffect;
	local X2_Actor_ConcealmentBreakingTileEffects	SecondTileEffect;
	local TTile										CurrentTile,NextTile;
	local int										i,j,TileNumber,TileRange;
	local XComTacticalController					PC;
	local GameRulesCache_VisibilityInfo				VisibilityInfoFromThisUnit;
	local X2GameRulesetVisibilityManager			VisibilityMgr;
	local Vector									aFacing,aToB,CurrentPosition,TileLocation;
	local float										UnitFoV,mySign,ConcealmentDetectionDistance,distanceToUnit,tempDist,Orientation;
	local TileMatchMatrix							TMM;

	VisibilityMgr = `TACTICALRULES.VisibilityMgr;
	PC=XComTacticalController(class'Engine'.static.GetCurrentWorldInfo().GetALocalPlayerController());
	ControllingUnit=XComGameState_Unit_FoV(`XCOMHISTORY.GetGameStateForObjectID( PC.ControllingUnit.ObjectID ));
	if(ControllingUnit.IsConcealed())
	{
		foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Unit_FoV',Unit)
		{
			if(Unit.GetTeam()!=ETeam_XCom )
			{
				distanceToUnit=VSizeSq(XGUnit(Unit.GetVisualizer()).GetPawn().Location-XGUnit(ControllingUnit.GetVisualizer()).GetPawn().Location);
				VisibilityMgr.GetVisibilityInfo(ControllingUnit.ObjectID, Unit.ObjectID, VisibilityInfoFromThisUnit);
				if(VisibilityInfoFromThisUnit.bClearLOS ||distanceToUnit<=Square((`METERSTOUNITS(ControllingUnit.GetCurrentStat(eStat_SightRadius)*1.5))))
				{
					Unit.GetKeystoneVisibilityLocation(CurrentTile);
					CurrentPosition = `XWORLD.GetPositionFromTileCoordinates(CurrentTile);
					ConcealmentDetectionDistance = ControllingUnit.GetConcealmentDetectionDistance(Unit);
					tempDist=ConcealmentDetectionDistance/1.5f;
					TileRange=int(tempDist*1/`METERSTOUNITS(1));
					//`log("TileDistance:"$TileRange,true,'Team Dragonpunk');
					For(i=(-1*TileRange);i<TileRange;i++)
					{
						NextTile.X=CurrentTile.X+i;
						for(j=(-1*TileRange);j<TileRange;j++)
						{

							aFacing=Normal(Vector(XGUnit(Unit.GetVisualizer()).GetPawn().Rotation));
							// Get the vector from A to B
							NextTile.Y=CurrentTile.Y+j;
							NextTile.Z=CurrentTile.Z;
							aToB=`XWORLD.GetPositionFromTileCoordinates(NextTile) - `XWORLD.GetPositionFromTileCoordinates(CurrentTile) ;
							Orientation = aFacing dot Normal(aToB);
							UnitFoV=aCos(orientation);
					
							if(UnitFoV>1.2215 || UnitFoV<-1.2215)
							{
								mySign=0.0f;
							}
							else
							{
								mySign=1.0f;
							}
							if(VSizeSq(aToB) <=mySign*Square(ConcealmentDetectionDistance) )
							{

								if(FindTile(NextTile,AllColoredTiles))
								{
									continue;
								}
								else
								{
									`log("Tile (i,j) Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@mySign*Square(ConcealmentDetectionDistance*((mySign*(1-(0.67*(UnitFoV^2)) ))^0.5f) ) @"DefTargetDist:"@VSizeSq(aToB) @"MySign:"@MySign,true,'Team Dragonpunk');

									`log("i,j:"@"("$i$","$j$")",true,'Team Dragonpunk');
									`log(" ");
									TileNumber=CTE_Tile_Matrix.Find('UnitReference',Unit.GetReference());
									NewTileEffect=none;
									SecondTileEffect=none;
									if(TileNumber!=-1)
									{
										NewTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentTileEffects');
										SecondTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentBreakingTileEffects');
										TileLocation=`XWORLD.GetPositionFromTileCoordinates(NextTile);
										TileLocation.Z = `XWORLD.GetFloorZForPosition(TileLocation) + 4;
										NewTileEffect.SetLocation(TileLocation);			
										NewTileEffect.SetHidden(false);
										SecondTileEffect.SetLocation(TileLocation);			
										SecondTileEffect.SetHidden(false);
										CTE_Tile_Matrix[TileNumber].FoVTiles.additem(NextTile);
										CTE_Tile_Matrix[TileNumber].BreakingTileEffects.additem(SecondTileEffect);
										CTE_Tile_Matrix[TileNumber].TileEffects.additem(NewTileEffect);
										AllColoredTiles.AddItem(NextTile);
									}
									else
									{
										TMM.UnitReference=Unit.GetReference();		
										NewTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentTileEffects');
										SecondTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentBreakingTileEffects');
										TileLocation=`XWORLD.GetPositionFromTileCoordinates(NextTile);
										TileLocation.Z = `XWORLD.GetFloorZForPosition(TileLocation) + 4;
										NewTileEffect.SetLocation(TileLocation);
										NewTileEffect.SetHidden(false);
										SecondTileEffect.SetLocation(TileLocation);
										SecondTileEffect.SetHidden(false);
										TMM.FoVTiles.additem(NextTile);
										TMM.BreakingTileEffects.additem(SecondTileEffect);
										TMM.TileEffects.AddItem(NewTileEffect);
										CTE_Tile_Matrix.AddItem(TMM);
										AllColoredTiles.AddItem(NextTile);
									}
								}
							}
						}
					}			
				}
			}
		}
	}
}

function DestroyTiles(StateObjectReference UnitRef)
{
	local int				i,TileNumber;
	local TileMatchMatrix	TMM;
	local TTile				SelectedTile;

	TileNumber=CTE_Tile_Matrix.Find('UnitReference',UnitRef);
	if(TileNumber!=-1)
	{
		For(i=0;i<CTE_Tile_Matrix[TileNumber].FoVTiles.length;i++)
		{
			SelectedTile=CTE_Tile_Matrix[TileNumber].FoVTiles[i];
			if(FindTile(SelectedTile,AllColoredTiles))
				{AllColoredTiles.RemoveItem(SelectedTile);}

			CTE_Tile_Matrix[TileNumber].TileEffects[i].SetHidden(true);
			CTE_Tile_Matrix[TileNumber].TileEffects[i].StaticMeshComponent.SetStaticMesh(TargetMesh);
			CTE_Tile_Matrix[TileNumber].TileEffects[i].Destroy();	
			CTE_Tile_Matrix[TileNumber].TileEffects[i]=none;
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i].SetHidden(true);
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i].StaticMeshComponent.SetStaticMesh(TargetMesh);
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i].Destroy();	
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i]=none;
		}
		CTE_Tile_Matrix[TileNumber].FoVTiles.length=0;
		CTE_Tile_Matrix[TileNumber].BreakingTileEffects.length=0;
		CTE_Tile_Matrix[TileNumber].TileEffects.length=0;
		TMM=CTE_Tile_Matrix[TileNumber];
		CTE_Tile_Matrix.RemoveItem(TMM);
	}
}

function DestroyAllTiles()
{
	local int					j;
	local StateObjectReference	UnitRef;
	for(j=0;j<CTE_Tile_Matrix.Length;j++)
	{
		UnitRef=CTE_Tile_Matrix[j].UnitReference;
		DestroyTiles(UnitRef);
	}	
	CTE_Tile_Matrix.Length=0;
}

function bool FindTile(TTile tile, out array<TTile> findArray)
{
	local TTile iter;
	
	foreach findArray(iter)
	{
		if (iter == tile)
		{
			return true;
		}
	}

	return false;
}
function EventListenerReturn OnUnitRemovedFromPlay(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	DestroyTiles(XComGameState_Unit(EventData).GetReference());
	return ELR_NoInterrupt;
}
function EventListenerReturn OnTacticalEnded(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	DestroyAllTiles();
	return ELR_NoInterrupt;
}
function EventListenerReturn UpdateTiles(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComPlayerController PlayerState;

	foreach LocalPlayerControllers(class'XComPlayerController',PlayerState)
	{
		(XComTacticalController(PlayerState)).m_kPathingPawn.UpdateConcealmentTilesVisibility(false);                               
	}
	InitTiles();
	return ELR_NoInterrupt;
}

function EventListenerReturn CleanSlate(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	DestroyAllTiles();
	InitTiles();
	return ELR_NoInterrupt;
}

