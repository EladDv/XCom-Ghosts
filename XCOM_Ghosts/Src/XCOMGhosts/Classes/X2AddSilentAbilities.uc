// This is an Unreal Script

class X2AddSilentAbilities extends X2AmbientNarrativeCriteria;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	local X2CharacterTemplate CharTemp;
	local X2WeaponTemplate WepTemp;
	local X2CharacterTemplateManager CTM;
	local X2ItemTemplateManager ITM;

	Templates=Class 'X2Ability_Stealth'.static.CreateTemplates();
	`log("-------------------------------------Gave all soldiers ReConcealeSquad------------------------");

	Templates=Class 'X2Item_SilencedWeapons'.static.CreateTemplates();
	`log("-------------------------------------Gave all soldiers ReConcealeSquad------------------------");

	
	CTM= class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	ITM= class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	//WepTemp=X2WeaponTemplate(ITM.FindItemTemplate('AssaultRifle_CV'));
	//WepTemp.Abilities.AddItem('ChangeWeaponInstance');
	//`log("Gave all AR_CV ChangeWeaponInstace");
	

	CharTemp=CTM.FindCharacterTemplate('Soldier');
	CharTemp.Abilities.AddItem('ReConcealeSquad');
	CharTemp.Abilities.AddItem('ReConcealeIndividual');
	`log("-------------------------------------Gave all soldiers ReConcealeSquad------------------------");

	Templates.Length=0;
	return Templates;

}

