

class XComPathingPawn_Exposed extends XComPathingPawn config(GameCore);

var array<TTile>						    ConcealmentMarkers; // all tiles with a concealment marker on them

function SetConcealmentMarkers(array<TTile> Tiles)
{
	ConcealmentMarkers.Length=0;
	ConcealmentMarkers=Tiles;
	
}


simulated event Tick(float DeltaTime)
{
	super.Tick(DeltaTime);
	
	return;

}