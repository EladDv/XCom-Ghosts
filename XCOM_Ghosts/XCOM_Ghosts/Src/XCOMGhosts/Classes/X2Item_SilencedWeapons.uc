// This is an Unreal Script
                           
class X2Item_SilencedWeapons extends X2Item config(SilencedWeapons_WeaponData);

var config WeaponDamageValue ASSAULTRIFLE_CONVENTIONAL_BASEDAMAGE;
var config WeaponDamageValue ASSAULTRIFLE_MAGNETIC_BASEDAMAGE;
var config WeaponDamageValue ASSAULTRIFLE_BEAM_BASEDAMAGE;

var config WeaponDamageValue LMG_CONVENTIONAL_BASEDAMAGE;
var config WeaponDamageValue LMG_MAGNETIC_BASEDAMAGE;
var config WeaponDamageValue LMG_BEAM_BASEDAMAGE;

var config WeaponDamageValue PISTOL_CONVENTIONAL_BASEDAMAGE;
var config WeaponDamageValue PISTOL_MAGNETIC_BASEDAMAGE;
var config WeaponDamageValue PISTOL_BEAM_BASEDAMAGE;

var config WeaponDamageValue SNIPERRIFLE_CONVENTIONAL_BASEDAMAGE;
var config WeaponDamageValue SNIPERRIFLE_MAGNETIC_BASEDAMAGE;
var config WeaponDamageValue SNIPERRIFLE_BEAM_BASEDAMAGE; 

var config int GHOSTGRENADE_STEALTH_DURATION;
var config int GHOSTGRENADE_ISOUNDRANGE;
var config int GHOSTGRENADE_IENVIRONMENTDAMAGE;
var config int GHOSTGRENADE_ISUPPLIES;
var config int GHOSTGRENADE_TRADINGPOSTVALUE;
var config int GHOSTGRENADE_IPOINTS;
var config int GHOSTGRENADE_ICLIPSIZE;
var config int GHOSTGRENADE_RANGE;
var config int GHOSTGRENADE_RADIUS;


var config int SNIPERRIFLE_CONVENTIONAL_AIM;
var config int SNIPERRIFLE_CONVENTIONAL_CRITCHANCE;
var config int SNIPERRIFLE_CONVENTIONAL_ICLIPSIZE;
var config int SNIPERRIFLE_CONVENTIONAL_ISOUNDRANGE;
var config int SNIPERRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
var config int SNIPERRIFLE_CONVENTIONAL_ISUPPLIES;
var config int SNIPERRIFLE_CONVENTIONAL_TRADINGPOSTVALUE;
var config int SNIPERRIFLE_CONVENTIONAL_IPOINTS;

var config int SNIPERRIFLE_MAGNETIC_AIM;
var config int SNIPERRIFLE_MAGNETIC_CRITCHANCE;
var config int SNIPERRIFLE_MAGNETIC_ICLIPSIZE;
var config int SNIPERRIFLE_MAGNETIC_ISOUNDRANGE;
var config int SNIPERRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
var config int SNIPERRIFLE_MAGNETIC_ISUPPLIES;
var config int SNIPERRIFLE_MAGNETIC_TRADINGPOSTVALUE;
var config int SNIPERRIFLE_MAGNETIC_IPOINTS;

var config int SNIPERRIFLE_BEAM_AIM;
var config int SNIPERRIFLE_BEAM_CRITCHANCE;
var config int SNIPERRIFLE_BEAM_ICLIPSIZE;
var config int SNIPERRIFLE_BEAM_ISOUNDRANGE;
var config int SNIPERRIFLE_BEAM_IENVIRONMENTDAMAGE;
var config int SNIPERRIFLE_BEAM_ISUPPLIES;
var config int SNIPERRIFLE_BEAM_TRADINGPOSTVALUE;
var config int SNIPERRIFLE_BEAM_IPOINTS;

var config int PISTOL_CONVENTIONAL_AIM;
var config int PISTOL_CONVENTIONAL_CRITCHANCE;
var config int PISTOL_CONVENTIONAL_ICLIPSIZE;
var config int PISTOL_CONVENTIONAL_ISOUNDRANGE;
var config int PISTOL_CONVENTIONAL_IENVIRONMENTDAMAGE;
var config int PISTOL_CONVENTIONAL_ISUPPLIES;
var config int PISTOL_CONVENTIONAL_TRADINGPOSTVALUE;
var config int PISTOL_CONVENTIONAL_IPOINTS;

var config int PISTOL_MAGNETIC_AIM;
var config int PISTOL_MAGNETIC_CRITCHANCE;
var config int PISTOL_MAGNETIC_ICLIPSIZE;
var config int PISTOL_MAGNETIC_ISOUNDRANGE;
var config int PISTOL_MAGNETIC_IENVIRONMENTDAMAGE;
var config int PISTOL_MAGNETIC_ISUPPLIES;
var config int PISTOL_MAGNETIC_TRADINGPOSTVALUE;
var config int PISTOL_MAGNETIC_IPOINTS;

var config int PISTOL_BEAM_AIM;
var config int PISTOL_BEAM_CRITCHANCE;
var config int PISTOL_BEAM_ICLIPSIZE;
var config int PISTOL_BEAM_ISOUNDRANGE;
var config int PISTOL_BEAM_IENVIRONMENTDAMAGE;
var config int PISTOL_BEAM_ISUPPLIES;
var config int PISTOL_BEAM_TRADINGPOSTVALUE;
var config int PISTOL_BEAM_IPOINTS;


var config int MAIN_PISTOL_CONVENTIONAL_ICLIPSIZE;
var config int MAIN_PISTOL_MAGNETIC_ICLIPSIZE;
var config int MAIN_PISTOL_BEAM_ICLIPSIZE;


var config int ASSAULTRIFLE_CONVENTIONAL_AIM;
var config int ASSAULTRIFLE_CONVENTIONAL_CRITCHANCE;
var config int ASSAULTRIFLE_CONVENTIONAL_ICLIPSIZE;
var config int ASSAULTRIFLE_CONVENTIONAL_ISOUNDRANGE;
var config int ASSAULTRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
var config int ASSAULTRIFLE_CONVENTIONAL_ISUPPLIES;
var config int ASSAULTRIFLE_CONVENTIONAL_TRADINGPOSTVALUE;
var config int ASSAULTRIFLE_CONVENTIONAL_IPOINTS;

var config int ASSAULTRIFLE_MAGNETIC_AIM;
var config int ASSAULTRIFLE_MAGNETIC_CRITCHANCE;
var config int ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
var config int ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
var config int ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
var config int ASSAULTRIFLE_MAGNETIC_ISUPPLIES;
var config int ASSAULTRIFLE_MAGNETIC_TRADINGPOSTVALUE;
var config int ASSAULTRIFLE_MAGNETIC_IPOINTS;

var config int ASSAULTRIFLE_BEAM_AIM;
var config int ASSAULTRIFLE_BEAM_CRITCHANCE;
var config int ASSAULTRIFLE_BEAM_ICLIPSIZE;
var config int ASSAULTRIFLE_BEAM_ISOUNDRANGE;
var config int ASSAULTRIFLE_BEAM_IENVIRONMENTDAMAGE;
var config int ASSAULTRIFLE_BEAM_ISUPPLIES;
var config int ASSAULTRIFLE_BEAM_TRADINGPOSTVALUE;
var config int ASSAULTRIFLE_BEAM_IPOINTS;

var config int LMG_CONVENTIONAL_AIM;
var config int LMG_CONVENTIONAL_CRITCHANCE;
var config int LMG_CONVENTIONAL_ICLIPSIZE;
var config int LMG_CONVENTIONAL_ISOUNDRANGE;
var config int LMG_CONVENTIONAL_IENVIRONMENTDAMAGE;
var config int LMG_CONVENTIONAL_ISUPPLIES;
var config int LMG_CONVENTIONAL_TRADINGPOSTVALUE;
var config int LMG_CONVENTIONAL_IPOINTS;

var config int LMG_MAGNETIC_AIM;
var config int LMG_MAGNETIC_CRITCHANCE;
var config int LMG_MAGNETIC_ICLIPSIZE;
var config int LMG_MAGNETIC_ISOUNDRANGE;
var config int LMG_MAGNETIC_IENVIRONMENTDAMAGE;
var config int LMG_MAGNETIC_ISUPPLIES;
var config int LMG_MAGNETIC_TRADINGPOSTVALUE;
var config int LMG_MAGNETIC_IPOINTS;

var config int LMG_BEAM_AIM;
var config int LMG_BEAM_CRITCHANCE;
var config int LMG_BEAM_ICLIPSIZE;
var config int LMG_BEAM_ISOUNDRANGE;
var config int LMG_BEAM_IENVIRONMENTDAMAGE;
var config int LMG_BEAM_ISUPPLIES;
var config int LMG_BEAM_TRADINGPOSTVALUE;
var config int LMG_BEAM_IPOINTS;

Var config float SILENCER_RANGE_REDUCTION_MULTIPLIER;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;
	
	Weapons.AddItem(CreateTemplate_Cannon_ConventionalSilent());
	Weapons.AddItem(CreateTemplate_Cannon_MagneticSilent());
	Weapons.AddItem(CreateTemplate_Cannon_BeamSilent());

	Weapons.AddItem(CreateTemplate_Pistol_ConventionalSilent());
	Weapons.AddItem(CreateTemplate_Pistol_MagneticSilent());
	Weapons.AddItem(CreateTemplate_Pistol_BeamSilent());

	Weapons.AddItem(Main_CreateTemplate_Pistol_ConventionalSilent());
	Weapons.AddItem(Main_CreateTemplate_Pistol_MagneticSilent());
	Weapons.AddItem(Main_CreateTemplate_Pistol_BeamSilent());

	Weapons.AddItem(CreateTemplate_SniperRifle_ConventionalSilent());
	Weapons.AddItem(CreateTemplate_SniperRifle_MagneticSilent());
	Weapons.AddItem(CreateTemplate_SniperRifle_BeamSilent());
	
	Weapons.AddItem(CreateTemplate_AssaultRifle_ConventionalSilent());
	Weapons.AddItem(CreateTemplate_AssaultRifle_MagneticSilent());
	Weapons.AddItem(CreateTemplate_AssaultRifle_BeamSilent());
	

	Weapons.AddItem(CreateBasicSilencerUpgrade());

	return Weapons;

}

static function int GetZero(X2WeaponUpgradeTemplate UpgradeTemplate)
{
	return default.SILENCER_RANGE_REDUCTION_MULTIPLIER;
}
Static function string GetSilencedAbilityName(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Ability AbilityState)
{
	return "Silenced Weapon";	
} 
function bool Silence(X2WeaponUpgradeTemplate UpgradeTemplate, XComGameState_Unit TargetUnit)
{
	return true;
}

static function X2DataTemplate CreateBasicSilencerUpgrade()
{
	local X2WeaponUpgradeTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponUpgradeTemplate', Template, 'Silencer_Bsc');

	Class'X2Item_DefaultUpgrades'.static.SetUpFreeKillUpgrade(Template);
	
	Template.CanApplyUpgradeToWeaponFn = Class'X2Item_DefaultUpgrades'.static.CanApplyUpgradeToWeapon;
	
	Template.CanBeBuilt = false;
	Template.MaxQuantity = 1;
		
	Template.FreeKillFn = Silence;
	Template.GetBonusAmountFn = GetZero;
	
	Template.FreeKillChance = default.SILENCER_RANGE_REDUCTION_MULTIPLIER;

	Template.BlackMarketTexts = Class'X2Item_DefaultUpgrades'.default.UpgradeBlackMarketTexts;

	Template.LootStaticMesh = StaticMesh'UI_3D.Loot.WeapFragmentA';
	Template.TradingPostValue = 10;
	Template.Tier = 0;

	Template.BonusAbilities.AddItem('Silenced');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv";
	
	Template.MutuallyExclusiveUpgrades.AddItem('FreeKillUpgrade');
	Template.MutuallyExclusiveUpgrades.AddItem('Silencer_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('FreeKillUpgrade_Bsc');
	Template.MutuallyExclusiveUpgrades.AddItem('FreeKillUpgrade_Adv');
	Template.MutuallyExclusiveUpgrades.AddItem('FreeKillUpgrade_Sup');
	
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_SuppressorB", "", 'AssaultRifle_CV', , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvAssault_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_SuppressorB", "", 'AssaultRifle_MG', , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_SuppressorB", "", 'AssaultRifle_BM', , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamAssaultRifle_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Sniper_Suppressor', "ConvSniper.Meshes.SM_ConvSniper_SuppressorB", "", 'SniperRifle_CV', , "img:///UILibrary_Common.ConvSniper.ConvSniper_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvSniper_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Sniper_Suppressor', "MagSniper.Meshes.SM_MagSniper_SuppressorB", "", 'SniperRifle_MG', , "img:///UILibrary_Common.UI_MagSniper.MagSniper_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagSniper_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Sniper_Suppressor', "BeamSniper.Meshes.SM_BeamSniper_SuppressorB", "", 'SniperRifle_BM', , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamSniper_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "ConvCannon.Meshes.SM_ConvCannon_SuppressorB", "", 'Cannon_CV', , "img:///UILibrary_Common.ConvCannon.ConvCannon_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.ConvCannon_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "MagCannon.Meshes.SM_MagCannon_SuppressorB", "", 'Cannon_MG', , "img:///UILibrary_Common.UI_MagCannon.MagCannon_SuppressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.MagCannon_SuppressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "BeamCannon.Meshes.SM_BeamCannon_SuppressorB", "", 'Cannon_BM', , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_SupressorB", "img:///UILibrary_StrategyImages.X2InventoryIcons.BeamCannon_SupressorB_inv", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

	Template.FriendlyRenameFn=GetSilencedAbilityName;

	return Template;
}


static function X2DataTemplate CreateTemplate_AssaultRifle_ConventionalSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'AssaultRifle_CV_Silent');
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_Base";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE; 
	Template.BaseDamage = default.ASSAULTRIFLE_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.ASSAULTRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = default.ASSAULTRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.ASSAULTRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_AssaultRifle_CV.WP_AssaultRifle_CV";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagA");
	Template.AddDefaultAttachment('Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticA");
	Template.AddDefaultAttachment('Reargrip', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_ReargripA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_ReargripA");
	Template.AddDefaultAttachment('Stock', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_StockA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_StockA");
	Template.AddDefaultAttachment('Trigger', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_TriggerA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	
	Template.UpgradeItem = 'AssaultRifle_MG_Silent';

	Template.fKnockbackDamageAmount = 5.0f;
	Template.fKnockbackDamageRadius = 0.0f;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';
	
	return Template;
}

static function X2DataTemplate CreateTemplate_AssaultRifle_MagneticSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'AssaultRifle_MG_Silent');
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 2;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = default.ASSAULTRIFLE_MAGNETIC_BASEDAMAGE;
	Template.Aim = default.ASSAULTRIFLE_MAGNETIC_AIM;
	Template.CritChance = default.ASSAULTRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	Template.GameArchetype = "WP_AssaultRifle_MG.WP_AssaultRifle_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagA");
	Template.AddDefaultAttachment('Suppressor', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_SuppressorA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_SupressorA");
	Template.AddDefaultAttachment('Reargrip', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_ReargripA", , /* included with TriggerA */);
	Template.AddDefaultAttachment('Stock', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_StockA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_StockA");
	Template.AddDefaultAttachment('Trigger', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_TriggerA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;
	
	Template.UpgradeItem = 'AssaultRifle_BM_Silent';

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_AssaultRifle_BeamSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'AssaultRifle_BM_Silent');
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = 4;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = default.ASSAULTRIFLE_BEAM_BASEDAMAGE;
	Template.Aim = default.ASSAULTRIFLE_BEAM_AIM;
	Template.CritChance = default.ASSAULTRIFLE_BEAM_CRITCHANCE;
	Template.iClipSize = default.ASSAULTRIFLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	Template.GameArchetype = "WP_AssaultRifle_BM.WP_AssaultRifle_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_MagA");
	Template.AddDefaultAttachment('Suppressor', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_SuppressorA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_SupressorA");
	Template.AddDefaultAttachment('Core', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_CoreA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_CoreA");
	Template.AddDefaultAttachment('HeatSink', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_HeatSinkA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_HeatsinkA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_ConventionalSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Pistol_CV_Silent');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.PISTOL_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.PISTOL_CONVENTIONAL_AIM;
	Template.CritChance = default.PISTOL_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.PISTOL_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;

	Template.InfiniteAmmo = true;
	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');	
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_CV.WP_Pistol_CV";

	Template.iPhysicsImpulse = 5;
	
	Template.UpgradeItem = 'Pistol_MG_Silent';

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_MagneticSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Pistol_MG_Silent');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 2;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = default.PISTOL_MAGNETIC_BASEDAMAGE;
	Template.Aim = default.PISTOL_MAGNETIC_AIM;
	Template.CritChance = default.PISTOL_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.PISTOL_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_MG.WP_Pistol_MG";

	Template.iPhysicsImpulse = 5;

	Template.UpgradeItem = 'Pistol_BM_Silent';

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_BeamSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Pistol_BM_Silent');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = 4;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = default.PISTOL_BEAM_BASEDAMAGE;
	Template.Aim = default.PISTOL_BEAM_AIM;
	Template.CritChance = default.PISTOL_BEAM_CRITCHANCE;
	Template.iClipSize = default.PISTOL_BEAM_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeamA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_BM.WP_Pistol_BM";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	
	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate Main_CreateTemplate_Pistol_ConventionalSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Main_Pistol_CV_Silent');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.PISTOL_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.PISTOL_CONVENTIONAL_AIM;
	Template.CritChance = default.PISTOL_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.MAIN_PISTOL_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;

	Template.InfiniteAmmo = false;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('StealthyEquipment');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');	
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_CV.WP_Pistol_CV";

	Template.iPhysicsImpulse = 5;
	
	Template.UpgradeItem = 'Pistol_MG_Silent';

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate Main_CreateTemplate_Pistol_MagneticSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Main_Pistol_MG_Silent');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 2;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = default.PISTOL_MAGNETIC_BASEDAMAGE;
	Template.Aim = default.PISTOL_MAGNETIC_AIM;
	Template.CritChance = default.PISTOL_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.MAIN_PISTOL_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.InfiniteAmmo=false;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('StealthyEquipment');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_MG.WP_Pistol_MG";

	Template.iPhysicsImpulse = 5;

	Template.UpgradeItem = 'Pistol_BM_Silent';

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate Main_CreateTemplate_Pistol_BeamSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Main_Pistol_BM_Silent');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = 4;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = default.PISTOL_BEAM_BASEDAMAGE;
	Template.Aim = default.PISTOL_BEAM_AIM;
	Template.CritChance = default.PISTOL_BEAM_CRITCHANCE;
	Template.iClipSize = default.MAIN_PISTOL_BEAM_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.InfiniteAmmo = False;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('StealthyEquipment');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeamA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_BM.WP_Pistol_BM";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	
	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Cannon_ConventionalSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Cannon_CV_Silent');
	Template.WeaponPanelImage = "_ConventionalCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvCannon.ConvCannon_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.LMG_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.LMG_CONVENTIONAL_AIM;
	Template.CritChance = default.LMG_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.LMG_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = default.LMG_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LMG_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 1;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Cannon_CV.WP_Cannon_CV";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', 		"ConvCannon.Meshes.SM_ConvCannon_MagA", , "img:///UILibrary_Common.ConvCannon.ConvCannon_MagA");
	Template.AddDefaultAttachment('Reargrip',   "ConvCannon.Meshes.SM_ConvCannon_ReargripA"/*REARGRIP INCLUDED IN TRIGGER IMAGE*/);
	Template.AddDefaultAttachment('Stock', 		"ConvCannon.Meshes.SM_ConvCannon_StockA", , "img:///UILibrary_Common.ConvCannon.ConvCannon_StockA");
	Template.AddDefaultAttachment('StockSupport', "ConvCannon.Meshes.SM_ConvCannon_StockA_Support");
	Template.AddDefaultAttachment('Suppressor', "ConvCannon.Meshes.SM_ConvCannon_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "ConvCannon.Meshes.SM_ConvCannon_TriggerA", , "img:///UILibrary_Common.ConvCannon.ConvCannon_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.UpgradeItem = 'Cannon_MG_Silent';

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_Cannon_MagneticSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Cannon_MG_Silent');
	Template.WeaponPanelImage = "_MagneticCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.UI_MagCannon.MagCannon_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 3;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = default.LMG_MAGNETIC_BASEDAMAGE;
	Template.Aim = default.LMG_MAGNETIC_AIM;
	Template.CritChance = default.LMG_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.LMG_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.LMG_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LMG_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Cannon_MG.WP_Cannon_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', "MagCannon.Meshes.SM_MagCannon_MagA", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_MagA");
	Template.AddDefaultAttachment('Reargrip',   "MagCannon.Meshes.SM_MagCannon_ReargripA");
	Template.AddDefaultAttachment('Foregrip', "MagCannon.Meshes.SM_MagCannon_StockA", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_StockA");
	Template.AddDefaultAttachment('Trigger', "MagCannon.Meshes.SM_MagCannon_TriggerA", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.UpgradeItem = 'Cannon_BM_Silent';

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Cannon_BeamSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Cannon_BM_Silent');
	Template.WeaponPanelImage = "_BeamCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = 5;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = default.LMG_BEAM_BASEDAMAGE;
	Template.Aim = default.LMG_BEAM_AIM;
	Template.CritChance = default.LMG_BEAM_CRITCHANCE;
	Template.iClipSize = default.LMG_BEAM_ICLIPSIZE;
	Template.iSoundRange = default.LMG_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LMG_BEAM_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Cannon_BM.WP_Cannon_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', "BeamCannon.Meshes.SM_BeamCannon_MagA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_MagA");
	Template.AddDefaultAttachment('Core', "BeamCannon.Meshes.SM_BeamCannon_CoreA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_CoreA");
	Template.AddDefaultAttachment('Core_Center',"BeamCannon.Meshes.SM_BeamCannon_CoreA_Center");
	Template.AddDefaultAttachment('HeatSink', "BeamCannon.Meshes.SM_BeamCannon_HeatSinkA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_HeatsinkA");
	Template.AddDefaultAttachment('Suppressor', "BeamCannon.Meshes.SM_BeamCannon_SuppressorA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_SupressorA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

// **************************************************************************
// ***                       Sniper Rifle                                 ***
// **************************************************************************

static function X2DataTemplate CreateTemplate_SniperRifle_ConventionalSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SniperRifle_CV_Silent');
	Template.WeaponPanelImage = "_ConventionalSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSniper.ConvSniper_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.SNIPERRIFLE_CONVENTIONAL_BASEDAMAGE;
	Template.Aim = default.SNIPERRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = default.SNIPERRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.SNIPERRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = default.SNIPERRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.SNIPERRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 1;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SniperRifle_CV.WP_SniperRifle_CV";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "ConvSniper.Meshes.SM_ConvSniper_MagA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_MagA");
	Template.AddDefaultAttachment('Optic', "ConvSniper.Meshes.SM_ConvSniper_OpticA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_OpticA");
	Template.AddDefaultAttachment('Reargrip', "ConvSniper.Meshes.SM_ConvSniper_ReargripA" /*REARGRIP INCLUDED IN TRIGGER IMAGE*/);
	Template.AddDefaultAttachment('Stock', "ConvSniper.Meshes.SM_ConvSniper_StockA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_StockA");
	Template.AddDefaultAttachment('Suppressor', "ConvSniper.Meshes.SM_ConvSniper_SuppressorA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "ConvSniper.Meshes.SM_ConvSniper_TriggerA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.UpgradeItem = 'SniperRifle_MG_Silent';

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_SniperRifle_MagneticSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SniperRifle_MG_Silent');
	Template.WeaponPanelImage = "_MagneticSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.UI_MagSniper.MagSniper_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 3;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_MAGNETIC_RANGE;
	Template.BaseDamage = default.SNIPERRIFLE_MAGNETIC_BASEDAMAGE;
	Template.Aim = default.SNIPERRIFLE_MAGNETIC_AIM;
	Template.CritChance = default.SNIPERRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.SNIPERRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.SNIPERRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.SNIPERRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SniperRifle_MG.WP_SniperRifle_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "MagSniper.Meshes.SM_MagSniper_MagA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_MagA");
	Template.AddDefaultAttachment('Optic', "MagSniper.Meshes.SM_MagSniper_OpticA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_OpticA");
	Template.AddDefaultAttachment('Reargrip',   "MagSniper.Meshes.SM_MagSniper_ReargripA" /* image included in TriggerA */);
	Template.AddDefaultAttachment('Stock', "MagSniper.Meshes.SM_MagSniper_StockA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_StockA");
	Template.AddDefaultAttachment('Suppressor', "MagSniper.Meshes.SM_MagSniper_SuppressorA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "MagSniper.Meshes.SM_MagSniper_TriggerA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.UpgradeItem = 'SniperRifle_BM_Silent';

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_SniperRifle_BeamSilent()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SniperRifle_BM_Silent');
	Template.WeaponPanelImage = "_BeamSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = 5;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_BEAM_RANGE;
	Template.BaseDamage = default.SNIPERRIFLE_BEAM_BASEDAMAGE;
	Template.Aim = default.SNIPERRIFLE_BEAM_AIM;
	Template.CritChance = default.SNIPERRIFLE_BEAM_CRITCHANCE;
	Template.iClipSize = default.SNIPERRIFLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = default.SNIPERRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.SNIPERRIFLE_BEAM_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.iTypicalActionCost = 2;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SniperRifle_BM.WP_SniperRifle_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_OpticA");
	Template.AddDefaultAttachment('Mag', "BeamSniper.Meshes.SM_BeamSniper_MagA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_MagA");
	Template.AddDefaultAttachment('Suppressor', "BeamSniper.Meshes.SM_BeamSniper_SuppressorA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_SupressorA");
	Template.AddDefaultAttachment('Core', "BeamSniper.Meshes.SM_BeamSniper_CoreA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_CoreA");
	Template.AddDefaultAttachment('HeatSink', "BeamSniper.Meshes.SM_BeamSniper_HeatSinkA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_HeatsinkA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateGhostGrenade()
{
	local X2GrenadeTemplate Template;
	local X2Effect_StealthyGear WeaponEffect;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'GhostGrenade');

	Template.WeaponCat = 'utility';
	Template.ItemCat = 'utility';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Smoke_Grenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_smoke");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_smoke");
	
	Template.iRange = default.GHOSTGRENADE_RANGE;
	Template.iRadius = default.GHOSTGRENADE_RADIUS;

	Template.iSoundRange = default.GHOSTGRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.GHOSTGRENADE_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = 7;
	Template.PointsToComplete = default.GHOSTGRENADE_IPOINTS;
	Template.iClipSize = default.GHOSTGRENADE_ICLIPSIZE;
	Template.Tier = 0;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.bFriendlyFireWarning = false;

	WeaponEffect = new class'X2Effect_StealthyGear';
	WeaponEffect.BuildPersistentEffect(default.GhostGrenade_Stealth_Duration, false, false, false, eGameRule_PlayerTurnBegin);
	WeaponEffect.AddPersistentStatChange(eStat_DetectionModifier,1);
	Template.ThrownGrenadeEffects.AddItem(WeaponEffect);
	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;

	Template.GameArchetype = "WP_Grenade_Smoke.WP_Grenade_Smoke";

	Template.CanBeBuilt = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 25;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Soldier Bark
	Template.OnThrowBarkSoundCue = 'ThrowGrenade';
	
	Template.RewardDecks.AddItem('ExperimentalGrenadeRewards');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.GHOSTGRENADE_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.GHOSTGRENADE_RADIUS);

	return Template;
}