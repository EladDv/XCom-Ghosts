// This is an Unreal Script
                           
class X2_Actor_CTE_Group extends Actor 
		Placeable;

var array<TTile>	AllColoredTiles;
var int				ObjectID;
var float			TimeCounter;
var StaticMesh		targetMesh;

struct TileMatchMatrix
{
	var int												UnitReference;
	var array<TTile>									FoVTiles; 
	var array<X2_Actor_ConcealmentTileEffects>			TileEffects;	
	var array<X2_Actor_ConcealmentBreakingTileEffects>	BreakingTileEffects;	
};
var array<TileMatchMatrix> CTE_Tile_Matrix;

simulated event PostBeginPlay()
{
	local object thisobj;

	thisobj=self;
	TargetMesh = StaticMesh(DynamicLoadObject("UI_3D.Tile.ConcealmentTile_Exit", class'StaticMesh'));
	
	`XEVENTMGR.RegisterForEvent(ThisObj, 'UnitDied', OnUnitRemovedFromPlay, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'UnitRemovedFromPlay', OnUnitRemovedFromPlay, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'TacticalGameEnd', OnTacticalEnded, ELD_Immediate, , ThisObj,true);
	//`XEVENTMGR.RegisterForEvent(ThisObj, 'ObjectMoved', UpdateTiles, ELD_Immediate, , ThisObj,true);
	//`XEVENTMGR.RegisterForEvent(ThisObj, 'ObjectVisibilityChanged', UpdateTiles, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'OnTacticalBeginPlay', OnTacticalEnded, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnEnded', OnTacticalEnded, ELD_Immediate, , ThisObj,true);
	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnBegun', CleanSlate, ELD_Immediate, , ThisObj,true);

	return;
}

event Tick(float deltaTime)
{
	local XComPlayerController PlayerState;
	local X2FadingInstancedStaticMeshComponent	OutComponent;

	foreach LocalPlayerControllers(class'XComPlayerController',PlayerState)
	{
		(XComTacticalController(PlayerState)).m_kPathingPawn.UpdateConcealmentTilesVisibility(true);                                           
	}	

	TimeCounter+=1;
	if( int(timeCounter)%(int(1/(deltaTime))) <2)
	{
		
		InitTiles();
		//`log("deltaTime:"@deltaTime @"INITIALIZED TILES!");	
		timeCounter=1;
	}
	else
		//`log("deltaTime:"@deltaTime);	

	return;
}
function InitTiles()
{
	local XComGameState_Unit					Unit,ControllingUnit;
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
	ControllingUnit=XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID( PC.ControllingUnit.ObjectID )); //Current unit controlled by the player
	InitObjcetTiles(); //Check Objects that can kill concealment like advent detection towers.
	if(ControllingUnit.IsConcealed())
	{
		
		foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Unit',Unit)
		{
			if(Unit.GetTeam()!=ETeam_XCom )
			{
				distanceToUnit=VSizeSq(XGUnit(Unit.GetVisualizer()).GetPawn().Location-XGUnit(ControllingUnit.GetVisualizer()).GetPawn().Location);
				VisibilityMgr.GetVisibilityInfo(ControllingUnit.ObjectID, Unit.ObjectID, VisibilityInfoFromThisUnit);
				if(VisibilityInfoFromThisUnit.bClearLOS ||distanceToUnit<=Square((`METERSTOUNITS(ControllingUnit.GetCurrentStat(eStat_SightRadius)*1.5)))) //Checking whether to draw the tiles, saves from drawing for all enemies on the map which would be proccessor intensive
				{
					Unit.GetKeystoneVisibilityLocation(CurrentTile); //Get's current Unit tile (Unit is the enemy)
					CurrentPosition = `XWORLD.GetPositionFromTileCoordinates(CurrentTile);
					ConcealmentDetectionDistance = ControllingUnit.GetConcealmentDetectionDistance(Unit);
					tempDist=ConcealmentDetectionDistance;
					TileRange=int(tempDist*1/`METERSTOUNITS(1));//Returns the range of tiles from the enemy (they are on a grid) that are inside (or just a bit outside for extra safety) the range where the player will lose concealment
					//`log("TileDistance:"$TileRange,true,'Team Dragonpunk');
					For(i=(-1*TileRange);i<TileRange;i++) //runs through a square from -TileRange on the X and Y (remember - a grid of tiles) to the +TileRange on the X and Y
					{
						NextTile.X=CurrentTile.X+i;
						for(j=(-1*TileRange);j<TileRange;j++)
						{

							aFacing=Normal(Vector(XGUnit(Unit.GetVisualizer()).GetPawn().Rotation));
							// Get the vector from A to B
							NextTile.Y=CurrentTile.Y+j;
							NextTile.Z=CurrentTile.Z;
							aToB=`XWORLD.GetPositionFromTileCoordinates(NextTile) - `XWORLD.GetPositionFromTileCoordinates(CurrentTile) ; //Get's the vector from the tile currently checking to the tile where the enemy is at
							Orientation = aFacing dot Normal(aToB); //Get's the angle between the tile and the enemy facing
							UnitFoV=aCos(orientation); //get's the actual angle
					
							if(UnitFoV>1.2215 || UnitFoV<-1.2215)// 70 deg in radians, could change easily and make it an INI parameter.
							{
								mySign=0.0f;
							}
							else
							{
								mySign=1.0f;
							}
							if(VSizeSq(aToB) <=mySign*Square(ConcealmentDetectionDistance) ) //Checks if the size of the distance vector from the newTile to the enemy tile is lower than the detection distance AND if the angle is below the specified one in mySign(70 degrees currently)
							{

								if(FindTile(NextTile,AllColoredTiles)) //if we already did that tile just skip it - saves a lot of calculations on post, maybe move it outside actually for possibly more performance because of early filtering
								{
									`log("Found Me already");
								}
								else
								{
									`log("Tile (i,j) Angle Deg:" @UnitFoV*57.2957795131 @"Rad:"@UnitFoV @"ConcealmentDist:"@mySign*Square(ConcealmentDetectionDistance*((mySign*(1-(0.67*(UnitFoV^2)) ))^0.5f) ) @"DefTargetDist:"@VSizeSq(aToB) @"MySign:"@MySign,true,'Team Dragonpunk');

									`log("i,j:"@"("$i$","$j$")",true,'Team Dragonpunk');
									`log(" ");
									TileNumber=CTE_Tile_Matrix.Find('UnitReference',Unit.ObjectID);
									NewTileEffect=none;
									SecondTileEffect=none;
									if(TileNumber!=-1)
									{
										NewTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentTileEffects');		//Initilize the effect actor
										SecondTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentBreakingTileEffects');//Initilize the effect actor
										TileLocation=`XWORLD.GetPositionFromTileCoordinates(NextTile);//Get the location from the tile
										TileLocation.Z = `XWORLD.GetFloorZForPosition(TileLocation) + 4;//Get the height From the tile (might need to improve to not have floating tiles)
										NewTileEffect.SetLocation(TileLocation);			
										NewTileEffect.SetHidden(false);
										SecondTileEffect.SetLocation(TileLocation);			
										SecondTileEffect.SetHidden(false);
										CTE_Tile_Matrix[TileNumber].FoVTiles.additem(NextTile);	//Adding the tile to the CTE struct array - saving the tiles and deleting ones for individual units
										CTE_Tile_Matrix[TileNumber].BreakingTileEffects.additem(SecondTileEffect);//Adding the tile effects to the CTE struct array - saving the tiles and deleting ones for individual units
										CTE_Tile_Matrix[TileNumber].TileEffects.additem(NewTileEffect);//Adding the tile effects to the CTE struct array - saving the tiles and deleting ones for individual units
										AllColoredTiles.AddItem(NextTile); //Adding the tile to the array of all tiles so we could filter it out later if needed
									}
									else
									{
										TMM.UnitReference=Unit.ObjectID;	//TMM is a new Tile match matrix object to add to the array later 	
										NewTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentTileEffects');
										SecondTileEffect=`BATTLE.Spawn(class'X2_Actor_ConcealmentBreakingTileEffects');
										TileLocation=`XWORLD.GetPositionFromTileCoordinates(NextTile);
										TileLocation.Z = `XWORLD.GetFloorZForPosition(TileLocation) + 4;
										NewTileEffect.SetLocation(TileLocation);
										NewTileEffect.SetHidden(false);
										SecondTileEffect.SetLocation(TileLocation);
										SecondTileEffect.SetHidden(false);	//basically the same as the one above
										TMM.FoVTiles.additem(NextTile);
										TMM.BreakingTileEffects.additem(SecondTileEffect);
										TMM.TileEffects.AddItem(NewTileEffect);
										CTE_Tile_Matrix.AddItem(TMM);	//Adding the TMM to the array of tile matrix
										AllColoredTiles.AddItem(NextTile); //Adding the tile to the array of all tiles 
									}
								}
							}
						}
					}			
				}
			}
		}
	}
	else
		DestroyAllTiles();
}

function InitObjcetTiles()
{
	local XComGameState_InteractiveObject			InteractiveObjectState;
	local Vector									TestPosition,CurrentPosition;
	local Vector									aFacing,aToB,TileLocation;
	local int										i,j,TileNumber,TileRange;
	local float										UnitFoV,mySign,ConcealmentDetectionDistance,distanceToUnit,tempDist,Orientation;
	local TTile										CurrentTile,NextTile;
	local X2_Actor_ConcealmentTileEffects			NewTileEffect;
	local X2_Actor_ConcealmentBreakingTileEffects	SecondTileEffect;
	local TileMatchMatrix							TMM;
	local XComTacticalController					PC;
	local XComGameState_Unit						ControllingUnit;

	PC=XComTacticalController(class'Engine'.static.GetCurrentWorldInfo().GetALocalPlayerController());
	ControllingUnit=XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID( PC.ControllingUnit.ObjectID ));
	foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_InteractiveObject', InteractiveObjectState) //Going over all Interactive objects 
	{
		if( InteractiveObjectState.DetectionRange > 0.0 && !InteractiveObjectState.bHasBeenHacked && ControllingUnit.IsConcealed() )	//Checking for ones that can break concealment like the advent detection tower
		{	//Basically the same as the original InitTiles() function just for these objects (to not clutter the code too much in that function)
			CurrentTile=InteractiveObjectState.TileLocation;
			TestPosition = `XWORLD.GetPositionFromTileCoordinates(InteractiveObjectState.TileLocation);
			ConcealmentDetectionDistance=InteractiveObjectState.DetectionRange;
			TileRange=int(ConcealmentDetectionDistance*1/`METERSTOUNITS(1));
			For(i=(-1*TileRange);i<TileRange;i++)
			{
				NextTile.X=CurrentTile.X+i;
				for(j=(-1*TileRange);j<TileRange;j++)
				{

					NextTile.Y=CurrentTile.Y+j;
					NextTile.Z=CurrentTile.Z;
					aToB=`XWORLD.GetPositionFromTileCoordinates(NextTile) - `XWORLD.GetPositionFromTileCoordinates(CurrentTile) ;

					if(VSizeSq(aToB) <=Square(ConcealmentDetectionDistance) )
					{

						if(FindTile(NextTile,AllColoredTiles))
						{
							continue;
						}
						else
						{

							`log("i,j:"@"("$i$","$j$")",true,'Team Dragonpunk');
							`log(" ");
							TileNumber=CTE_Tile_Matrix.Find('UnitReference',InteractiveObjectState.ObjectID);
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
								TMM.UnitReference=InteractiveObjectState.ObjectID;		
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

function DestroyTiles(int UnitMObjectIDef)
{
	local int				i,TileNumber;
	local TileMatchMatrix	TMM;
	local TTile				SelectedTile;

	TileNumber=CTE_Tile_Matrix.Find('UnitReference',UnitMObjectIDef);	//Destroying everything here, finding the unit via ObjectID (unitReference didnt work for some reason)
	if(TileNumber!=-1 && UnitMObjectIDef!=0)
	{
		For(i=0;i<CTE_Tile_Matrix[TileNumber].FoVTiles.length;i++)
		{
			SelectedTile=CTE_Tile_Matrix[TileNumber].FoVTiles[i];
			if(FindTile(SelectedTile,AllColoredTiles))
				{AllColoredTiles.RemoveItem(SelectedTile);}	//remove the tiles that exist on the unit from the array of all tiles so another unit could fill them if needed 

			CTE_Tile_Matrix[TileNumber].TileEffects[i].StaticMeshComponent.SetStaticMesh(TargetMesh);	//set a new invisible mesh just in case
			CTE_Tile_Matrix[TileNumber].TileEffects[i].SetHidden(true);		// hide it 
			CTE_Tile_Matrix[TileNumber].TileEffects[i].Destroy();	//destroy
			CTE_Tile_Matrix[TileNumber].TileEffects[i]=none;		//clear array entry
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i].StaticMeshComponent.SetStaticMesh(TargetMesh); //the same as above
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i].SetHidden(true);
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i].Destroy();	
			CTE_Tile_Matrix[TileNumber].BreakingTileEffects[i]=none;
		}
		CTE_Tile_Matrix[TileNumber].FoVTiles.length=0;	//clear the tiles for this one array object 
		CTE_Tile_Matrix[TileNumber].BreakingTileEffects.length=0;	//clear the effects for this one array object 
		CTE_Tile_Matrix[TileNumber].TileEffects.length=0;//clear the effects for this one array object 
		CTE_Tile_Matrix[TileNumber].UnitReference=0;//clear the ObjectID for this one array object 
		TMM=CTE_Tile_Matrix[TileNumber];	
		CTE_Tile_Matrix.RemoveItem(TMM);	//Remove the entry from the array entirely
	}
}

function DestroyAllTiles()
{
	local int						j,MObjectID;
	local XComGameState_Unit	Unit;

	foreach	`XCOMHISTORY.IterateByClassType(class'XComGameState_Unit',Unit)	//go through all units and kill all the tile effects.
	{
		
		MObjectID=Unit.ObjectID;
		DestroyTiles(MObjectID);
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
	DestroyTiles(XComGameState_Unit(EventData).ObjectID);
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

