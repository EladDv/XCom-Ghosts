// This is an Unreal Script
                           
class UI_Listener_TacHUD_FoVConeDrawer extends UIScreenListener;

var array<X2Actor_ConeTarget> FoVConeActors;
var	UITacticalHUD MyScreen;	
event OnInit(UIScreen Screen)
{
	local Object ThisObj;
	
	ThisObj=self;
	MyScreen=UITacticalHUD(Screen);
//	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnBegun', DrawFoVCone, ELD_OnStateSubmitted,70);	
//	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnEnded', DrawFoVCone, ELD_OnStateSubmitted,70);	
	`log("Activated Cone Drawer Listener",true,'DragonPunk Stealth Mod');	
}
function EventListenerReturn DrawFoVCone(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{ 
	local XComPlayerController					PlayerState;
	local XComGameState_Unit_FoV				Unit;
	local X2Actor_ConeTarget					ConeActor;
	local bool									DrewCone,HasConcealedUnits;
	local vector								EnemyLocation,Facing,FiringLocation;
	local float									ConeLength,ConeWidth;
	local X2FadingInstancedStaticMeshComponent	OutComponent;
	local InstancedStaticMeshInstanceData		InstanceData;
	local int									i;
	
	DrewCone=false;
	//ConeActor=none;
	`log("Going for the Components",true,'Team Dragonpunk Stealth Mod');
	
	`log("After the Components",true,'Team Dragonpunk Stealth Mod');
}
/*ConeLength=((Unit.GetMaxStat(eStat_DetectionRadius)-1)*class'XComWorldData'.const.WORLD_StepSize);
			ConeWidth=2*(aCos(70*0.01745329252f)/aSin(70*0.01745329252f))*ConeLength; 
			EnemyLocation=XGUnit(Unit.GetVisualizer()).GetPawn().Location;	
			Facing=Normal(Vector(XGUnit(Unit.GetVisualizer()).GetPawn().Rotation));
			FiringLocation=EnemyLocation+Facing*ConeLength;

			ConeActor = `BATTLE.Spawn(class'X2Actor_ConeTarget');
			ConeActor.MeshLocation = "UI_3D.Targeting.ConeRange";
			ConeActor.InitConeMesh(ConeLength / class'XComWorldData'.const.WORLD_StepSize, ConeWidth / class'XComWorldData'.const.WORLD_StepSize);
			ConeActor.SetLocation(FiringLocation);*/
defaultproperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	ScreenClass=UITacticalHUD;
}	