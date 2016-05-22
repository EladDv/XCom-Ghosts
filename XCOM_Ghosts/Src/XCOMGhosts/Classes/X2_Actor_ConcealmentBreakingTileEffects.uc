// This is an Unreal Script
                           
Class X2_Actor_ConcealmentBreakingTileEffects extends StaticMeshActor;


simulated event PostBeginPlay()
{
	local staticMesh TargetMesh;

	Super.PostBeginPlay();

	TargetMesh = StaticMesh(DynamicLoadObject("UI_3D.Tile.ConcealmentBreakTile_Enter", class'StaticMesh'));
	`assert(TargetMesh != none);
	StaticMeshComponent.SetStaticMesh(TargetMesh);	
	
	return;
}

simulated event Destroyed ()
{
	local staticMesh TargetMesh;
	TargetMesh = StaticMesh(DynamicLoadObject("UI_3D.Tile.ConcealmentTile_Exit", class'StaticMesh'));
	SetHidden(True);
	StaticMeshComponent.SetStaticMesh(TargetMesh);
	super.Destroyed();	
	
	return;
}

DefaultProperties
{
	Begin Object Name=StaticMeshComponent0
		bOwnerNoSee=FALSE
		CastShadow=FALSE
		CollideActors=FALSE
		BlockActors=FALSE
		BlockZeroExtent=FALSE
		BlockNonZeroExtent=FALSE
		BlockRigidBody=FALSE
		HiddenGame=FALSE
		HideDuringCinematicView=true
	End Object

	bStatic=FALSE
	bWorldGeometry=FALSE
	bMovable=TRUE
	
}