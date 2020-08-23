#pragma semicolon 1
#pragma newdecls required
#include <sdktools>
#include <sdkhooks>
#include <fpvm_interface>
#include <zombieplague>

public void OnPluginStart()
{
	HookEvent("round_start", Event_OnRoundStart);	
}

public void OnMapStart()
{
	PrecacheModel("models/weapons/cso/sfsword/v_sfsword2.mdl", true);
	PrecacheModel("models/weapons/cso/hammer/v_hammer2.mdl", true);
	PrecacheModel("models/weapons/cso/skullaxe/v_skullaxe2.mdl", true);
}

public Action Event_OnRoundStart(Event event, const char[] name, bool dbc)
{
	for (int i = 1; i <= MaxClients; ++i)
	{
		if(IsClientConnected(i) && IsClientInGame(i) && !IsClientSourceTV(i)  && IsPlayerAlive(i))
		{
			weapo(i);
		}
	}
}

public Action weapo(int iClient)
{
	Menu hMenu = new Menu(MenuHandler_MyMenu, MenuAction_Select|MenuAction_Cancel);
	hMenu.SetTitle("Выберите оружие");
	hMenu.AddItem("item1", "Ак 47");
	hMenu.AddItem("item2", "М4А1");
	hMenu.AddItem("item3", "М4А1 Silelncer");
	hMenu.Display(iClient, 6);
}

public Action pisto(int iClient)
{
	Menu pMenu = new Menu(Menu_Weap, MenuAction_Select|MenuAction_Cancel);
	pMenu.SetTitle("Выберите оружие");
	pMenu.AddItem("item1", "Glock");
	pMenu.AddItem("item2", "Deagle");
	pMenu.AddItem("item3", "Usp-s");
	pMenu.Display(iClient, 6);
}

public Action knifik(int iClient)
{
	Menu tMenu = new Menu(Menu_KnifeCh, MenuAction_Select|MenuAction_Cancel);
	tMenu.SetTitle("Выберите нож");
	tMenu.AddItem("item2", "Световой[VIP]");
	tMenu.AddItem("item3", "Хаммер[Admin]");
	tMenu.AddItem("item4", "Топор[Boss]");
	tMenu.Display(iClient, 6);
}

public int MenuHandler_MyMenu(Menu hMenu, MenuAction action, int iClient, int iItem)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			if(IsClientConnected(iClient) && IsClientInGame(iClient) && IsPlayerAlive(iClient) && !IsClientSourceTV(iClient))
			{
				if(iItem == 0)
				{
					ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("ak47"));
					pisto(iClient);
				}

				else if(iItem == 1)
				{
					ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("m4a4"));
					pisto(iClient);
				}

				else if(iItem == 2)
				{
					ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("m4a1"));
					pisto(iClient);
				}
			}
		}

		case MenuAction_End:
		{
			delete hMenu;
		}  
	}
	return 0;
}

public int Menu_Weap(Menu pMenu, MenuAction action, int iClient, int iItem)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			if(IsClientConnected(iClient) && IsClientInGame(iClient) && IsPlayerAlive(iClient) && !IsClientSourceTV(iClient))
			{
				if(iItem == 0)
				{
					ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("glock"));
					if(GetAdminFlag(GetUserAdmin(iClient), Admin_Generic, Access_Effective) || GetAdminFlag(GetUserAdmin(iClient), Admin_Custom1, Access_Effective) || GetAdminFlag(GetUserAdmin(iClient), Admin_Custom6, Access_Effective))
					{
						knifik(iClient);
					}
				}

				else if(iItem == 1)
				{
					ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("deagle"));
					if(GetAdminFlag(GetUserAdmin(iClient), Admin_Generic, Access_Effective) || GetAdminFlag(GetUserAdmin(iClient), Admin_Custom1, Access_Effective) || GetAdminFlag(GetUserAdmin(iClient), Admin_Custom6, Access_Effective))
					{
						knifik(iClient);
					}
				}

				else if(iItem == 2)
				{
					ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("usp"));
					if(GetAdminFlag(GetUserAdmin(iClient), Admin_Generic, Access_Effective) || GetAdminFlag(GetUserAdmin(iClient), Admin_Custom1, Access_Effective) || GetAdminFlag(GetUserAdmin(iClient), Admin_Custom6, Access_Effective))
					{
						knifik(iClient);
					}
				}
			}
		}

		case MenuAction_End:
		{
			delete pMenu;
		}  
	}

	return 0;
}


public int Menu_KnifeCh(Menu tMenu, MenuAction action, int iClient, int pynkt)
{
	switch(action)
	{
		case MenuAction_Select:
		{
			if(pynkt == 0 && GetAdminFlag(GetUserAdmin(iClient), Admin_Custom1, Access_Effective))
			{
				ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("sfsword"));
			}
		
			else if(pynkt == 1 && GetAdminFlag(GetUserAdmin(iClient), Admin_Generic, Access_Effective))
			{
				ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("big hammer"));
			}

			else if(pynkt == 2 && GetAdminFlag(GetUserAdmin(iClient), Admin_Custom6, Access_Effective))
			{
				ZP_GiveClientWeapon(iClient, ZP_GetWeaponNameID("skullaxe"));
			}
		}
		
		case MenuAction_End:
		{
			delete tMenu;
		}   
	}

	return 0;
}
