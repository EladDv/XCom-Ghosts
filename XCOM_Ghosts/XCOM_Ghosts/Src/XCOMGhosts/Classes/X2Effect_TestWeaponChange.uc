// This is an Unreal Script
                           
class X2Effect_TestWeaponChange extends X2Effect;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local float				Rnd;
	local X2WeaponTemplate	WeaponTemplate;

	WeaponTemplate = X2WeaponTemplate( XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.ItemStateObjectRef.ObjectID)).GetMyTemplate());
	Rnd=FRAND();	
	if( Rnd>0.75)
	{
		WeaponTemplate.BaseDamage.Damage+=10;
		WeaponTemplate.iSoundRange=`UNITSTOMETERS(96*6);
		`log("tried changing Weapon instance");	
	}
}

