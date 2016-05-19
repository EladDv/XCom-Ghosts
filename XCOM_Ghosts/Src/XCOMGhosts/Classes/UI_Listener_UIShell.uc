// This is an Unreal Script

class UI_Listener_UIShell extends UIScreenListener config(StealthSettings);

var config float FieldOfVesion;

event OnInit(UIScreen Screen)
{
	local Object ThisObj;
	local X2CharacterTemplateManager CTM;
	local X2DataTemplate Template;
	local X2CharacterTemplate CharacterTemplate,TempTemplate;
	local array<X2DataTemplate> CharacterTemplates;
	local int i;
	if(Screen.isA('UIShell')&&1==0)
	{
		ThisObj=self;
		CTM= class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
		foreach CTM.IterateTemplates(Template, none)
		{
			CharacterTemplates.Length=0;
			CharacterTemplate = X2CharacterTemplate(Template);
			if(CharacterTemplate!=none)
			{
				CTM.FindDataTemplateAllDifficulties(CharacterTemplate.DataName,CharacterTemplates);
				For(i=0;i<CharacterTemplates.Length;i++)
				{
					TempTemplate=X2CharacterTemplate(CharacterTemplates[i]);
					if((!TempTemplate.bIsRobotic && !TempTemplate.bIsSoldier )&&(TempTemplate.bIsAlien||TempTemplate.bIsAdvent))
					{
						TempTemplate.VisionArcDegrees=5.0f;
						`log("Changed Template FoV"@TempTemplate.DataName);
					}
				}
			}		
		}
	}
}

defaultproperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	FieldOfVesion=10.0f;
	ScreenClass=none;
}	 