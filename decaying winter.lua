if game.PlaceId ~= 7551121821 and game.PlaceId ~= 9880062154 then
    return
end
if _G.Injected ~= nil then
    return
else
    _G.Injected = true
end
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local UserInputService = game:GetService("UserInputService")
local namecall
local newindex
if Player == nil then
    game.Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    Player = game.Players.LocalPlayer
end
if Camera == nil then
    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Wait()
    Camera = game.Workspace.CurrentCamera
end
local Mouse = Player:GetMouse()
game.StarterGui:SetCore("SendNotification", {
    Title = 'LOADING';
    Text = "Loading script. Enter a round to fully load.";
    Icon = "rbxassetid://2541869220";
    Duration = 7;
})

local ActivePlayers = game:GetService("Workspace"):WaitForChild("activePlayers",10000)
local ServerStuff = game:GetService("Workspace"):WaitForChild("ServerStuff",10000)
local Statistics = ServerStuff:WaitForChild("Statistics",10000)

local Toggles = {
    Godmode = false;
    SemiGodmode = false;
    InfRun = true;
    AntiDebuff = false;
    Dispenser = false;
    NoCooldown = false;
    GrabAmmo = false;
    VirusBlock = false;
    OneShot = false;
    SilentAim = false;
    InfAmmo = false;
    InfClip = false;
    AntiRecoil = false;
    AntiFallDamage = false;
    SuperRun = false;
    NoHunger = false;
    AutoParry = false;
    KillAura = false;
    AutoKill = false;
    GrenadeRain = false;
    InfAux = false;
    LoopDrop = false;
    ThrowingKnives = false;
    AntiVoteKick = false;
    LockCamera = false;
    InfStamina = false;
    AutoFarm = false;
    AntiSpread = false;
    Stealth = false;
    ControlMode = false;
    NoFog = false;
}

local Debounces = {
    Dispensing = false;
    Killing = false;
    Trap = false;
    LoopDrop = false;
    Throwing = false;
}

local Variables = {
    -- Tracking --

    CurrentWeapon = "";
    ShownWeapon = "Fist";
    CurrentTrap = "Proximity Mine";
    CurrentThrowable = "TKnife";
    ToLoopDrop = "";
    PreviousClass = "revolver";

    -- Values --

    KillAuraDistance = 30;

    -- Connections --
    RenderStepConnection = nil;
    HealthChangedConnection = nil;
    AttackedConnection = nil;

    -- Objects --

    ClipLabel = nil;
    VirusFrame = nil;
    
}

local Esp = {
    EspObjects = {
        Enemies = {};
        Demons = {};

        Guns = {};
        Melee = {};
        Ammo = {};
        Traps = {};
        BodyArmor = {};
        Backpacks = {};
        Throwable = {};
        Health = {};
        Stims = {};
        Blueprints = {};

        Crate = {};
        Workbench = {};
        Scrapper = {};
        Locker = {};
        ["Medical Cabinet"] = {};
    };
    EspInfo = {
        Toggles = {
            Enemies = false;
            Demons = true;

            Guns = true;
            Melee = false;
            Ammo = false;
            Traps = false;
            BodyArmor = false;
            Backpacks = true;
            Throwable = false;
            Health = false;
            Stims = false;
            Blueprints = false;

            Crate = true;
            Workbench = true;
            Scrapper = false;
            Locker = false;
            ["Medical Cabinet"] = false;
        };

        Scavs = {

            ------------ MELEE SCAVS ------------

            ScavMeleeA = {
                img = 7841679252;
                desc = "ice axe scav";
                subtext = "MELEE";
            };
            ScavMeleeB = {
                img = 7841677917;
                desc = "combat knife scav";
                subtext = "MELEE";
            };
            ScavMeleeC = {
                img = 7841680342;
                desc = "lead pip scav";
                subtext = "MELEE";
            };
            ScavMeleeD = {
                img = 7841678596;
                desc = "crow bar scav";
                subtext = "MELEE";
            };
            ScavMeleeE = {
                img = 7841680966;
                desc = "karambit scav";
                subtext = "MELEE";
            };
            ScavMeleeF = {
                img = 7841677017;
                desc = "boar spear scav";
                subtext = "MELEE";
            };

            ------------ PISTOL SCAVS ------------

            ScavPistolA = {
                img = 7841738039;
                desc = "22 LR broomhandle scav";
                subtext = "PISTOL";
            };
            ScavPistolB = {
                img = 7841738562;
                desc = "m1911 scav";
                subtext = "PISTOL";
            };
            ScavPistolC = {
                img = 7841739010;
                desc = "ruger scav";
                subtext = "PISTOL";
            };

            ------------ AUTOM SCAVS ------------

            ScavSMGA = {
                img = 7841760841;
                desc = "smg scav";
                subtext = "AUTOMATIC";
            };
            ScavSMGB = {
                img = 7841760841;
                desc = "smg scav";
                subtext = "AUTOMATIC";
            };
            ScavAKA = {
                img = 7841761784;
                desc = "ak scav";
                subtext = "AUTOMATIC";
            };
            ScavAKB = {
                img = 7841761784;
                desc = "ak scav";
                subtext = "AUTOMATIC";
            };

            ----------- SHOTTY SCAVS -----------

            ScavDoubleBarrel = {
                img = 7841821770;
                desc = "double barrel scav";
                subtext = "SHOTGUN";
            };
            ScavShotgun = {
                img = 7841833207;
                desc = "model 870 scavenger";
                subtext = "SHOTGUN";
            };

            ----------- RIFLE SCAVS ------------

            ScavSniper = {
                img = 7841872755;
                desc = "remington scav";
                subtext = "MARKSMAN";
            };
            ScavHenry = {
                img = 7841873513;
                desc = "winchester scav";
                subtext = "MARKSMAN";
            };

            --------- BOSS WAVE SCAVS ----------

            BossScav = {
                img = 7841904249;
                desc = "boss scav";
                subtext = "KILL";
            };
            BossScavGuard = {
                img = 7841903504;
                desc = "boss scav guard";
                subtext = "GUARD";
            };

            ------------ SHADOWS ------------

            ShadowHidden = {
                img = 7842766024;
                desc = "hidden demon";
                subtext = "DEMON";
                subtextcolor = Color3.fromRGB(0,0,0);
            };
            ShadowSkinnerA = {
                img = 7842771883;
                desc = "skinner demon";
                subtext = "DEMON";
                subtextcolor = Color3.fromRGB(0,0,0);
            };
            ShadowSkinnerB = {
                img = 7842767367;
                desc = "skinner demon";
                subtext = "DEMON";
                subtextcolor = Color3.fromRGB(0,0,0);
            };
            ShadowSkinnerC = {
                img = 7842771883;
                desc = "skinner demon";
                subtext = "DEMON";
                subtextcolor = Color3.fromRGB(0,0,0);
            };
            ShadowSkinnerD = {
                img = 7842767367;
                desc = "skinner demon";
                subtext = "DEMON";
                subtextcolor = Color3.fromRGB(0,0,0);
            };
            ShadowSickler = {
                img = 7842766888;
                desc = "sickler demon";
                subtext = "DEMON";
                subtextcolor = Color3.fromRGB(0,0,0);
            };
            ShadowHanger = {
                img = 7842765069;
                desc = "hanger demon";
                subtext = "DEMON";
                subtextcolor = Color3.fromRGB(0,0,0);
            };
        };

        Interactables = {
            Crate = {
                img = 7841194630;
            };
            Workbench = {
                img = 7841197317;
            };
            Scrapper = {
                img = 7841196664;
            };
            Locker = {
                img = 7841195140;
            };
            ["Medical Cabinet"] = {
                img = 7841195738;
            };
        };

        Items = {
            Guns = {
                img = 7843043692;
            };
            Melee = {
                img = 7843044421;
            };
            Ammo = {
                img = 7843046990;
            };
            Backpack = {
                img = 7843047903;
            };
            Placeable = {
                img = 7843048761;
            };
            BodyArmor = {
                img = 7843049470;
            };
            Throwable = {
                img = 7843050297;
            };
            Health = {
                img = 7843627206;
            };
            Stims = {
                img = 7843626657;
            };
            Blueprints = {
                img = 7843630409;
            };
        };
    };
}

local Tables = {
    Stats = {
        WeaponStats = require(Statistics:WaitForChild("W_STATISTICS",20));
        ClassStats = require(Statistics:WaitForChild("CLASS_STATISTICS",20));
        StatusStats = require(Statistics:WaitForChild("S_STATISTICS",20));
    };
    OriginalStats = {};
    SuperRun = {
        WHeld = false;
        SHeld = false;
        AHeld = false;
        DHeld = false;
        ShiftHeld = false;
        RunSpeed = 1;
    };
    ControlMode = {
        DragStart = CFrame.new(0,0,0);
        OriginalCameraCFrame = CFrame.new(0,0,0);
        MoveNPCsTo = Vector3.new(0,0,0);
        SelectedNPCs = {};
        NPCHighlights = Instance.new("Folder");
        RTSPartHolder = Instance.new("Folder");
        CameraIncrements = {
            ["Enum.KeyCode.W"] = Vector3.new(0,0,-1);
            ["Enum.KeyCode.A"] = Vector3.new(-1.5,0,0);
            ["Enum.KeyCode.S"] = Vector3.new(0,0,1);
            ["Enum.KeyCode.D"] = Vector3.new(1.5,0,0);
            ["Enum.KeyCode.Q"] = Vector3.new(0,1,0);
            ["Enum.KeyCode.E"] = Vector3.new(0,-1,0);
        };
    };
    Conversions = {
        TrapToItemName = {
            ["Steel Punjis"] = "PTrap";
            ["Steel Snares"] = "SSnare";
            ["Proximity Mine"] = "PMine";
            ["Remote Explosives"] = "RExplosive";
            ["Crafted Pavise"] = "CRPavise";
        };
        NameToStat = {
          
            ------- GUNS -------

            ["LIMB_LETHALITY"] = {
                Stat = "damagerating";
                Index = 3;
                Increment = 5;
            };
            ["HEADSHOT_LEHTALITY"] = {
                Stat = "damagerating";
                Index = 4;
                Increment = 5;
            };
            ["ROUNDS_PER_MINUTE"] = {
                Stat = "speedrating";
                Increment = -0.01;
                BigIncrement = -0.1;
            };
            ["EFFECTIVE_RECOIL"] = {
                Stat = "woundrating";
                Increment = 2;
                BigIncrement = 20;
            };
            ["FIREARM_INACCURACY"] = {
                Stat = "sizerating";
                Increment = -1;
                BigIncrement = -10;
            };

            ------- MELEE ------

            ["LETHALITY"] = {
                Stat = "damagerating";
                Index = 1;
                Increment = 5;
            };
            ["STRIKE_LETHALITY"] = {
                Stat = "damagerating";
                Index = 2;
                Increment = 5;
            };
            ["WEIGHT_LIGHT_SWING"] = {
                Stat = "speedrating";
                Increment = 1;
            };
            ["WEIGHT_HEAVY_SWING"] = {
                Stat = "chargerating";
                Increment = 0;
            };
            ["EFFECTIVE_RANGE"] = {
                Stat = "sizerating";
                Increment = 1;
            };
            ["WOUNDING_LEVEL"] = {
                Stat = "woundrating";
                Increment = 1;
            };


            ------- MISC -------

            ["LIMB_DAMAGE"] = {
                Stat = "damagerating";
                Increment = 5;
                BigIncrement = 50;
            };
            ["HEAD_DAMAGE"] = {
                Stat = "damagerating";
                Increment = 5;
                BigIncrement = 50;
            };
            ["SPEED_RATING"] = {
                Stat = "speedrating";
                Increment = 1;
            };
            ["CHARGE_RATING"] = {
                Stat = "chargerating";
                Increment = 1;
            };
            ["WOUND_RATING"] = {
                Stat = "woundrating";
                Increment = 2;
            };
            ["SIZE_RATING"] = {
                Stat = "sizerating";
                Increment = 1;
            };
            ["THROW_RATING"] = {
                Stat = "throwrating";
                Increment = 1;
            };
        }
    };
    Lists = {
        DamageTypes = {"burning","bleed","toxicated","sepsis"};
        LoopedFeatures = {"KillAura","GrenadeRain","SuperRun","LoopDrop","AntiVoteKick","ControlMode"};
        GuiCommands = {"InfClip","InfAmmo","Godmode","InfStamina","OneShot","TeamKill","NoCooldown","InfAux","SilentAim","KillAura","VirusBlock","AntiDebuff","NoHunger","Stealth","AntiFallDamage","AntiRecoil","AntiSpread","SuperRun","ControlMode"};
        Traps = {
            ["Steel Punjis"] = "Steel Punjis";
            ["Punjis"] = "Steel Punjis";
            ["Steel Snares"] = "Steel Snares";
            ["Snares"] = "Steel Snares";
            ["Proximity Mine"] = "Proximity Mine";
            ["Mines"] = "Proximity Mine";
            ["Landmines"] = "Proximity Mine";
            ["Remote Explosives"] = "Remote Explosive";
            ["C4"] = "Remote Explosive";
            ["Crafted Pavise"] = "Crafted Pavise";
            ["Pavise"] = "Crafted Pavise";
            ["Barrier"] = "Crafted Pavise";
            ["Wall"] = "Crafted Pavise";
            ["Blockade"] = "Crafted Pavise";
            ["Wood Barrier"] = "Crafted Pavise";
        };
        Throwables = {
            ["Knives"] = "TKnife";
            ["Throwing Knives"] = "TKnife";
            ["Knife"] = "TKnife";
            ["Dynamite"] = "Dynamite";
            ["TNT"] = "Dynamite";
            ["Bundle of Dynamite"] = "Dynamite";
            ["Molotovs"] = "Molo";
            ["Molly"] = "Molo";
            ["Fire bomb"] = "Molo";
            ["Molotov Cocktail"] = "Molo";
            ["Bottle"] = "Molo";
            ["Grenade"] = "MGrenade";
            ["M67 Grenade"] = "MGrenade";
            ["Frag Grenade"] = "MGrenade";
            ["Impact Grenade"] = "ImpN";
            ["Touch Grenade"] = "ImpN";
            ["Bomb Spear"] = "CRBSpear";
            ["Spear"] = "CRBSpear";
            ["Hot Dog"] = "CRBSpear";
            ["HotDog"] = "CRBSpear";
            ["Caltrops"] = "TCaltrop";
            ["Spikes"] = "TCaltrop";
            ["Throwing Axe"] = "TAxe";
            ["Axe"] = "TAxe";
            ["Hatchet"] = "TAxe";
            ["Nothing"] = "Nothing";
            ["Nil"] = "Nothing";
            ["N/A"] = "Nothing";
            [""] = "Nothing";
            ["Air"] = "Nothing";
            ["Disable"] = "Nothing";
        };
        Weapons = {
            ["peacemaker"] = "RVolver";
            ["Caltrops"] = "TCaltrop";
            ["Alarm Gun"] = "AlrGun";
            ["Pickaxe"] = "PAxe";
            ["STI DVC Limited Custom"] = "STIPistol";
            ["Limited Custom"] = "STIPistol";
            ["Custom"] = "STIPistol";
            ["High Cappa"] = "STIPistol";
            ["Crafted Pavise"] = "CRPavise";
            ["Pavise"] = "CRPavise";
            ["Barricade"] = "CRPavise";
            ["Wall"] = "CRPavise";
            ["HighCappa"] = "STIPistol";
            ["Extendo"] = "STIPistol";
            ["Hunting Axe"] = "TAxe";
            ["Splitting Axe"] = "SAxe";
            ["Pitchfork"] = "PFork";
            ["Remington 700"] = "HuntingR";
            ["Opposers Flagpole"] = "EFlag";
            ["Fire Axe"] = "FAxe";
            ["Ruger LCP"] = "Ruger";
            ["Company Flagpole"] = "CFlag";
            ["Flagpole"] = "CFlag";
            ["Flagpole2"] = "EFlag";
            ["Throwing Javelin"] = "TJavelin";
            ["M1911A1"] = "MPistol";
            ["First Aid Kit"] = "MAid";
            ["Pavise"] = "CRPavise";
            ["Impact Grenade"] = "ImpN";
            ["Baseball Bat"] = "BBat";
            ["Bat"] = "BBat";
            ["Cleaver"] = "CCleaver";
            ["Berserk Injector"] = "BInjector";
            ["Stone Rock"] = "CRStone";
            ["Kel-Tec KSG"] = "KSG";
            ["KSG"] = "KSG";
            ["Bomb Spear"] = "CRBSpear";
            ["Hot Dog"] = "CRBSpear";
            ["HotDog"] = "CRBSpear";
            ["Kitchen Knife"] = "KitKnife";
            ["M60-E6"] = "SubLMG";
            ["OLDLMG"] = "SubLMG";
            ["OLD LMG"] = "SubLMG";
            ["Crafted Spear"] = "CRSpear";
            ["Pepper Spray"] = "PSpray";
            ["Lameo-Blade"] = "Hyperlame";
            ["Crafted Caltrops"] = "CRCaltrop";
            ["Handheld Radio"] = "RDio";
            ["Radio"] = "RDio";
            ["Model 6 Unica"] = "Mateba";
            ["Unica"] = "Mateba";
            ["Broken Tracker"] = "PScanner";
            ["Tracker"] = "PScanner";
            ["AS Val"] = "ASVal";
            ["Val"] = "ASVal";
            ["Wood Branch"] = "CRBranch";
            ["Branch"] = "CRBranch";
            ["Police Baton"] = "PBaton";
            ["Dolch 96"] = "Mauser";
            ["Mauser"] = "Mauser";
            ["Frying Pan"] = "FPan";
            ["Pan"] = "FPan";
            ["Specialist Knife"] = "KaramB";
            ["Karambit"] = "KaramB";
            ["Winchester 940-1"] = "HRifle";
            ["MCX VIRTUS"] = "SubMCX";
            ["VIRTUS"] = "SubMCX";
            ["Lead Pipe"] = "LPipe";
            ["Pipe"] = "LPipe";
            ["AK-74"] = "SubAK";
            ["AK 74"] = "SubAK";
            ["AK74"] = "SubAK";
            ["AK-47"] = "SubAK";
            ["AK 47"] = "SubAK";
            ["AK47"] = "SubAK";
            ["FN SCAR-H"] = "SubScar";
            ["SCAR-H"] = "SubScar";
            ["Estoc"] = "ESword";
            ["Polters Last Breath"] = "GhostBomb";
            ["GhostBomb"] = "GhostBomb";
            ["Great Sword"] = "GSword";
            ["Shadow Claws"] = "SClaw";
            ["Claws"] = "SClaw";
            ["Wakizashi"] = "NSword";
            ["Short Sword"] = "SSword";
            ["Sword"] = "SSword";
            ["Augmentin Antibiotics"] = "IbuP";
            ["Antibiotics"] = "IbuP";
            ["H&K MP5A3"] = "SubMP";
            ["MP5A3"] = "SubMP";
            ["Construction Hammer"] = "CHammer";
            ["Hammer"] = "CHammer";
            ["Throwing Knife"] = "TKnife";
            ["Rigged Detonator"] = "CRRiggedE";
            ["Detonator"] = "CRRiggedE";
            ["M14 EBR"] = "EBR";
            ["EBR"] = "EBR";
            ["Crude Bandage"] = "CRBandage";
            ["Commissioned Musket"] = "MusketR";
            ["Musket"] = "MusketR";
            ["Tactical Spear"] = "TSpear";
            ["Smoke Launcher"] = "SLauncher";
            ["Remote Explosive"] = "RExplosive";
            ["C4"] = "RExplosive";
            [".22 Broomhandle"] = "Pistol";
            ["Broomhandle"] = "Pistol";
            ["Modded AKM"] = "SUPAK";
            ["AKM"] = "SUPAK";
            ["Punjis"] = "PTrap";
            ["Combat Knife"] = "CKnife";
            ["Caldwell 940"] = "DoubleShotgun";
            ["940"] = "DoubleShotgun";
            ["Double Barrel"] = "DoubleShotgun";
            ["DoubleBarrel"] = "DoubleShotgun";
            ["Snares"] = "SSnare";
            ["Crafted Quiver"] = "CRQuiver";
            ["Tomahawk"] = "THawk";
            ["R11 RSASS"] = "RSASS";
            ["FAMAS F1"] = "FAMAS";
            ["Airdrop Flare"] = "Flare";
            ["Proximity Mine"] = "PMine";
            ["Mine"] = "PMine";
            ["Emergency Airdrop Flare"] = "EFlare";
            ["Alarming Gun"] = "VAlrGun";
            ["Dynamite"] = "Dynamite";
            ["Immobilising Splint"] = "Splint";
            ["Splint"] = "Splint";
            ["Esmarch Tourniquet"] = "Tourni";
            ["Tourniquet"] = "Tourni";
            ["Javelin"] = "CRJavelin";
            ["Scissors"] = "SCKnife";
            ["Modded Rifle"] = "Rifle";
            ["Rifle"] = "Rifle";
            ["Advanced IFAK"] = "FAid";
            ["IFAK"] = "FAid";
            ["Firerier Axe"] = "DFAxe";
            ["Tactical Armour"] = "APack";
            ["Armour"] = "APack";
            ["Armor"] = "APack";
            ["Vest"] = "APack";
            ["Kevlar"] = "APack";
            ["Crafted Knife"] = "CRKnife";
            ["Rake"] = "Rake";
            ["Yari"] = "Yari";
            ["Modded Pistol"] = "SUPMPistol";
            ["Backpack"] = "BPack";
            ["Model 870"] = "MShotgun";
            ["Decommissioned Musket"] = "DMusket";
            ["Musket2"] = "DMusket";
            ["MVD KS-23"] = "KShotgun";
            ["KS-23"] = "KShotgun";
            ["Military Axe"] = "MilAxe";
            ["Pizza Cutter"] = "PCutter";
            ["Boar Spear"] = "BSpear";
            ["Riot Grenade"] = "TGas";
            ["Hidden Knife"] = "HKnife";
            ["S44-UL1"] = "SPDStim";
            ["Speed Stimpak"] = "SPDStim";
            ["Blue Stimpak"] = "SPDStim";
            ["Peacemaker Chain"] = "CRVolver";
            ["Chain"] = "CRVolver";
            ["Cudgel"] = "CRCudgel";
            ["Stone Scrap"] = "CRStoneS";
            ["The Redeemer"] = "MRVolver";
            ["Redeemer"] = "MRVolver";
            ["Artisans Hook"] = "BHook";
            ["Halberd"] = "HBerd";
            ["Poisoned Knife"] = "PKnife";
            ["Executioner Sword"] = "ExecSword";
            ["Recurve Bow"] = "RBow";
            ["Amoxicillin Tablets"] = "PKillers";
            ["Ingram MAC-10"] = "Mac";
            ["MAC-10"] = "Mac";
            ["MAC10"] = "Mac";
            ["MAC-11"] = "Mac";
            ["MAC11"] = "Mac";
            ["Peacemaker Uppercut"] = "URVolver";
            ["Fire Bomb"] = "Molo";
            ["Molotov"] = "Molo";
            ["The Bad Business"] = "BadBat";
            ["Bad Business"] = "BadBat";
            ["Compound Z"] = "SPCStim";
            ["Black Tar Heroin"] = "SPCStim";
            ["Black Stimpack"] = "SPCStim";
            ["Crowbar"] = "CBar";
            ["I4S-DS"] = "DEFStim";
            ["Regen Stimpak"] = "DEFStim";
            ["Green Stimpak"] = "DEFStim";
            ["3-(cbSTM)"] = "DStim";
            ["cbSTM"] = "DStim";
            ["Stamina Stimpak"] = "DStim";
            ["Purple Stimpak"] = "DStim";
            ["Cocktail Perithesene"] = "HStim";
            ["Perithesene"] = "HStim";
            ["Health Stimpak"] = "HStim";
            ["Full Heal Stimpak"] = "HStim";
            ["Red Stimpak"] = "HStim";
            ["Broken Taser"] = "Taser";
            ["Taser"] = "Taser";
            ["Compound MilBow"] = "CPBow";
            ["MilBow"] = "CPBow";
            ["Bow"] = "CPBow";
            ["M67 Grenade"] = "MGrenade";
            ["Grenade"] = "MGrenade";
            ["Frag Grenade"] = "MGrenade";
            ["A.J.M. 9"] = "AJM";
            ["AJM 9"] = "AJM";
            ["Aseptic Bandage"] = "ADBandage";
            ["Smoke Bomb"] = "CRSBomb";
            ["Shovel"] = "Shovel";
            ["Crafted Hatchet"] = "CRHatchet";
            ["Fists"] = "Fist";
            ["Maria"] = "NailedB";
            ["PGM FR-12.7"] = "AMR";
            ["Anti Material Rifle"] = "AMR";
            ["Anti-Material Rifle"] = "AMR";
            ["50 Caliber Rifle"] = "AMR";
            ["50-Caliber"] = "AMR";
            ["AMR"] = "AMR";
            ["Military Fork"] = "MFork";
            ["The Decimator"] = "RBHammer";
            ["Decimator"] = "RBHammer";
            ["Mark VII"] = "Deagle";
            ["Deagle"] = "Deagle";
            ["Karabiner 98k"] = "KarSniper";
            ["Ice Axe"] = "IPick";
            ["GhostKnife"] = "GhostKnife";
            ["Polters Last Wish"] = "GhostKnife";
            ["Caldwell Handcannon"] = "DBarrel";
            ["Handcannon"] = "DBarrel";
            ["Sawn Off"] = "DBarrel";
            ["SawnOff"] = "DBarrel";
            ["Sawn-Off"] = "DBarrel";
            ["Crafted Bow"] = "CRBow";
            ["SPAS-12"] = "SPShotgun";
            ["KRISS Vector"] = "SubVector";
            ["Vector"] = "SubVector";
            ["Rapier"] = "RPier";
            ["Pike"] = "PSpear";
            ["Brass Knuckles"] = "BKnuckles";
            ["Military Machete"] = "MMachete";
            ["M1891 Avtomat"] = "Avto";
            ["Avtomat"] = "Avto";
            ["Wood Scrap"] = "CRWoodS";
            ["Sledgehammer"] = "SHammer";
            ["Glock 17"] = "Glock";
            ["Crafted Backpack"] = "CRBPack";
            ["CBJ-MS PDW"] = "SubMG";
            ["PDW"] = "SubMG";
            ["Crafted Explosive"] = "CRNade";
            ["BL1 (Neloprephine)"] = "SStim";
            ["Neloprephine"] = "SStim";
            ["Heroin"] = "SStim";
            ["Orange Stimpack"] = "SStim";
            ["Morale Stimpack"] = "SStim";
            ["Used Stim"] = "TStim";
            ["Hemostatic Zanustin"] = "AdrStim";
            ["Adrenaline Stimpack"] = "AdrStim";
            ["Clear Stimpack"] = "AdrStim";
            ["Glass Stimpack"] = "AdrStim";
            ["Effect Stimpack"] = "AdrStim";
            ["Crafted Splint"] = "CRSplint";
            ["Theourgias Hand"] = "THand";
            ["THand"] = "THand";
            ["Hand"] = "THand";
            ["Crafted Punjis"] = "CRPTrap";
            ["Simonov SKS"] = "SKS";
            ["SKS"] = "SKS";
            ["H&K UMP45"] = "UMP";
            ["UMP45"] = "UMP";
            ["FN M249"] = "FNLMG";
            ["M249"] = "FNLMG";
            ["LMG2"] = "FNLMG";
            ["FNLMG"] = "FNLMG";
            ["FN P90 TR"] = "SubPS";
            ["P90 TR"] = "SubPS";
            ["SubPS "] = "SubPS";
            ["Benelli M4"] = "Benelli";
            ["Winchester 1901"] = "LeverShotgun";
            ["LeverShotgun"] = "LeverShotgun";
            ["Lever Shotgun"] = "LeverShotgun";
            ["IZhMASh SV-98M"] = "SUPSniper";
            ["SV-98M"] = "SUPSniper";
            ["SUPSniper"] = "SUPSniper";
            ["AI-AWSM"] = "AWMSniper";
            ["AWSM"] = "AWMSniper";
            ["AWMSniper"] = "AWMSniper";
            ["PPSh-41"] = "SubPP";
            ["Dragunov SVD-63"] = "SVD";
            ["SVD-63"] = "SVD";
            ["Atchisson AA-12"] = "AAShotgun";
            ["AA-12"] = "AAShotgun";
            ["ASh-12"] = "AshR";
            ["H&K MR308 A3"] = "HKMR";
            ["MR308 A3"] = "HKMR";
            ["HKMR"] = "HKMR";
            ["CheyTac M200"] = "IntSniper";
            ["M200"] = "IntSniper";
            ["1927A1 Deluxe"] = "TSMG";
            ["FN SCAR-L"] = "ScarL";
            ["SCARL"] = "ScarL";
            ["SCAR-L"] = "ScarL";
            ["H&K MP5/10"] = "MPTen";
            ["MP5/10"] = "MPTen";
            ["MP10"] = "MPTen";
            ["Skorpion vz. 61"] = "Scorp";
            ["Scorpion vz. 61"] = "Scorp";
            ["SIG MPX"] = "SubMPX";
            ["MPX"] = "SubMPX";
            ["SubMPX"] = "SubMPX";
            ["Container Zero"] = "AgentCD";
        };
    };
}

Tables.ControlMode.NPCHighlights.Parent = game.CoreGui
Tables.ControlMode.RTSPartHolder.Parent = game:GetService("ReplicatedStorage");

-- GUI STUFF --

local RTSGui = Instance.new("ScreenGui")
local Selection = Instance.new("Frame")
local ReturnButton = game:GetService("StarterGui"):WaitForChild("menuGui"):WaitForChild("home"):Clone()

RTSGui.Name = "RTSGui"
RTSGui.Parent = game.CoreGui
RTSGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Selection.Name = "Selection"
Selection.Parent = RTSGui
Selection.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
Selection.BackgroundTransparency = 0.900
Selection.BorderSizePixel = 2
Selection.Position = UDim2.new(0.457311928, 0, 0.437655866, 0)
Selection.Size = UDim2.new(0, 100, 0, 100)
Selection.Visible = false

ReturnButton.Parent = RTSGui
ReturnButton.Visible = false
ReturnButton.Position = UDim2.new(0.1825,0,0.9,0)

-- ESSENTIAL FUNCTIONS --

local function GrabMainScript()
    local Script = nil
    for i,v in pairs(Player.Backpack.GetChildren(Player.Backpack)) do
        if v:IsA("LocalScript") and v.Name ~= "ClickDetectorScript" then
            Script = v
        end
    end
    return Script
end;
local function GrabEssentials()
    local GlobalTable = getrenv()._G
    local TempEnv = getsenv(GrabMainScript())
    repeat
        GlobalTable = getrenv()._G
        TempEnv = getsenv(GrabMainScript())
        task.wait(0.3)
    until GlobalTable["keylist"] ~= nil and TempEnv["afflictstatus"] ~= nil and TempEnv["drop_slide"] ~= nil and TempEnv["start_dual_wield"] ~= nil
    if TempEnv["afflictstatus"] ~= nil then
        local upvalues = getupvalues(TempEnv.afflictstatus)
        for i,v in pairs(upvalues) do
            if _G.Code1 ~= nil then
                break
            end
            if typeof(v) == "number" then
                for x,y in pairs(GlobalTable) do
                    if y == v then
                        _G.Code1 = v
                        break
                    end
                end
            end
        end
        local CorrectIndex = math.huge
        for i,v in pairs(upvalues) do
            if v == _G.Code1 and tonumber(i) ~= nil then
                CorrectIndex = i + 1
            end
            if i == CorrectIndex then
                _G.Code2 = v
            end
        end
    end
    wait(0.2)
    if TempEnv["drop_slide"] ~= nil then
        for i,v in pairs(debug.getupvalues(TempEnv["drop_slide"])) do
            if typeof(v) == "table" then
                for x,y in pairs(v) do
                    if typeof(y) == "table" and y["effects"] ~= nil then
                        _G.EffectsTable = v
                        break
                    end
                end
            end
        end
    end
    if TempEnv["unloadgun"] ~= nil then
        for i,v in pairs(debug.getupvalues(TempEnv["unloadgun"])) do
            if typeof(v) == "table" and v["Light"] ~= nil then
                _G.AmmoTable = v
            end
        end
    end
    if TempEnv["ration_system_handler"] ~= nil then
        _G.FoodTable = TempEnv["ration_system_handler"]
    end
    if TempEnv["start_dual_wield"] ~= nil then
        local TempUpValues = getupvalues(TempEnv.start_dual_wield)
        for i,v in pairs(TempUpValues) do
            if typeof(v) == "table" and v[1] ~= nil and typeof(v[1]) == "table" and typeof(v[1][1]) == "string" and typeof(v[1][2]) == "boolean" then
                _G.InvTable = v
                break
            end
        end
    end
    TempEnv = nil
    GlobalTable = nil
end;
local function GetArgs(inputstring)
    inputstring = string.lower(inputstring)
    inputstring = string.gsub(inputstring, "'", "")
    inputstring = string.gsub(inputstring, ":", "")
    inputstring = string.gsub(inputstring, ";", "")
    inputstring = string.gsub(inputstring, "%.", "")
    inputstring = string.gsub(inputstring, "/e ", "")
    inputstring = string.gsub(inputstring, "/w ", "")
    local args = string.split(inputstring, " ")
    args.Command = args[1]
    table.remove(args, 1)
    return args
end;

-- FEATURE FUNCTIONS -- 

local function Heal()
    if Player.Character == nil or not Player.Character:FindFirstChild("Humanoid") or _G.Code1 == nil or _G.Code2 == nil then
        return
    end
    local Health = Player.Character.Humanoid.Health
    local MaxHealth = Player.Character.Humanoid.MaxHealth
    if Health < MaxHealth then
        for i = 1,(MaxHealth - Health) do
            game.Workspace.ServerStuff.dealDamage:FireServer("Regeneration", nil, _G.Code1, _G.Code2)
        end
    end
end;

local function KnifeKill(Model,UntilDeath)
    if Model.Parent ~= nil and Model.Parent.Name == "activeHostiles" or Model.Parent ~= nil and Model.Parent.Name == "NoTarget" then
        local TargetPart = Model:FindFirstChild("Torso") or Model:FindFirstChild("Head")
        if TargetPart == nil then
            return
        end
        if not Model:FindFirstChild("Humanoid") or Model.Humanoid.Health <= 0 then
            return
        end
        local Data = Tables.Stats.WeaponStats["TKnife"]
        local Position = CFrame.new(TargetPart.CFrame.p + Vector3.new(0,0,math.random(-2,2)),TargetPart.CFrame.p)
        if _G.Code1 ~= nil and _G.Code2 ~= nil then
            if UntilDeath == true then
                repeat 
                    coroutine.resume(coroutine.create(function()
                        local Position = CFrame.new(TargetPart.CFrame.p + Vector3.new(math.random(-2,2),math.random(-2,2),math.random(-2,2)),TargetPart.CFrame.p)
                        workspace.ServerStuff.throwWeapon:FireServer("TKnife", 1000, Position, 0.19341856241226196, Data, 0, false, _G.Code1, nil, _G.Code2)
                    end))
                    task.wait()
                until Model == nil or not Model:FindFirstAncestor("Workspace") or not Model:FindFirstChild("Humanoid") or Model.Humanoid.Health <= 0
            else
                coroutine.resume(coroutine.create(function()
                    workspace.ServerStuff.throwWeapon:FireServer("TKnife", 1000, Position, 0.19341856241226196, Data, 0, false, _G.Code1, nil, _G.Code2)
                end))
            end
        end
    end
end

local function StopLoops()
    local DontStop = false
    for i = 1,#Tables.Lists.LoopedFeatures do
        if Toggles[Tables.Lists.LoopedFeatures[i]] == true then
            return
        end
    end
    if Variables.RenderStepConnection ~= nil then
        Variables.RenderStepConnection:Disconnect()
        Variables.RenderStepConnection = nil
    end
end

local function GetFocusDistance(cameraFrame) -- credit to infinite yield, I completely stole this
	local znear = 0.1
	local viewport = Camera.ViewportSize
	local projy = 2*math.tan(Camera.FieldOfView/2)
	local projx = viewport.x/viewport.y*projy
	local fx = cameraFrame.rightVector
	local fy = cameraFrame.upVector
	local fz = cameraFrame.lookVector

	local minVect = Vector3.new()
	local minDist = 512

	for x = 0, 1, 0.5 do
		for y = 0, 1, 0.5 do
			local cx = (x - 0.5)*projx
			local cy = (y - 0.5)*projy
			local offset = fx*cx - fy*cy + fz
			local origin = cameraFrame.p + offset*znear
			local _, hit = workspace:FindPartOnRay(Ray.new(origin, offset.unit*minDist))
			local dist = (hit - origin).magnitude
			if minDist > dist then
				minDist = dist
				minVect = offset.unit
			end
		end
	end

	return fz:Dot(minVect)*minDist
end

local function RTSMouse(Action, State, Input)
    if State == Enum.UserInputState.Begin then
        Tables.ControlMode.DragStart = Vector2.new(Mouse.X,Mouse.Y)
        Selection.Position = UDim2.new(0,Mouse.X,0,Mouse.Y)
        Selection.Visible = true
        repeat 
            Selection.Size = UDim2.new(0, Mouse.X - Tables.ControlMode.DragStart.X, 0, Mouse.Y - Tables.ControlMode.DragStart.Y)
            task.wait()
        until not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        Selection.Visible = false
    end
    if State == Enum.UserInputState.End then
        local DragEnd = Vector2.new(Mouse.X,Mouse.Y)
        local Distance = (Tables.ControlMode.DragStart - DragEnd).magnitude
print(Distance)
        if Distance < 2 then -- Click
            Tables.ControlMode.MoveNPCsTo = Mouse.Hit.p
            print(Tables.ControlMode.MoveNPCsTo)
            --[[
            for i,v in pairs(Tables.ControlMode.SelectedNPCs) do
                if v ~= nil and v:FindFirstAncestor("Workspace") and v:FindFirstChild("Humanoid") then
                    v.Humanoid:MoveTo(Mouse.Hit.p)
                end
            end
            --]]
        else -- Drag
            Tables.ControlMode.MoveNPCsTo = Vector3.new(0,0,0)
            for i,v in pairs(Tables.ControlMode.NPCHighlights:GetChildren()) do
                v:Destroy()
            end
            for i = 1,#Tables.ControlMode.SelectedNPCs do
                table.remove(Tables.ControlMode.SelectedNPCs,1)
            end
            for i,v in pairs(game.Workspace.activeHostiles:GetChildren()) do
                if not v:IsA("Player") then
                    local Character = v
                    if Character ~= nil and Character:FindFirstChild("HumanoidRootPart") then
                        local ScreenPos,OnScreen = Camera:WorldToScreenPoint(Character.HumanoidRootPart.Position)
                        if OnScreen and ScreenPos.X > Tables.ControlMode.DragStart.X and ScreenPos.Y > Tables.ControlMode.DragStart.Y and ScreenPos.X < DragEnd.X and ScreenPos.Y < DragEnd.Y then
                            -- Player.Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0,3,0)
                            if Character:FindFirstChild("ai_type") and not string.find(Character["ai_type"].Value,"Raider") then
                                Player.Character = Character
                            end
                            table.insert(Tables.ControlMode.SelectedNPCs,Character)
                            for x,y in pairs(Character:GetChildren()) do
                                if y:IsA("BasePart") then
                                    local NewHighlight = Instance.new("BoxHandleAdornment")
                                    NewHighlight.Name = Character.Name
                                    NewHighlight.Parent = Tables.ControlMode.NPCHighlights
                                    NewHighlight.Adornee = y
                                    NewHighlight.AlwaysOnTop = true
                                    NewHighlight.ZIndex = 10
                                    NewHighlight.Size = y.Size
                                    NewHighlight.Transparency = 0.3
                                    NewHighlight.Color3 = Color3.new(0,255,0)
                                end
                            end
                            --task.wait(0.2)
                        end
                    end
                    if Character:FindFirstChild("targetting") then
                        Character.targetting.Changed:Connect(function()
                            if table.find(Tables.ControlMode.SelectedNPCs,Character) and Character:FindFirstChild("targetting") and Character:FindFirstChild("HumanoidRootPart") then
                                if Character.targetting.Value == true and not Character.HumanoidRootPart:FindFirstChild("Attacking") then
                                    local billgui = Instance.new('BillboardGui', Character.HumanoidRootPart)
                                    local textlab = Instance.new('TextLabel', billgui)
                            
                                    billgui.Name = "Attacking"
                                    billgui.Adornee  = Character.HumanoidRootPart
                                    billgui.AlwaysOnTop = true
                                    billgui.ExtentsOffset = Vector3.new(0, 0, 0)
                                    billgui.Size = UDim2.new(0, 5, 0, 5)
                            
                                    textlab.Name = "Marker"
                                    textlab.BackgroundColor3 = Color3.new(255, 255, 255)
                                    textlab.BackgroundTransparency = 1
                                    textlab.BorderSizePixel = 0
                                    textlab.Position = UDim2.new(0, 0, 0, -40)
                                    textlab.Size = UDim2.new(1, 0, 10, 0)
                                    textlab.Visible = true
                                    textlab.ZIndex = 10
                                    textlab.Font = "ArialBold"
                                    textlab.FontSize = "Size18"
                                    textlab.Text = "ATTACKING"
                                    textlab.TextColor3 = Color3.new(255,0,0)
                                    textlab.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                                    textlab.TextStrokeTransparency = 0.6
                                    textlab.TextSize = 10
                                elseif Character.targetting.Value == false then
                                    if Character.HumanoidRootPart:FindFirstChild("Attacking") then
                                        Character.HumanoidRootPart.Attacking:Destroy()
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            if #Tables.ControlMode.SelectedNPCs == 0 then
                local PlayerCharacter = game.Workspace:FindFirstChild(Player.Name) or game.Workspace.activePlayers:FindFirstChild(Player.Name) or game.Workspace.speccingPlayers:FindFirstChild(Player.Name) or game.Workspace.playersWaiting:FindFirstChild(Player.Name)
                Player.Character = PlayerCharacter
                -- PlayerCharacter.HumanoidRootPart.CFrame = OriginalCFrame
            end
        end
    end
end

local function RTSKeyboard(Action, State, Input)
    if Tables.ControlMode.CameraIncrements[tostring(Input.KeyCode)] == nil then
        return
    end
    repeat
        local Position = CFrame.new(Camera.CFrame.p + Tables.ControlMode.CameraIncrements[tostring(Input.KeyCode)])
        local Orientation = Camera.CFrame - Camera.CFrame.p
        local ToSet = Position*Orientation
        Camera.CFrame = ToSet
        Camera.Focus = ToSet*CFrame.new(0, 0, -GetFocusDistance(ToSet))
        task.wait(0.00000000000001)
    until not UserInputService:IsKeyDown(Input.KeyCode)
end

local RenderStepped

local function StartRTS(Continued)
    if Variables.RenderStepConnection == nil then
        print("as it should be")
        Variables.RenderStepConnection = game:GetService("RunService").Stepped:Connect(RenderStepped)
    end
    local AlreadyOn = Toggles.ControlMode
    Toggles.ControlMode = true
    local Stats = ServerStuff.retrieveStats:InvokeServer()
    if Stats.Settings.Spec == false then
        ServerStuff.changeStats:InvokeServer("changesetting", "Spec")
    end
    ServerStuff.spawnPlayer:FireServer("hubbing")
    local Character = game.Workspace.speccingPlayers:WaitForChild(Player.Name)
    repeat wait() until Player.PlayerGui:FindFirstChild("endgamegui")
    wait(1)
    Tables.ControlMode.OriginalCameraCFrame = Camera.CFrame
    Camera.CameraType = Enum.CameraType.Custom
    Player.CameraMode = Enum.CameraMode.Classic
    UserInputService.MouseIconEnabled = true
    local GUI = Player.PlayerGui:FindFirstChild("mainHUD") or Player.PlayerGui:FindFirstChild("menuGui") or Player.PlayerGui:FindFirstChild("endgamegui")
    if GUI ~= nil then
        GUI.Enabled = false
    end
    ReturnButton.Visible = true
    if Continued == nil or Continued == false then
        Camera.CFrame = CFrame.new(Vector3.new(22, 64, 78), Vector3.new(22, 0, 0))
        Camera.Focus = Camera.CFrame*CFrame.new(0, 0, -GetFocusDistance(Camera.CFrame))
    end
    game:GetService("Lighting").FogEnd = 1000000000000000
    for i,v in pairs(Camera:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        end
    end
    if not AlreadyOn then
        Character:FindFirstChild("HumanoidRootPart").Anchored = false
        Character.Humanoid:ChangeState(11)
        Character.Parent = workspace
--[[
        Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(20,-20,-12)
        local RootPart1 = Character:FindFirstChild("HumanoidRootPart")
        local RootPart2 = RootPart1:Clone()
        Character.Parent = nil
        task.wait()
        RootPart1.Parent = RootPart2
        RootPart1.RootJoint.Part0 = nil
        RootPart2.Parent = Character
--]]
        local Character = game.Workspace:FindFirstChild(Player.Name) or game.Workspace.activePlayers:FindFirstChild(Player.Name) or game.Workspace.speccingPlayers:FindFirstChild(Player.Name) or game.Workspace.playersWaiting:FindFirstChild(Player.Name)
        if Character:FindFirstChild("HumanoidRootPart") and not Character.HumanoidRootPart:FindFirstChild("BodyPosition") then
            local Align = Instance.new("AlignPosition",Character.HumanoidRootPart)
            Align.Name = "BodyPosition" -- I'm losing my mind
            Align.MaxForce = 100
            Align.MaxVelocity = 100
            Align.Responsiveness = 100
            Align.ApplyAtCenterOfMass = true
            Align.Mode = Enum.PositionAlignmentMode.OneAttachment
            Align.Attachment0 = Character.HumanoidRootPart:FindFirstChildOfClass("Attachment")
            Align.Position = Align.Parent.Position
            Align.RigidityEnabled = true
            Align.Parent = RootPart
            Align.Enabled = true
        end
        game:GetService("ContextActionService"):BindActionAtPriority("RTSKeyboard",RTSKeyboard,false,Enum.ContextActionPriority.High.Value,
            Enum.KeyCode.W,
            Enum.KeyCode.A,
            Enum.KeyCode.S,
            Enum.KeyCode.D,
            Enum.KeyCode.Q,
            Enum.KeyCode.E
        )
        game:GetService("ContextActionService"):BindActionAtPriority("RTSMouse",RTSMouse,false,Enum.ContextActionPriority.High.Value,
            -- Enum.UserInputType.MouseMovement,
            Enum.UserInputType.MouseButton1
        )
    end
end

local function StopRTS()
    Toggles.ControlMode = false
    local Stats = ServerStuff.retrieveStats:InvokeServer()
    if Stats.Settings.Spec == true then
        ServerStuff.changeStats:InvokeServer("changesetting", "Spec")
    end
    ServerStuff.spawnPlayer:FireServer("respawncharacter")
    game:GetService("ContextActionService"):UnbindAction("RTSKeyboard")
    game:GetService("ContextActionService"):UnbindAction("RTSMouse")
    StopLoops()
    local GUI = Player.PlayerGui:FindFirstChild("mainHUD") or Player.PlayerGui:FindFirstChild("menuGui") or Player.PlayerGui:FindFirstChild("endgamegui")
    if GUI ~= nil then
        GUI.Enabled = true
        if GUI.Name == "menuGui" then
            Player.CameraMode = Enum.CameraMode.Classic
            Camera.CameraType = Enum.CameraType.Scriptable
            Camera.CFrame = CFrame.new(-81.0454330444336, -380.85345458984375, 346.3423767089844)
        elseif GUI.Name == "endgamegui" then
            Player.CameraMode = Enum.CameraMode.Classic
            Camera.CameraType = Enum.CameraType.Follow
            Camera.CFrame = CFrame.new(404.30987548828125, 11.317222595214844, -8.332843780517578)
        elseif GUI.Name == "mainHUD" then
            Player.CameraMode = Enum.CameraMode.LockFirstPerson
            Camera.CameraType = Enum.CameraType.Custom
            UserInputService.MouseIconEnabled = false
        end
    end
    local Character = game.Workspace:FindFirstChild(Player.Name) or game.Workspace.activePlayers:FindFirstChild(Player.Name) or game.Workspace.speccingPlayers:FindFirstChild(Player.Name) or game.Workspace.playersWaiting:FindFirstChild(Player.Name)
    if Character:FindFirstChild("HumanoidRootPart") and Character.HumanoidRootPart:FindFirstChild("BodyPosition") then
        Character.HumanoidRootPart.BodyPosition:Destroy()
    end
--[[
    local Character = game.Workspace:FindFirstChild(Player.Name) or game.Workspace.activePlayers:FindFirstChild(Player.Name) or game.Workspace.speccingPlayers:FindFirstChild(Player.Name) or game.Workspace.playersWaiting:FindFirstChild(Player.Name)
    Player.Character = Character
    if Character:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart.CFrame = CFrame.new(395.2120056152344, -2.5432708263397217, -4.005140781402588)
    end
--]]
    ReturnButton.Visible = false
    for i,v in pairs(Camera:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0
        end
    end
end

ReturnButton.MouseButton1Click:Connect(function()
    StopRTS()
end)

local function GetClosest()
    local LowestDistance = math.huge
    local ClosestCharacter = nil
    local Characters = game.Workspace.activeHostiles.GetChildren(game.Workspace.activeHostiles)
    for i,v in pairs(game.Workspace.NoTarget.GetChildren(game.Workspace.NoTarget)) do
        table.insert(Characters, v)
    end
    for i,v in pairs(Characters) do
        if v ~= nil then
            if v.FindFirstChild(v, "Torso") then
                local InitialDis = (v.Torso.Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local Ray = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * InitialDis)
                local Part,Position = game.Workspace.FindPartOnRay(game.Workspace, Ray, game.Workspace)
                local FinalDifference = math.floor((Position - v.Torso.Position).magnitude)
                if FinalDifference < LowestDistance then
                    ClosestCharacter = v
                    LowestDistance = FinalDifference
                end
            end
        end
    end
    return ClosestCharacter
end

local function Mark(part,table,visible,fade,fadedis)
    local billgui = Instance.new('BillboardGui', part)
    local imagelab = Instance.new('ImageLabel', billgui)
    
    billgui.Name = "ESPBillboard"
    billgui.Adornee  = part
    billgui.AlwaysOnTop = true
    --billgui.ExtentsOffset = Vector3.new(0, 1, 0)
    billgui.ExtentsOffsetWorldSpace = Vector3.new(0, 1, 0)
    billgui.StudsOffset = Vector3.new(0, 3, 0)
    billgui.Size = UDim2.new(0, 60, 0, 60)
    if visible == nil or visible == true then
        billgui.Enabled = true
    else
        billgui.Enabled = false
    end
    
    imagelab.Name = "ESPLabel"
    imagelab.Image = "rbxassetid://"..table.img
    imagelab.BackgroundTransparency = 1
    imagelab.BorderSizePixel = 0
    imagelab.Position = UDim2.new(0, 0, 0, 0)
    imagelab.Size = UDim2.new(1, 0, 1, 0)
    imagelab.Visible = true
    imagelab.ZIndex = 10

    if table["subtext"] ~= nil then
        local textlab = Instance.new('TextLabel', imagelab)
        textlab.Name = "ESPLabel"
        textlab.BackgroundColor3 = Color3.new(255, 255, 255)
        textlab.BackgroundTransparency = 1
        textlab.BorderSizePixel = 0
        textlab.Position = UDim2.new(0.4, 0, 0.8, 0)
        textlab.Size = UDim2.new(0.2, 0, 0.2, 0)
        textlab.Visible = true
        textlab.ZIndex = 15
        textlab.Font = 'ArialBold'
        textlab.FontSize = 2
        textlab.Text = table["subtext"]
        textlab.TextColor3 = Color3.fromRGB(255,255,255)
        if table["subtextcolor"] ~= nil then
            textlab.TextStrokeColor3 = table["subtextcolor"]
        else
            textlab.TextStrokeColor3 = Color3.fromRGB(255,0,93)
        end
        textlab.TextStrokeTransparency = 0.6
        textlab.TextXAlignment = Enum.TextXAlignment.Center
    end
    return billgui
end

local function MenuEffect()
    local Sound = game.ReplicatedStorage.soundLibrary.AGENT:FindFirstChild("menu"):Clone()
    Sound.Parent = game.Players.LocalPlayer.PlayerGui
    Sound.SoundGroup = game:GetService("SoundService").regular
    Sound.Looped = false;
    Sound.Ended:connect(function()
        spawn(function()
            Sound:Destroy()
        end)
    end)
    Sound:Play()
    local BlinkEffect = game.Players.LocalPlayer.PlayerGui.mainHUD.TabMenu.bg.bg:Clone()
    BlinkEffect.Parent = game.Players.LocalPlayer.PlayerGui.mainHUD.TabMenu.bg
    spawn(function()
        while true do
            BlinkEffect.ImageTransparency = BlinkEffect.ImageTransparency + 0.05
            task.wait()
            if BlinkEffect.ImageTransparency >= 1 then
                break
            end	
        end
        BlinkEffect:Destroy()
    end)
end

-- CONNECTION FUNCTIONS -- 

local function SetupGUI()
    repeat task.wait() until Player:FindFirstChild("PlayerGui")
    repeat task.wait() until Player.PlayerGui:FindFirstChild("mainHUD")
    repeat task.wait() until Player.PlayerGui.mainHUD:FindFirstChild("TabMenu")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu:FindFirstChild("bg")
    if Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("GOODWILL") then
        return
    end
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("rations")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("ammodrop")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("weaponinfo")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("scrap")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("rationstab")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("scraptab")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg:FindFirstChild("weaponinfotab")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab:FindFirstChild("founditem")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.scraptab:FindFirstChild("lessbutton")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.scraptab:FindFirstChild("morebutton")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.rationstab:FindFirstChild("Soda")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.rationstab.Soda:FindFirstChild("drop")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.rationstab.Soda:FindFirstChild("desc")

    local GoodwillButton = Player.PlayerGui.mainHUD.TabMenu.bg.rations:Clone()
    GoodwillButton.Name = "GOODWILL"
    GoodwillButton.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    GoodwillButton.Text = "GOODWILL"
    GoodwillButton.Position = UDim2.new(0.949999988, -510, 0.899999976, 0)
    local GoodwillTab = Player.PlayerGui.mainHUD.TabMenu.bg.rationstab:Clone()
    GoodwillTab:ClearAllChildren()
    GoodwillTab.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    GoodwillTab.Name = "GOODWILLtab"

    local StatsButton = Player.PlayerGui.mainHUD.TabMenu.bg.rations:Clone()
    StatsButton.Name = "STATS"
    StatsButton.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    StatsButton.Text = "CHANGESTATS"
    StatsButton.Position = UDim2.new(0.949999988, -340, 0.899999976, 0)
    local StatsTab = Player.PlayerGui.mainHUD.TabMenu.bg.rationstab:Clone()
    StatsTab:ClearAllChildren()
    StatsTab.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    StatsTab.Name = "Statstab"

    local FeatureButton = Player.PlayerGui.mainHUD.TabMenu.bg.rationstab.Soda.drop:Clone()
    FeatureButton.Size = UDim2.new(0.24, 0, 0.15, 0)

    local SmallText = Player.PlayerGui.mainHUD.TabMenu.bg.rationstab.Soda.desc:Clone()
    SmallText.Size = UDim2.new(0.24, 0, 0.15, 0)

    local MoreButton = Player.PlayerGui.mainHUD.TabMenu.bg.scraptab:FindFirstChild("morebutton"):Clone()
    MoreButton.Size = UDim2.new(0.05, 0, 0.084, 0)
    local LessButton = Player.PlayerGui.mainHUD.TabMenu.bg.scraptab:FindFirstChild("lessbutton"):Clone()
    LessButton.Size = UDim2.new(0.05, 0, 0.084, 0)

    for i,v in pairs(Tables.Lists.GuiCommands) do
        local NewButton = FeatureButton:Clone()
        NewButton.Name = v
        NewButton.Text = v
        NewButton.Parent = GoodwillTab
        local OutOfFour = (((i/4)%1)/25)*100
        if OutOfFour == 0 then
            OutOfFour = 4 -- fuck math
        end
        local Rounded = math.floor((i/4)-0.01)
        NewButton.Position = UDim2.new(0.24*(OutOfFour-1),OutOfFour*15,0.15*Rounded,Rounded*15)
        NewButton.MouseButton1Down:Connect(function()
            MenuEffect()
            if Toggles[v] ~= nil and Toggles[v] then
                Players:Chat(":un"..v)
            else
                Players:Chat(":"..v)
            end
        end)
    end


    local MothLogo = Instance.new("ImageLabel", Player.PlayerGui.mainHUD.TabMenu.bg)
    MothLogo.Visible = false
    MothLogo.BackgroundTransparency = 1
    MothLogo.Image = "rbxassetid://7841170230"
    MothLogo.Size = UDim2.new(0.17,0,0.371,0)
    MothLogo.Position = UDim2.new(0,20,0.65,0)
    local CreditText = SmallText:Clone()
    CreditText.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    CreditText.Name = "CreditText"
    CreditText.TextXAlignment = Enum.TextXAlignment.Left
    CreditText.Size = UDim2.new(0.001, 0, 0.001, 0)
    CreditText.Position = UDim2.new(0.2,0,0.8,0)
    CreditText.Text = "> ESP ICONS MADE BY PALEMOTH"
    CreditText.Visible = false

    local Watermark = Instance.new("ImageLabel",Player.PlayerGui.mainHUD.TabMenu.bg)
    Watermark.Name = "Watermark"
    Watermark.BackgroundColor3 = Color3.new(1, 1, 1)
    Watermark.BackgroundTransparency = 1
    Watermark.Position = UDim2.new(0,0,0.7,0)
    Watermark.Size = UDim2.new(0.3,0,0.25,0)
    Watermark.ImageTransparency = 0
    Watermark.Image = "rbxassetid://4738504469"
    Watermark.Visible = false
    local CreditText2 = SmallText:Clone()
    CreditText2.Name = "CreditText2"
    CreditText2.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    CreditText2.TextXAlignment = Enum.TextXAlignment.Left
    CreditText2.Size = UDim2.new(0.001, 0, 0.001, 0)
    CreditText2.Position = UDim2.new(0.28,0,0.75,0)
    CreditText2.Text = "> SCRIPT BY AIDEZ"
    CreditText2.Visible = false

    
--[[
    local GaryWatermark = SmallText:Clone()
    GaryWatermark.Name = "GaryWatermark"
    GaryWatermark.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    GaryWatermark.TextXAlignment = Enum.TextXAlignment.Center
    GaryWatermark.Position = UDim2.new(0,0,0.75,0)
    GaryWatermark.Size = UDim2.new(0.3,0,0.25,0)
    GaryWatermark.Visible = false
    GaryWatermark.TextScaled = true
--]]
    local GaryCreditText = SmallText:Clone()
    GaryCreditText.Name = "GaryCreditText"
    GaryCreditText.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    GaryCreditText.TextXAlignment = Enum.TextXAlignment.Left
    GaryCreditText.Size = UDim2.new(0.001, 0, 0.001, 0)
    GaryCreditText.Position = UDim2.new(0.28,0,0.80,0)
    GaryCreditText.Text = "> Additional help & testing from GARY..#3254"
    GaryCreditText.Visible = false

    GoodwillButton.MouseButton1Down:Connect(function()
        MenuEffect()
        for i,v in pairs(Player.PlayerGui.mainHUD.TabMenu.bg:GetChildren()) do
            if string.sub(string.lower(v.Name), #v.Name - 2, -1) == "tab" and v.Name ~= "GOODWILLtab" and v.Name ~= "objectivetab" then
                 v.Visible = false
            elseif v.Parent:FindFirstChild(v.Name.."tab") and v.Name ~= "GOODWILL" then
                 v.BackgroundTransparency = 0.7
            end
        end
        Watermark.Visible = true
        CreditText2.Visible = true
        -- GaryWatermark.Visible = true
        GaryCreditText.Visible = true
        MothLogo.Visible = false
        CreditText.Visible = false
        GoodwillTab.Visible = true
        StatsTab.Visible = false
        GoodwillButton.BackgroundTransparency = 0.3
    end)

    StatsButton.MouseButton1Down:Connect(function()
        MenuEffect()
        for i,v in pairs(Player.PlayerGui.mainHUD.TabMenu.bg:GetChildren()) do
            if string.sub(string.lower(v.Name), #v.Name - 2, -1) == "tab" and v.Name ~= "StatsButtontab" and v.Name ~= "objectivetab" then
                 v.Visible = false
            elseif v.Parent:FindFirstChild(v.Name.."tab") and v.Name ~= "STATS" then
                 v.BackgroundTransparency = 0.7
            end
        end
        Watermark.Visible = true
        CreditText2.Visible = true
        -- GaryWatermark.Visible = true
        GaryCreditText.Visible = true
        MothLogo.Visible = false
        CreditText.Visible = false
        GoodwillTab.Visible = false
        StatsTab.Visible = true
        StatsButton.BackgroundTransparency = 0.3
    end)

    local ESPButton = Player.PlayerGui.mainHUD.TabMenu.bg.rations:Clone()
    ESPButton.Name = "ESP"
    ESPButton.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    ESPButton.Text = "ESP"
    ESPButton.Position = UDim2.new(0.949999988, -340, 0.980000019, 0)
    local ESPTab = Player.PlayerGui.mainHUD.TabMenu.bg.rationstab:Clone()
    ESPTab:ClearAllChildren()
    ESPTab.Parent = Player.PlayerGui.mainHUD.TabMenu.bg
    ESPTab.Name = "ESPtab"

    ESPButton.MouseButton1Down:Connect(function()
        MenuEffect()
        for i,v in pairs(Player.PlayerGui.mainHUD.TabMenu.bg:GetChildren()) do
            if string.sub(string.lower(v.Name), #v.Name - 2, -1) == "tab" and v.Name ~= "ESPtab" and v.Name ~= "objectivetab" then
                 v.Visible = false
            elseif v.Parent:FindFirstChild(v.Name.."tab") and v.Name ~= "ESP" then
                 v.BackgroundTransparency = 0.7
            end
        end
        Watermark.Visible = false
        CreditText2.Visible = false
        -- GaryWatermark.Visible = false
        GaryCreditText.Visible = false
        ESPTab.Visible = true
        MothLogo.Visible = true
        CreditText.Visible = true
        ESPButton.BackgroundTransparency = 0.3
        GoodwillButton.BackgroundTransparency = 0.7
        StatsButton.BackgroundTransparency = 0.7
    end)
    local EspButtonsTemp = {}
    for i,v in pairs(Esp.EspInfo.Toggles) do
        local NewButton = FeatureButton:Clone()
        NewButton.Name = i
        NewButton.Text = i
        NewButton.Parent = ESPTab
        if v == true then
            NewButton.BackgroundTransparency = 0.3
        else
            NewButton.BackgroundTransparency = 0.7
        end
        NewButton.MouseButton1Down:Connect(function()
            MenuEffect()
            Esp.EspInfo.Toggles[i] = not Esp.EspInfo.Toggles[i]
            for x,y in pairs(Esp.EspObjects[i]) do
                y.Enabled = Esp.EspInfo.Toggles[i]
            end
            if Esp.EspInfo.Toggles[i] then
                NewButton.BackgroundTransparency = 0.3
            else
                NewButton.BackgroundTransparency = 0.7
            end
        end)
        table.insert(EspButtonsTemp, NewButton)
    end
    local AllOff = FeatureButton:Clone()
    AllOff.Name = "ALL OFF"
    AllOff.Text = "TURN ALL OFF"
    AllOff.Parent = ESPTab
    AllOff.BackgroundTransparency = 0.3
    AllOff.MouseButton1Down:Connect(function()
        for i,v in pairs(Esp.EspInfo.Toggles) do
            Esp.EspInfo.Toggles[i] = false
            for x,y in pairs(Esp.EspObjects[i]) do
                y.Enabled = Esp.EspInfo.Toggles[i]
            end
        end
        for i,v in pairs(ESPTab:GetChildren()) do
            if v:IsA("TextButton") and v.Name ~= "ALL OFF" then
                v.BackgroundTransparency = 0.7
            end
        end
    end)
    table.insert(EspButtonsTemp, AllOff)
    for i,v in pairs(EspButtonsTemp) do
        local OutOfFour = (((i/4)%1)/25)*100
        if OutOfFour == 0 then
            OutOfFour = 4 -- fuck math
        end
        local Rounded = math.floor((i/4)-0.01)
        v.Position = UDim2.new(0.24*(OutOfFour-1),OutOfFour*15,0.15*Rounded,Rounded*15)
    end


    for i,v in pairs(Player.PlayerGui.mainHUD.TabMenu.bg:GetChildren()) do
        if v:IsA("TextButton") and v.Name ~= "GOODWILL" and v.Name ~= "ESP" and v.Name ~= "STATS" then
            v.MouseButton1Down:Connect(function()
                GoodwillButton.BackgroundTransparency = 0.7
                GoodwillTab.Visible = false
                StatsButton.BackgroundTransparency = 0.7
                StatsTab.Visible = false
                ESPButton.BackgroundTransparency = 0.7
                ESPTab.Visible = false
                MothLogo.Visible = false
                CreditText.Visible = false
                Watermark.Visible = false
                CreditText2.Visible = false
                -- GaryWatermark.Visible = false
                GaryCreditText.Visible = false
            end)
        end
    end

    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line1")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line2")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line3")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line4")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line5")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line6")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line7")
    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:FindFirstChild("line8")

    repeat task.wait() until Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab:FindFirstChild("error_found")

    local ErrorFound = Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab["error_found"]
    local FrameClone = Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:Clone()

    local ResetButton = MoreButton:Clone()
    ResetButton.Parent = Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem
    ResetButton.Position = UDim2.new(0.9,0,0.200000003,0)
    ResetButton.Size = UDim2.new(0.127, 0, 0.084, 0)
    ResetButton.icon.Text = "Default"

    ResetButton.MouseButton1Down:Connect(function()
        if Variables.ShownWeapon == "nil" or Variables.ShownWeapon == "" then
            return
        end
        for i,v in pairs(Tables.Stats.WeaponStats[Variables.ShownWeapon]) do
            if Tables.OriginalStats[Variables.ShownWeapon] ~= nil then
                local ToSet = Tables.OriginalStats[Variables.ShownWeapon][i]
                Tables.Stats.WeaponStats[Variables.ShownWeapon][i] = ToSet
            end
        end
    end)

    for i,v in pairs(Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:GetChildren()) do
        if string.find(v.Name, "line") and v.Name ~= "line1" and not string.find(v.Name, "more") and not string.find(v.Name, "less") and not string.find(v.Name, "big") then
            local Space = string.find(v.Text, ": ")
            local StatName = ""
            local StatPlacement = nil
            if Space ~= nil then
                StatName = string.sub(v.Text, 2, Space-1)
                StatPlacement = Tables.Conversions.NameToStat[StatName]
            end
            local NewMoreButton = MoreButton:Clone()
            local NewLessButton = LessButton:Clone()
            NewMoreButton.Parent = Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem
            NewLessButton.Parent = NewMoreButton.Parent
            NewMoreButton.Position = UDim2.new(0.9,40,v.Position.Y.Scale,0)
            NewLessButton.Position = UDim2.new(0.9,0,v.Position.Y.Scale,0)
            NewMoreButton.Name = v.Name.."more"
            NewLessButton.Name = v.Name.."less"

            local NewBigMore = NewMoreButton:Clone()
            local NewBigLess = NewLessButton:Clone()
            NewBigMore.Parent = NewMoreButton.Parent
            NewBigLess.Parent = NewMoreButton.Parent
            NewBigMore.Name = NewBigMore.Name.."big"
            NewBigLess.Name = NewBigLess.Name.."big"
            NewBigMore.Position = UDim2.new(0.9,75,v.Position.Y.Scale,0)
            NewBigLess.Position = UDim2.new(0.9,-35,v.Position.Y.Scale,0)
            NewBigLess.icon.Text = "--"
            NewBigMore.icon.Text = "++"

            if StatPlacement ~= nil and StatPlacement["BigIncrement"] ~= nil then
                NewBigMore.Visible = true
                NewBigLess.Visible = true
            else
                NewBigMore.Visible = false
                NewBigLess.Visible = false
            end

            if v.Text == "" or string.find(v.Text, "RARITY") or string.find(v.Text, "HEAVY_SWING") then
                NewMoreButton.Visible = false
                NewLessButton.Visible = false
                NewBigMore.Visible = false
                NewBigLess.Visible = false
            end
            if string.find(v.Text, "TRUE") then
                NewLessButton.Visible = false
                NewMoreButton.icon.Text = "X"
            elseif string.find(v.Text, "FALSE") then
                NewLessButton.Visible = false
                NewMoreButton.icon.Text = ""
            end

            v:GetPropertyChangedSignal("Text"):Connect(function()
                local Space = string.find(v.Text, ": ")
                local StatName = ""
                local StatPlacement = nil
                if Space ~= nil then
                    StatName = string.sub(v.Text, 2, Space-1)
                    StatPlacement = Tables.Conversions.NameToStat[StatName]
                end
                if StatPlacement ~= nil and StatPlacement["BigIncrement"] ~= nil then
                    NewBigMore.Visible = true
                    NewBigLess.Visible = true
                    NewBigLess.icon.Text = "--"
                    NewBigMore.icon.Text = "++"
                else
                    NewBigMore.Visible = false
                    NewBigLess.Visible = false
                end
                if string.find(v.Text, "TRUE") then
                    NewLessButton.Visible = false
                    NewMoreButton.icon.Text = "X"
                elseif string.find(v.Text, "FALSE") then
                    NewLessButton.Visible = false
                    NewMoreButton.icon.Text = ""
                elseif v.Text == "" or string.find(v.Text, "RARITY") or string.find(v.Text, "HEAVY_SWING") then
                    NewLessButton.Visible = false
                    NewMoreButton.Visible = false
                    NewBigMore.Visible = false
                    NewBigLess.Visible = false
                else
                    NewLessButton.Visible = true
                    NewLessButton.icon.Text = "-"
                    NewMoreButton.Visible = true
                    NewMoreButton.icon.Text = "+"
                end
            end)

            NewMoreButton.MouseButton1Down:Connect(function()
                local Label = NewMoreButton.Parent:FindFirstChild(string.sub(NewMoreButton.Name,1,#NewMoreButton.Name-4))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewMoreButton.icon.Text == "+" then
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if Tables.Conversions.NameToStat[StatName].Index ~= nil then
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] + StatPlacement.Increment
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] + StatPlacement.Increment
                        end
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.Increment
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.Increment
                        end
                    end
                elseif NewMoreButton.icon.Text == "" then
                    Tables.Stats.WeaponStats[Variables.ShownWeapon].auto = false
                    NewMoreButton.icon.Text = "X"
                elseif NewMoreButton.icon.Text == "X" then
                    Tables.Stats.WeaponStats[Variables.ShownWeapon].auto = true
                    NewMoreButton.icon.Text = ""
                end
            end)

            NewLessButton.MouseButton1Down:Connect(function()
                local Label = NewLessButton.Parent:FindFirstChild(string.sub(NewLessButton.Name,1,#NewLessButton.Name-4))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewLessButton.icon.Text == "-" then
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if Tables.Conversions.NameToStat[StatName].Index ~= nil then
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] - StatPlacement.Increment
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = 0
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] - StatPlacement.Increment
                        end
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.Increment
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.Increment
                        end
                    end
                end
            end)

            NewBigMore.MouseButton1Down:Connect(function()
                local Label = NewBigMore.Parent:FindFirstChild(string.sub(NewBigMore.Name,1,#NewBigMore.Name-7))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewBigMore.icon.Text == "++" then
                    if Tables.Stats.WeaponStats == nil then
                        Tables.Stats.WeaponStats = require(game.Workspace.ServerStuff.Statistics.W_STATISTICS)
                    end
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if Tables.Conversions.NameToStat[StatName].Index ~= nil then
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] + StatPlacement.BigIncrement
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = 0
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] + StatPlacement.BigIncrement
                        end
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.BigIncrement
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.BigIncrement
                        end
                    end
                elseif NewBigMore.icon.Text == "" then
                    Tables.Stats.WeaponStats[Variables.ShownWeapon].auto = false
                    NewBigMore.icon.Text = "X"
                elseif NewBigMore.icon.Text == "X" then
                    Tables.Stats.WeaponStats[Variables.ShownWeapon].auto = true
                    NewBigMore.icon.Text = ""
                end
            end)
          

            NewBigLess.MouseButton1Down:Connect(function()
                local Label = NewBigLess.Parent:FindFirstChild(string.sub(NewBigLess.Name,1,#NewBigLess.Name-7))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewBigLess.icon.Text == "--" then
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if Tables.Conversions.NameToStat[StatName].Index ~= nil then
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] - StatPlacement.BigIncrement
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = 0
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat][StatPlacement.Index] - StatPlacement.BigIncrement
                        end
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.BigIncrement
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.BigIncrement
                        end
                    end
                end
            end)


        end
    end

    if Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab:FindFirstChild("AlternateFrame") then
        Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab:FindFirstChild("AlternateFrame"):Destroy()
    end
    FrameClone.Name = "AlternateFrame"

    FrameClone.Parent = Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab
    FrameClone.Visible = not Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem.Visible

    FrameClone.line1.Text = ">SPECIFICATION: MISC"
    FrameClone.line2.Text = ">LIMB_DAMAGE"
    FrameClone.line3.Text = ">HEAD_DAMAGE"
    FrameClone.line4.Text = ">SPEED_RATING"
    FrameClone.line5.Text = ">CHARGE_RATING"
    FrameClone.line6.Text = ">WOUND_RATING"
    FrameClone.line7.Text = ">SIZE_RATING"
    FrameClone.line8.Text = ">THROW_RATING"

    local ResetButton2 = MoreButton:Clone()
    ResetButton2.Parent = FrameClone
    ResetButton2.Position = UDim2.new(0.9,0,0.200000003,0)
    ResetButton2.Size = UDim2.new(0.127, 0, 0.084, 0)
    ResetButton2.icon.Text = "Default"

    ResetButton2.MouseButton1Down:Connect(function()
        if Variables.ShownWeapon == "nil" or Variables.ShownWeapon == "" then
            return
        end
        for i,v in pairs(Tables.Stats.WeaponStats[Variables.ShownWeapon]) do
            if Tables.OriginalStats[Variables.ShownWeapon] ~= nil then
                local ToSet = Tables.OriginalStats[Variables.ShownWeapon][i]
                Tables.Stats.WeaponStats[Variables.ShownWeapon][i] = ToSet
            end
        end
        UpdateMiscWeaponry()
    end)

    repeat task.wait() until Variables.ShownWeapon ~= nil and Variables.ShownWeapon ~= ""

    if Variables.ShownWeapon ~= nil and Variables.ShownWeapon ~= "" then
        local ShownWeaponStats = Tables.Stats.WeaponStats[Variables.ShownWeapon]
        for i,v in pairs(FrameClone:GetChildren()) do
            if not string.find(v.Text, "DAMAGE") and string.find(v.Name, "line") and v.Name ~= "line1" and not string.find(v.Name, "more") and not string.find(v.Name, "less") then
                if ShownWeaponStats ~= nil and ShownWeaponStats[Tables.Conversions.NameToStat[string.gsub(v.Text, ">", "")].Stat] ~= nil then
                    v.Text = v.Text..": "..tostring(ShownWeaponStats[Tables.Conversions.NameToStat[string.gsub(v.Text, ">", "")].Stat])
                else
                    v.Text = v.Text..": N/A"
                end
            elseif string.find(v.Name, "more") or string.find(v.Name, "less") then
                v:Destroy()
            end
        end
        if FrameClone:FindFirstChild("line2") and FrameClone:FindFirstChild("line2") then
            if ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 2 then
                FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][1]
                FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][2]
            elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 3 then
                FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][3]
            elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 4 then
                FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][4]
            end
        end
    end
    Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:GetPropertyChangedSignal("Visible"):Connect(function()
        ErrorFound.Visible = false
        if Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem.Visible then
            FrameClone.Visible = false
        else
            FrameClone.Visible = true
        end
    end)

    for i,v in pairs(FrameClone:GetChildren()) do
        if string.find(v.Name, "line") and v.Name ~= "line1" and not string.find(v.Name, "more") and not string.find(v.Name, "less") then
            local Space = string.find(v.Text, ": ")
            local StatName = ""
            local StatPlacement = nil
            if Space ~= nil then
                StatName = string.sub(v.Text, 2, Space-1)
                StatPlacement = Tables.Conversions.NameToStat[StatName]
            end

            local NewMoreButton = MoreButton:Clone()
            local NewLessButton = LessButton:Clone()
            NewMoreButton.Parent = FrameClone
            NewLessButton.Parent = NewMoreButton.Parent
            NewMoreButton.Position = UDim2.new(0.9,40,v.Position.Y.Scale,0)
            NewLessButton.Position = UDim2.new(0.9,0,v.Position.Y.Scale,0)
            NewMoreButton.Name = v.Name.."more"
            NewLessButton.Name = v.Name.."less"

            local NewBigMore = NewMoreButton:Clone()
            local NewBigLess = NewLessButton:Clone()
            NewBigMore.Parent = NewMoreButton.Parent
            NewBigLess.Parent = NewMoreButton.Parent
            NewBigMore.Name = NewBigMore.Name.."big"
            NewBigLess.Name = NewBigLess.Name.."big"
            NewBigMore.Position = UDim2.new(0.9,75,v.Position.Y.Scale,0)
            NewBigLess.Position = UDim2.new(0.9,-35,v.Position.Y.Scale,0)
            NewBigLess.icon.Text = "--"
            NewBigMore.icon.Text = "++"

            if StatPlacement ~= nil and StatPlacement["BigIncrement"] ~= nil then
                NewBigMore.Visible = true
                NewBigMore.Visible = true
            else
                NewBigMore.Visible = false
                NewBigLess.Visible = false
            end

            NewMoreButton.MouseButton1Down:Connect(function()
                local Label = NewMoreButton.Parent:FindFirstChild(string.sub(NewMoreButton.Name,1,#NewMoreButton.Name-4))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewMoreButton.icon.Text == "+" then
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if string.find(StatName, "DAMAGE") then
                        local Index = #Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"]
                        if string.find(StatName, "LIMB") and Index ~= 3 then
                            Index = Index - 1
                        end
                        Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] + StatPlacement.Increment
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.Increment
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.Increment
                        end
                    end
                end
                if Variables.ShownWeapon ~= nil and Variables.ShownWeapon ~= "" then
                    local ShownWeaponStats = Tables.Stats.WeaponStats[Variables.ShownWeapon]
                    for x,y in pairs(FrameClone:GetChildren()) do
                        if not string.find(y.Text, "DAMAGE") and string.find(y.Name, "line") and y.Name ~= "line1" and not string.find(y.Name, "more") and not string.find(y.Name, "less") then
                            local Space2 = string.find(y.Text, ": ")
                            local StatName2 = string.sub(y.Text, 2, Space2-1)
                            if ShownWeaponStats ~= nil and ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat] ~= nil then
                                y.Text = ">"..StatName2..": "..ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat]
                            else
                                y.Text = ">"..StatName2..": N/A"
                            end
                        end
                    end
                    if ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 2 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][1]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][2]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 3 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 4 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][4]
                    end
                end
            end)

            NewLessButton.MouseButton1Down:Connect(function()
                local Label = NewLessButton.Parent:FindFirstChild(string.sub(NewLessButton.Name,1,#NewLessButton.Name-4))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewLessButton.icon.Text == "-" then
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if string.find(StatName, "DAMAGE") then
                        local Index = #Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"]
                        if string.find(StatName, "LIMB") and Index ~= 3 then
                            Index = Index - 1
                        end
                        Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] - StatPlacement.Increment
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.Increment
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.Increment
                        end
                    end
                end
                if Variables.ShownWeapon ~= nil and Variables.ShownWeapon ~= "" then
                    local ShownWeaponStats = Tables.Stats.WeaponStats[Variables.ShownWeapon]
                    for x,y in pairs(FrameClone:GetChildren()) do
                        if not string.find(y.Text, "DAMAGE") and string.find(y.Name, "line") and y.Name ~= "line1" and not string.find(y.Name, "more") and not string.find(y.Name, "less") then
                            local Space2 = string.find(y.Text, ": ")
                            local StatName2 = string.sub(y.Text, 2, Space2-1)
                            if ShownWeaponStats ~= nil and ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat] ~= nil then
                                y.Text = ">"..StatName2..": "..ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat]
                            else
                                y.Text = ">"..StatName2..": N/A"
                            end
                        end
                    end
                    if ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 2 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][1]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][2]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 3 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 4 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][4]
                    end
                end
            end)

            NewBigMore.MouseButton1Down:Connect(function()
                local Label = NewMoreButton.Parent:FindFirstChild(string.sub(NewMoreButton.Name,1,#NewMoreButton.Name-4))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewMoreButton.icon.Text == "+" then
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if string.find(StatName, "DAMAGE") then
                        local Index = #Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"]
                        if string.find(StatName, "LIMB") and Index ~= 3 then
                            Index = Index - 1
                        end
                        Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] + StatPlacement.BigIncrement
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.BigIncrement
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] + StatPlacement.BigIncrement
                        end
                    end
                end
                if Variables.ShownWeapon ~= nil and Variables.ShownWeapon ~= "" then
                    local ShownWeaponStats = Tables.Stats.WeaponStats[Variables.ShownWeapon]
                    for x,y in pairs(FrameClone:GetChildren()) do
                        if not string.find(y.Text, "DAMAGE") and string.find(y.Name, "line") and y.Name ~= "line1" and not string.find(y.Name, "more") and not string.find(y.Name, "less") then
                            local Space2 = string.find(y.Text, ": ")
                            local StatName2 = string.sub(y.Text, 2, Space2-1)
                            if ShownWeaponStats ~= nil and ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat] ~= nil then
                                y.Text = ">"..StatName2..": "..ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat]
                            else
                                y.Text = ">"..StatName2..": N/A"
                            end
                        end
                    end
                    if ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 2 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][1]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][2]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 3 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 4 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][4]
                    end
                end
            end)

            NewBigLess.MouseButton1Down:Connect(function()
                local Label = NewLessButton.Parent:FindFirstChild(string.sub(NewLessButton.Name,1,#NewLessButton.Name-4))
                if Label == nil or Variables.ShownWeapon == nil then
                    return
                end
                local Space = string.find(Label.Text, ": ")
                local StatName = string.sub(Label.Text, 2, Space-1)
                if NewLessButton.icon.Text == "-" then
                    local StatPlacement = Tables.Conversions.NameToStat[StatName]
                    if string.find(StatName, "DAMAGE") then
                        local Index = #Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"]
                        if string.find(StatName, "LIMB") and Index ~= 3 then
                            Index = Index - 1
                        end
                        Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] = Tables.Stats.WeaponStats[Variables.ShownWeapon]["damagerating"][Index] - StatPlacement.BigIncrement
                    else
                        local Projected = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.BigIncrement
                        if Projected <= 0 then
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = 0.01
                        else
                            Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] = Tables.Stats.WeaponStats[Variables.ShownWeapon][StatPlacement.Stat] - StatPlacement.BigIncrement
                        end
                    end
                end
                if Variables.ShownWeapon ~= nil and Variables.ShownWeapon ~= "" then
                    local ShownWeaponStats = Tables.Stats.WeaponStats[Variables.ShownWeapon]
                    for x,y in pairs(FrameClone:GetChildren()) do
                        if not string.find(y.Text, "DAMAGE") and string.find(y.Name, "line") and y.Name ~= "line1" and not string.find(y.Name, "more") and not string.find(y.Name, "less") then
                            local Space2 = string.find(y.Text, ": ")
                            local StatName2 = string.sub(y.Text, 2, Space2-1)
                            if ShownWeaponStats ~= nil and ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat] ~= nil then
                                y.Text = ">"..StatName2..": "..ShownWeaponStats[Tables.Conversions.NameToStat[StatName2].Stat]
                            else
                                y.Text = ">"..StatName2..": N/A"
                            end
                        end
                    end
                    if ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 2 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][1]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][2]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 3 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                    elseif ShownWeaponStats ~= nil and ShownWeaponStats["damagerating"] ~= nil and #ShownWeaponStats["damagerating"] == 4 then
                        FrameClone.line2.Text = ">LIMB_DAMAGE: "..ShownWeaponStats["damagerating"][3]
                        FrameClone.line3.Text = ">HEAD_DAMAGE: "..ShownWeaponStats["damagerating"][4]
                    end
                end
            end)

        end
    end
    local StatsChangeable = {
        ["Level"] = {
            ["Increment"] = 5;
            ["BigIncrement"] = 20;
        },
        ["XP"] = {
            ["Increment"] = 100;
            ["BigIncrement"] = 10000;
        },
        ["Prestige"] = {
            ["Increment"] = 1;
            ["BigIncrement"] = 20;
        },
        ["Tokens"] = {
            ["Increment"] = 1000;
            ["BigIncrement"] = 10000;
        },
        ["Bonds"] = {
            ["Increment"] = 100;
            ["BigIncrement"] = 10000;
        },
    }
    local CurrentStats = ServerStuff.retrieveStats:InvokeServer()
    local StatsFrame = Player.PlayerGui.mainHUD.TabMenu.bg.weaponinfotab.founditem:Clone()
    StatsFrame.Name = "Stats"
    StatsFrame.Parent = StatsTab
    StatsFrame.Visible = true
    StatsFrame.datafound.Text = "// CHANGE YOUR STATS HERE //"
    StatsFrame.line1.Text = ">CURRENT_STATS:"

    StatsFrame.line2.Text = "Level: "..tostring(CurrentStats["Level"])
    StatsFrame.line2.Name = "Level"
    StatsFrame.line2more.Name = "levelmore"
    StatsFrame.line2morebig.Name = "levelmorebig"
    StatsFrame.line2less.Name = "levelless"
    StatsFrame.line2lessbig.Name = "levellessbig"

    StatsFrame.line3.Text = "XP: "..tostring(CurrentStats["XP"])
    StatsFrame.line3.Name = "XP"
    StatsFrame.line3more.Name = "xpmore"
    StatsFrame.line3morebig.Name = "xpmorebig"
    StatsFrame.line3less.Name = "xpless"
    StatsFrame.line3lessbig.Name = "xplessbig"

    StatsFrame.line4.Text = "Prestige: "..tostring(CurrentStats["Prestige"])
    StatsFrame.line4.Name = "Prestige"
    StatsFrame.line4more.Name = "prestigemore"
    StatsFrame.line4morebig.Name = "prestigemorebig"
    StatsFrame.line4less.Name = "prestigeless"
    StatsFrame.line4lessbig.Name = "prestigelessbig"

    StatsFrame.line5.Text = "Tokens: "..tostring(CurrentStats["Tokens"])
    StatsFrame.line5.Name = "Tokens"
    StatsFrame.line5more.Name = "tokensmore"
    StatsFrame.line5morebig.Name = "tokensmorebig"
    StatsFrame.line5less.Name = "tokensless"
    StatsFrame.line5lessbig.Name = "tokenslessbig"


    StatsFrame.line6.Text = "Bonds: "..tostring(CurrentStats["Bonds"])
    StatsFrame.line6.Name = "Bonds"
    StatsFrame.line6more.Name = "bondsmore"
    StatsFrame.line6morebig.Name = "bondsmorebig"
    StatsFrame.line6less.Name = "bondsless"
    StatsFrame.line6lessbig.Name = "bondslessbig"

    for i,v in pairs(StatsFrame:GetChildren()) do
        if string.find(v.Name, "7") or string.find(v.Name, "8") or v.Name == "morebutton" then
            v:Destroy()
        end
    end
    for i,v in pairs(StatsFrame:GetChildren()) do
        v.Visible = true
        if string.find(string.lower(v.Name), "more") then
            v.MouseButton1Down:Connect(function()
                local StatName,bad = string.gsub(v.Name,"morebig","")
                StatName,bad = string.gsub(StatName,"more","")
                StatName = string.upper(string.sub(StatName,1,1))..string.sub(StatName,2,-1)
                if StatName == "Xp" then 
                    StatName = "XP" -- dumb fast fix that no one will ever see lmfao
                end
                if StatsChangeable[StatName] == nil then
                    warn("this should literally never happen LOL")
                    return
                end
                if string.find(v.Name, "big") then
                    local Data = {
	                  [1] = StatName,
	                  [2] = StatsChangeable[StatName]["BigIncrement"],
	                  [3] = nil,
	                  [4] = nil,
                    }
                    game.Workspace.ServerStuff.adjustStats:FireServer("stats", Data)
                else
                    local Data = {
	                  [1] = StatName,
	                  [2] = StatsChangeable[StatName]["Increment"],
	                  [3] = nil,
	                  [4] = nil,
                    }
                    game.Workspace.ServerStuff.adjustStats:FireServer("stats", Data)
                end
                task.wait()
                local NewStats = ServerStuff.retrieveStats:InvokeServer()
                for x,y in pairs(StatsFrame:GetChildren()) do
                    if NewStats[y.Name] then
                        y.Text = y.Name..": "..tostring(NewStats[y.Name])
                    end
                end
            end)
        elseif string.find(string.lower(v.Name), "less") then
            v.MouseButton1Down:Connect(function()
                local StatName,bad = string.gsub(v.Name,"lessbig","")
                StatName,bad = string.gsub(StatName,"less","")
                StatName = string.upper(string.sub(StatName,1,1))..string.sub(StatName,2,-1)
                if StatName == "Xp" then 
                    StatName = "XP" -- dumb fast fix that no one will ever see lmfao
                end
                if StatsChangeable[StatName] == nil then
                    warn("this should literally never happen LOL")
                    return
                end
                if string.find(v.Name, "big") then
                    local Data = {
	                  [1] = StatName,
	                  [2] = -StatsChangeable[StatName]["BigIncrement"],
	                  [3] = nil,
	                  [4] = nil,
                    }
                    game.Workspace.ServerStuff.adjustStats:FireServer("stats", Data)
                else
                    local Data = {
	                  [1] = StatName,
	                  [2] = -StatsChangeable[StatName]["Increment"],
	                  [3] = nil,
	                  [4] = nil,
                    }
                    game.Workspace.ServerStuff.adjustStats:FireServer("stats", Data)
                end
                task.wait()
                local NewStats = ServerStuff.retrieveStats:InvokeServer()
                for x,y in pairs(StatsFrame:GetChildren()) do
                    if NewStats[y.Name] then
                        y.Text = y.Name..": "..tostring(NewStats[y.Name])
                    end
                end
            end)
        end
    end
end

local function EspHandle(v)
    if v.Name == "ai_type" and v:IsA("StringValue") and Esp.EspInfo.Scavs[v.Value] ~= nil then
        repeat task.wait() until v.Parent == nil or v.Parent:FindFirstChild("Head")
        if string.find(v.Value, "Shadow") then
            local EspItem = Mark(v.Parent:FindFirstChild("Head"), Esp.EspInfo.Scavs[v.Value], Esp.EspInfo.Toggles.Demons)
            table.insert(Esp.EspObjects.Demons,EspItem)
        elseif v.Parent ~= nil then
            local EspItem = Mark(v.Parent:FindFirstChild("Head"), Esp.EspInfo.Scavs[v.Value], Esp.EspInfo.Toggles.Enemies)
            table.insert(Esp.EspObjects.Enemies,EspItem)
        end
        return
    end
    if v.Name == "Interact" then
        local Swag = v:FindFirstAncestorOfClass("Model")
        if Swag ~= nil and string.find(Swag.Name, "Locker") then
            local EspItem = Mark(v, Esp.EspInfo["Interactables"]["Locker"], Esp.EspInfo.Toggles["Locker"])
            table.insert(Esp.EspObjects["Locker"], EspItem)
        elseif Swag ~= nil and Esp.EspInfo["Interactables"][Swag.Name] ~= nil and Esp.EspInfo["Toggles"][Swag.Name] ~= nil then
            local EspItem = Mark(v, Esp.EspInfo["Interactables"][Swag.Name], Esp.EspInfo.Toggles[Swag.Name])
            table.insert(Esp.EspObjects[Swag.Name], EspItem)
        elseif string.find(Swag.Name, "Ammo") then
            local EspItem = Mark(v, Esp.EspInfo["Items"]["Ammo"], Esp.EspInfo.Toggles.Ammo)
            table.insert(Esp.EspObjects.Ammo, EspItem)
        end
    end
    if v.Name == "JointGrip" and v:FindFirstAncestor("WeaponDrops") then
        local Item = v:FindFirstAncestorOfClass("Model")
        if Item == nil or Tables.Stats.WeaponStats == nil then
            return
        end
        local Type = nil
        if Tables.Stats.WeaponStats[Item.Name] ~= nil and Tables.Stats.WeaponStats[Item.Name]["weapontype"] ~= nil then
            Type = Tables.Stats.WeaponStats[Item.Name]["weapontype"]
        else
            return
        end
        if Type == "Gun" then
            local EspItem = Mark(v, Esp.EspInfo.Items.Guns, Esp.EspInfo.Toggles.Guns)
            table.insert(Esp.EspObjects.Guns,EspItem)
        elseif Type ~= "Item" then
            local EspItem = Mark(v, Esp.EspInfo.Items.Melee, Esp.EspInfo.Toggles.Melee)
            table.insert(Esp.EspObjects.Melee,EspItem)
        else
            if string.sub(Item.Name, #Item.Name-2,-1) == "Aid" or Item.Name == "HStim" then
                local EspItem = Mark(v, Esp.EspInfo.Items.Health,Esp.EspInfo.Toggles.Health)
                table.insert(Esp.EspObjects.Health,EspItem)
            elseif string.sub(Item.Name, #Item.Name-3,-1) == "Stim" then
                local EspItem = Mark(v, Esp.EspInfo.Items.Stims, Esp.EspInfo.Toggles.Stims)
                table.insert(Esp.EspObjects.Stims,EspItem)
            elseif Item.Name == "BPack" then
                local EspItem = Mark(v, Esp.EspInfo.Items.Backpack, Esp.EspInfo.Toggles.Backpacks)
                table.insert(Esp.EspObjects.Backpacks,EspItem)
            elseif string.sub(Item.Name, 1,2) == "BP" then
                local EspItem = Mark(v, Esp.EspInfo.Items.Blueprints, Esp.EspInfo.Toggles.Blueprints)
                table.insert(Esp.EspObjects.Blueprints,EspItem)
            elseif Item.Name == "APack" then
                local EspItem = Mark(v, Esp.EspInfo.Items.BodyArmor, Esp.EspInfo.Toggles.BodyArmor)
                table.insert(Esp.EspObjects.BodyArmor,EspItem)
            elseif Tables.Stats.WeaponStats[Item.Name]["animset"] ~= nil and Tables.Stats.WeaponStats[Item.Name]["animset"] == "THRW" then
                local EspItem = Mark(v, Esp.EspInfo.Items.Throwable, Esp.EspInfo.Toggles.Throwable)
                table.insert(Esp.EspObjects.Throwable,EspItem)
            elseif table.find({"RExplosive","PMine","PTrap","SSnare"},Item.Name) then
                local EspItem = Mark(v, Esp.EspInfo.Items.Placeable, Esp.EspInfo.Toggles.Traps)
                table.insert(Esp.EspObjects.Traps,EspItem)
            end
        end
    end
end

local function RemoveMark(Child)
    if string.find(string.lower(Child.Name),"flag") then
        task.wait(0.1)
        Child.Parent = nil
    end
end;

local function ValidsAdded(Child)
    local Weapon = Child.Name
    if Tables.Stats.WeaponStats[Weapon] == nil then
        return
    end
    local Type = Tables.Stats.WeaponStats[Weapon].weapontype
    if Type ~= "Gun" then
        return
    end
    if Player.Character == nil or not Player.Character:FindFirstChild("ammo_folder") then
        return
    end
    task.wait(0.5)
    local AmmoType = Tables.Stats.WeaponStats[Weapon].ammoused
    if Player.Character["ammo_folder"]:FindFirstChild(AmmoType.." Ammo") and Player.Character["ammo_folder"][AmmoType.." Ammo"].Value < 100000 then
        spawn(function()
            game.Workspace.WeaponDrops.ChildAdded:Wait()
            for i,v in pairs(game.Workspace.WeaponDrops:GetChildren()) do
                if v.Name == Weapon then
                    local Part = v:WaitForChild("JointGrip")
                    if Player:DistanceFromCharacter(Part.Position) < 30 then
                        ServerStuff.getTPWeapon:FireServer(Weapon, AnimSet, "Fist", v, false)
                        Finished = true
                        break
                    end
                end
            end
        end)
        task.wait()
        ServerStuff.throwWeapon:FireServer(Weapon, nil, game.Workspace.CurrentCamera.CFrame, "drop", Tables.OriginalStats[Weapon], -9e9, false, _G.Code1, nil, _G.Code2)
    end
end

local function VirusChanged()
    if _G.EffectsTable == nil then
        GrabEssentials()
    end
    if Toggles.VirusBlock and Variables.VirusFrame ~= nil and _G.EffectsTable[Variables.VirusFrame.Name] ~= nil then
        _G.EffectsTable[Variables.VirusFrame.Name].effects.currentduration = tick()
    end
end;

local function StatusHandler(Child)
    if Child.Name == "play" and Child:FindFirstAncestor("menuGui") then
        local RTSStartButton = Child:Clone()
        RTSStartButton.Name = "rtsplay"
        RTSStartButton.Text = "RTS MODE"
        Child.Position = UDim2.new(1,-5,0.1,0)
        RTSStartButton.MouseButton1Click:Connect(function()
            StartRTS()
        end)
        RTSStartButton.Parent = Child.Parent
    end
    if Child.Name == "label" and Child.Parent.Name == "main" and Child:FindFirstAncestor("LowerHudFrame") then
        Variables.ClipLabel = Child
        return
    end
    if Child.Name == "cracked" and Child:FindFirstAncestor("goggles") then
        if Toggles.NoCooldown or Toggles.Godmode then
            task.wait()
            Child:Destroy()
        end
        return
    end
    if Child.Name == "Bar" and string.find(Child.Parent.Parent.Name, "Virus") then
        Variables.VirusFrame = Child.Parent.Parent
        Child.Changed:Connect(VirusChanged)
        return
    end
    if Child.Parent.Name == "Statuses" then
        if string.find(Child.Name, "Virus") then
            Variables.VirusFrame = Child
            return
        end
        if not Toggles.AntiDebuff then
            if not Toggles.AntiFallDamage then
                return
            elseif Toggles.AntiFallDamage and Child.Name ~= "Cripple" then
                return
            end
        end
        if Child.Name == "Tinnitus" and Child.Parent:FindFirstChild("Bottle Buff") then
            return
        end
        if _G.EffectsTable == nil then
            GrabEssentials()
        end
        repeat task.wait() until _G.EffectsTable ~= nil and _G.EffectsTable[Child.Name] ~= nil
        task.wait()
        if Child:IsA("Frame") and _G.EffectsTable ~= nil and _G.EffectsTable[Child.Name] ~= nil and not string.find(Child.Name,"Virus") then
            if _G.EffectsTable[Child.Name].effects ~= nil and _G.EffectsTable[Child.Name].effects.currentduration ~= nil and _G.EffectsTable[Child.Name].effects.colour ~= nil then
                if _G.EffectsTable[Child.Name].effects.colour == Color3.new(1,0.05,0.05) or _G.EffectsTable[Child.Name].effects.colour == false or Child.Name == "Burning" or Child.Name == "Exhaustion" then
                    _G.EffectsTable[Child.Name].effects.currentduration = 0
                end
            end
        end
        return
    end
    if Child.Name == "menuGui" and Toggles.AutoFarm then
        ServerStuff.changeStats:InvokeServer("changeclass", Variables.PreviousClass)
        task.wait(1)
        ServerStuff.spawnPlayer:FireServer("hubbing")
    end
end;

local function WorkspaceHandler(Child)
    EspHandle(Child)
    if Child:IsA("Model") and Child:FindFirstAncestor("FPArms") and Child.Name ~= "LeftArm" and Child.Name ~= "RightArm" then
        Variables.ShownWeapon = Child.Name
    end
    if Child:IsA("Model") and Child ~= Player.Character and Players:FindFirstChild(Child.Name) and Toggles.TeamKill then
        task.wait()
        Child.Parent = game.Workspace
    end
end

local function EnemyHandler(Child)
    if Child:IsA("Model") then
        local NpcValue = Child:WaitForChild("npc")
        if NpcValue.Value == nil then
            NpcValue.Changed:Wait()
        end
        local Model = NpcValue.Value
        if Toggles.AutoKill and Model:IsA("Model") then
            local Torso = Model:WaitForChild("Torso",20)
            local Humanoid = Model:WaitForChild("Humanoid",20)
            KnifeKill(Model,true)
            if Toggles.AutoFarm and ServerStuff:FindFirstChild("changeStats") then
                ServerStuff.changeStats:InvokeServer("prestigeplayer")
            end
            return
        end
    end
end

RenderStepped = function()
    if Toggles.ControlMode then
        if #game.Players:GetPlayers() > 1 and Player.PlayerGui:FindFirstChild("mainHUD") and #game.Workspace.activePlayers:GetChildren() == 1 then
            -- game.Workspace.activePlayers:FindFirstChild(Player.Name):BreakJoints()
        end
        if #Tables.ControlMode.SelectedNPCs > 0 then
            local RandomTarget = Tables.ControlMode.SelectedNPCs[math.random(1,#Tables.ControlMode.SelectedNPCs)]
            local Character = game.Workspace:FindFirstChild(Player.Name) or game.Workspace.activePlayers:FindFirstChild(Player.Name) or game.Workspace.speccingPlayers:FindFirstChild(Player.Name) or game.Workspace.playersWaiting:FindFirstChild(Player.Name)
            if Character ~= nil and Character:FindFirstChild("HumanoidRootPart") and RandomTarget:FindFirstChild("HumanoidRootPart") then
                Character.HumanoidRootPart.Position = RandomTarget.HumanoidRootPart.Position -- Vector3.new(0,10,0)
                --Character.HumanoidRootPart.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame
                --Character.HumanoidRootPart.HumanoidRootPart.Position = RandomTarget.HumanoidRootPart.Position - Vector3.new(0,10,0)
                --Character.HumanoidRootPart.HumanoidRootPart.Velocity = Character.HumanoidRootPart.Velocity
                --Character.Torso.Position = RandomTarget.HumanoidRootPart.Position - Vector3.new(0,10,0)
                --Character.Head.Position = RandomTarget.HumanoidRootPart.Position - Vector3.new(0,10,0)
                if Character.HumanoidRootPart:FindFirstChild("BodyPosition") then
                    Character.HumanoidRootPart.BodyPosition.Position = RandomTarget.HumanoidRootPart.Position - Vector3.new(0,10,0)
                end
            end
        else	
            local Character = game.Workspace:FindFirstChild(Player.Name) or game.Workspace.activePlayers:FindFirstChild(Player.Name) or game.Workspace.speccingPlayers:FindFirstChild(Player.Name) or game.Workspace.playersWaiting:FindFirstChild(Player.Name)
            if Character ~= nil and Character:FindFirstChild("HumanoidRootPart") and Character.HumanoidRootPart:FindFirstChild("HumanoidRootPart") then
                --Character.HumanoidRootPart.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame
                --Character.HumanoidRootPart.HumanoidRootPart.Position = Vector3.new(0,200,0)
                --Character.HumanoidRootPart.HumanoidRootPart.Velocity = Character.HumanoidRootPart.Velocity
            end
        end
        if Tables.ControlMode.MoveNPCsTo ~= Vector3.new(0,0,0) then
            for i,v in pairs(Tables.ControlMode.SelectedNPCs) do
                if v ~= nil and v:FindFirstAncestor("Workspace") and v:FindFirstChild("Humanoid") then
                    spawn(function()
                        -- Player.Character = v
                        -- v.Humanoid.WalkToPoint = Tables.ControlMode.MoveNPCsTo
                        v.Humanoid:MoveTo(Tables.ControlMode.MoveNPCsTo)
                    end)
                    if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("Drag") then
                        Drag.Position = Vector3.new(Tables.ControlMode.MoveNPCsTo.X,v.HumanoidRootPart.Position.Y,Tables.ControlMode.MoveNPCsTo.Z)
                    end
                end
            end
        end
    end
    if Tables.SuperRun.ShiftHeld == true and Toggles.SuperRun == true and Player.Character ~= nil and Player.Character:FindFirstChild("HumanoidRootPart") then
        if Tables.SuperRun.WHeld == true then
            Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-Tables.SuperRun.RunSpeed)
        end
        if Tables.SuperRun.SHeld == true then
            Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,Tables.SuperRun.RunSpeed)
        end
        if Tables.SuperRun.DHeld == true then
            Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(Tables.SuperRun.RunSpeed,0,0)
        end
        if Tables.SuperRun.AHeld == true then
            Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(-Tables.SuperRun.RunSpeed,0,0)
        end
    end
    if Toggles.KillAura then
        local Enemies = Players:GetChildren()
        for i = 1,#Enemies do
            if Enemies[i].ClassName ~= "Player" and Enemies[i]:FindFirstChild("npc") then
                local Character = Enemies[i].npc.Value
                if Character ~= nil and Character:FindFirstChild("Torso") and Player:DistanceFromCharacter(Character.Torso.Position) <= Variables.KillAuraDistance then
                    KnifeKill(Character)
                end
            end
        end
        return
    end
    if Toggles.AntiVoteKick then
        local PlayerList = {}
        for i,v in pairs(Players:GetPlayers()) do
            if v ~= Player then
                table.insert(PlayerList,v)
            end
        end
        if #PlayerList > 1 then
            local Target = PlayerList[math.random(0,#PlayerList)]
            if Target ~= nil then
                Players:Chat("votekick/"..Target.Name)
            end
        end
    end
    if Toggles.LoopDrop and not Debounces.LoopDrop and Variables.ToLoopDrop ~= "" then
        local Current = ToLoopDrop
        Debounces.LoopDrop = true
        if Tables.Stats.WeaponStats[Variables.ToLoopDrop] == nil then
            return
        end
        local AnimSet = game:GetService("ReplicatedStorage").animationSets.TPanimSets:FindFirstChild(Tables.Stats.WeaponStats[Variables.ToLoopDrop].animset)
        local Type = Tables.Stats.WeaponStats[Variables.ToLoopDrop].weapontype
        local Uses = 1
        local ToDropStats = Tables.Stats.WeaponStats[Variables.ToLoopDrop]
        local NewStatsTable = {}
        if Type == "Gun" and game.ReplicatedStorage.Weapons:FindFirstChild(Variables.ToLoopDrop) and game.ReplicatedStorage.Weapons[Variables.ToLoopDrop]:FindFirstChild("ammo") then
            Uses = game.ReplicatedStorage.Weapons[Variables.ToLoopDrop].ammo.Value
        end
        game.Workspace.ServerStuff.getTPWeapon:FireServer(Variables.ToLoopDrop, AnimSet, "Fist", nil, false)
        repeat task.wait() until Player.Character:FindFirstChild(Variables.ToLoopDrop) or Variables.ToLoopDrop == "" or Variables.ToLoopDrop ~= Current
        local cframe = CFrame.new(381.598999, -1.04327154, -48.8513374, -0.0525665507, -0.320858359, 0.945667326, -7.67457823e-05, 0.946977854, 0.321298748, -0.99861747, 0.0168169905, -0.0498039834)
        workspace.ServerStuff.throwWeapon:FireServer(Variables.ToLoopDrop, nil, cframe, "drop", Tables.OriginalStats[Variables.ToLoopDrop], Uses, false, _G.Code1, nil, _G.Code2)
        task.wait(0.3)
        Debounces.LoopDrop = false
    end
end

local function CharacterLoaded(Character)
    _G.Code1 = nil
    _G.Code2 = nil
    local Head = Character:WaitForChild("Head",100)
    local Humanoid = Character:WaitForChild("Humanoid",100)
    local ClassValue = Character:WaitForChild("current_perk")
    spawn(function()
        wait(2)
        local GUI = Player.PlayerGui:WaitForChild("mainHUD",20)
        if GUI ~= nil and Toggles.ControlMode then
            StartRTS(true)
        end
    end)
    Variables.PreviousClass = Character["current_perk"].Value
    if Toggles.TeamKill then
        ServerStuff.changeStats:InvokeServer("changeclass", "revolver")
    end
    Humanoid.Died:Connect(function()
        ServerStuff.changeStats:InvokeServer("changeclass", Variables.PreviousClass)
    end)
    local Valids = Character:WaitForChild("valids")
    Valids.ChildAdded:Connect(ValidsAdded)
    if Toggles.Godmode then
        if Variables.HealthChangedConnection ~= nil then
            Variables.HealthChangedConnection:Disconnect()
        end
        Variables.HealthChangedConnection = Humanoid.HealthChanged:Connect(Heal)
    end
    Head.ChildAdded:Connect(RemoveMark)
    for i,v in pairs(Head:GetChildren()) do
        RemoveMark(v)
    end
    GrabEssentials()
    SetupGUI()
    if Toggles.AutoParry then
        repeat task.wait() until _G.Code1 ~= nil
        game.Workspace.ServerStuff.initiateblock:FireServer(_G.Code1, true)
    end
end;

-- META FUNCTIONS --

newindex = hookmetamethod(game, "__newindex", function(self, index, value)
    if self == Camera and not checkcaller() then
        if Index == "CFrame" and Toggles.LockCamera then
            return
        end
        if Toggles.ControlMode and index == "CFrame" or Toggles.ControlMode and index == "Focus" then
            return
        end
    end
    if Toggles.ControlMode and self == Player and index == "CameraMode" and not checkcaller() then
        return
    end
    return newindex(self, index, value)
end)

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Method = getnamecallmethod()
    if Method == "Destroy" and Toggles.ControlMode then
        if self == Player.PlayerGui.FindFirstChild(Player.PlayerGui,"mainHUD") or self == Player.PlayerGui.FindFirstChild(Player.PlayerGui,"menuGui") or self == Player.PlayerGui.FindFirstChild(Player.PlayerGui,"endgamegui") then
            return
        end
    end
    if Method == "FireServer" or Method == "InvokeServer" then
        local Args = {...}
        local RemoteName = tostring(self)
        if RemoteName == "callEvent" and Args[1] ~= "poke" and Args[1] ~= "self_gun" then
            return
        end
        if Toggles.AutoParry and RemoteName == "initiateblock" and not checkcaller() then
            if Args[2] ~= nil and Args[2] == false then
                return
            end
        end
        if RemoteName == "throwWeapon" then
            if typeof(Args[5]) == "table" and Args[5]["name"] ~= nil and Tables.OriginalStats[Args[1]] ~= nil then
                Args[5] = Tables.OriginalStats[Args[1]]
                return namecall(self, unpack(Args))
            end
        end
        if RemoteName == "dealDamage" then
            if Toggles.AntiFallDamage and Args[1] == "fall_damage" then
                return
            end
            if Toggles.AntiDebuff and table.find(Tables.Lists.DamageTypes,Args[1]) or Toggles.SilentAim and Args[1] == "gundamage" then
                return
            end
            if typeof(Args[1]) == "table" and typeof(Args[1][10]) == "table" and Args[1][10]["name"] ~= nil and Args[1][5] ~= nil and Tables.OriginalStats[Args[1][5]] ~= nil then
                Args[1][10] = Tables.OriginalStats[Args[1][5]]
            end
            if Toggles.TeamKill and typeof(Args[1]) == "table" then
                local DamageType = Args[1][1]
                if DamageType ~= "meleedamage" and DamageType ~= "gundamage" then
                    return namecall(self, ...)
                end
                local Model = Args[1][2]
                local Part = Args[1][9]
                local CurrentWeapon = Args[1][5]
                local CurrentStats = Args[1][10] or Table.OriginalStats.Fist
                local CurrentDamageRating = CurrentStats.damagerating
                if Model == nil or Part == nil or not Part.FindFirstAncestor(Part,Model.Name) or not Players.FindFirstChild(Players,Model.Name) or CurrentWeapon == nil or CurrentStats == nil or CurrentDamageRating == nil then
                    return namecall(self, ...)
                end
                if DamageType == "meleedamage" then
                    if Part.Name == "Head" then
                        ServerStuff.dealDamage.FireServer(ServerStuff.dealDamage,"revolver_shot", {Model,CurrentDamageRating[2]}, _G.Code1, _G.Code2)
                    else
                        ServerStuff.dealDamage.FireServer(ServerStuff.dealDamage,"revolver_shot", {Model,CurrentDamageRating[1]}, _G.Code1, _G.Code2)
                    end
                else
                    if Part.Name == "Head" then
                        ServerStuff.dealDamage.FireServer(ServerStuff.dealDamage,"revolver_shot", {Model,CurrentDamageRating[4]}, _G.Code1, _G.Code2)
                    else
                        ServerStuff.dealDamage.FireServer(ServerStuff.dealDamage,"revolver_shot", {Model,CurrentDamageRating[1]}, _G.Code1, _G.Code2)
                    end
                end
            end
            if Toggles.OneShot and typeof(Args[1]) == "table" and Args[1][1] ~= nil and string.find(tostring(Args[1][1]), "damage") and not checkcaller() then
                local Model = Args[1][2]
                if typeof(Model) == "Instance" and Model.FindFirstChild(Model, "Humanoid") and Args[1][3] ~= nil and Args[1][3] ~= "shove" then
                    local WeaponInfo = Tables.OriginalStats[Args[1][5]] or nil
                    local WeaponType = "Fists"
                    if WeaponInfo ~= nil then
                        WeaponType = WeaponInfo.weapontype
                    end
                    for i = 1,math.floor((Model.Humanoid.Health/Args[1][3])) + 1 do
                        if WeaponType == "Gun" then
                            ServerStuff.dealDamage.FireServer(ServerStuff.dealDamage,"gunsareloud", nil, _G.Code1, _G.Code2)
                        end
                        self.FireServer(self, unpack(Args))
                    end
                end
            end
            return namecall(self, unpack(Args))
        end
        if RemoteName == "applyGore" and not checkcaller() then
            if string.find(tostring(Args[1]), "fire") and Args[4] ~= nil and typeof(Args[4]) == "table" and #Args[4] <= 2 then
                return namecall(self, unpack(Args))
            end
            if Toggles.SilentAim and string.find(tostring(Args[1]), "fire") and Player.Character ~= nil and _G.Code1 ~= nil and _G.Code2 ~= nil then
                local CurrentWeapon = Player.Character.FindFirstChildOfClass(Player.Character,"Model")
                local Target = GetClosest()
                if Target == nil or CurrentWeapon == nil then
                    return namecall(self, ...)
                end
                CurrentWeapon = CurrentWeapon.Name
                if Tables.OriginalStats[CurrentWeapon] == nil then
                    return namecall(self, ...)
                end
                local Damage = Tables.OriginalStats[CurrentWeapon].damagerating[4] or Tables.OriginalStats[CurrentWeapon].damagerating[3]
                local FiringArgs = {
                    [1] = "gundamage",
                    [2] = Target,
                    [3] = Damage,
                    [4] = true,
                    [5] = CurrentWeapon,
                    [6] = false,
                    [7] = false,
                    [8] = {},
                    [9] = Target.Torso,
                    [10] = Tables.OriginalStats[CurrentWeapon]
                }
                if not Toggles.OneShot then
                    ServerStuff.dealDamage.FireServer(game.Workspace.ServerStuff.dealDamage, FiringArgs, nil, _G.Code1, _G.Code2)
                else
                    for i = 1,math.floor((Target.Humanoid.Health/Damage)) + 1 do
                        ServerStuff.dealDamage.FireServer(ServerStuff.dealDamage, FiringArgs, nil, _G.Code1, _G.Code2)
                    end
                end
            end
        end
    end
    return namecall(self, ...)
end)

game:GetService("Lighting").Changed:Connect(function()
    if Toggles.ControlMode or Toggles.NoFog then
        game.Lighting.FogEnd = 1000000000000000
    end
end)

local Commands = {
    --[[
    template = {
        Aliases = {};
        Description = "";
        Function = function(Enabling,Args)
            Toggles.COMMAND = Enabling
            local currenttext = ""
            if Enabling == true then
                currenttext = "COMMAND is now ON!"
            else
                currenttext = "COMMAND is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    --]]
    cig = {
        Aliases = {"cig","ciggy","cigarette","smoke"};
        Description = "Literally the most important command.";
        Function = function(Enabling,Args)
            local currenttext = ""
            if Enabling == true then
                local Cig = game.ReplicatedStorage.auxItems.buffermodel:Clone()
                Cig.CFrame = game.Workspace.CurrentCamera.CFrame
                Cig.Parent = game.Workspace.CurrentCamera
                local Motor = Instance.new("Motor6D")
                Motor.Part0 = Cig
                Motor.Part1 = game.Workspace.CurrentCamera:FindFirstChildOfClass("Part")
                Motor.C1 = CFrame.new(0, -0.8, -0.7) * CFrame.Angles(0, math.rad(90), 0)
                Motor.Parent = Cig
                game.Workspace.ServerStuff.quickDisplay:FireServer("add_buffer")
                repeat task.wait() until Player.Character ~= nil
                repeat task.wait() until Player.Character:FindFirstChild("Head")
                repeat task.wait() until Player.Character.Head:FindFirstChild("buffer_head")
                Player.Character.Head:FindFirstChild("buffer_head"):Destroy()
                currenttext = "You're now cool as hell"
            else
                if game.Workspace.CurrentCamera:FindFirstChild("buffermodel") then
                    game.Workspace.CurrentCamera.buffermodel:Destroy()
                end
                currenttext = "You're no longer cool"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    god = {
        Aliases = {"god","godmode","semigodmode","semigod","sgod","regen","instantregen","instaregen"};
        Description = "Regenerates lost health upon taking damage.";
        Function = function(Enabling,Args)
            Toggles.Godmode = Enabling
            local currenttext = ""
            if Enabling == true then
                Heal()
                if Variables.HealthChangedConnection == nil and Player.Character ~= nil and Player.Character:FindFirstChild("Humanoid") then
                    Variables.HealthChangedConnection = Player.Character.Humanoid.HealthChanged:Connect(Heal)
                end
                currenttext = "God-Mode is now ON!"
            else
                if Variables.HealthChangedConnection ~= nil then
                    Variables.HealthChangedConnection:Disconnect()
                    Variables.HealthChangedConnection = nil
                end
                currenttext = "God-Mode is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    heal = {
        Aliases = {"heal","fullheal","maxhealth","recover"};
        Description = "Recovers all your lost health.";
        Function = function(Enabling,Args)
            Heal()
            if _G.EffectsTable == nil then
                GrabEssentials()
            end
            for i,v in pairs(_G.EffectsTable) do
                if not string.find(i, "Virus") and v.effects ~= nil and v.effects.currentduration ~= nil and v.effects.colour ~= nil then
                    if v.effects.colour == Color3.new(1,0.05,0.05) or v.effects.colour == false or i == "Burning" or i == "Exhaustion" then
                        v.effects.currentduration = 0
                    end
                end
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Healed!";
                Text = "Nice and healthy.";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    cleareffects = {
        Aliases = {"cleareffects","clear","removedebuffs","fix","effects","removeeffects"};
        Description = "Removes all your current negative ailments.";
        Function = function(Enabling,Args)
            for i,v in pairs(_G.EffectsTable) do
                if not string.find(i, "Virus") and v.effects ~= nil and v.effects.currentduration ~= nil and v.effects.colour ~= nil then
                    if v.effects.colour == Color3.new(1,0.05,0.05) or v.effects.colour == false or i == "Burning" or i == "Exhaustion" then
                        v.effects.currentduration = 0
                    end
                end
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Removed debuffs!";
                Text = "Nice and healthy.";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    antidebuff = {
        Aliases = {"defectblock","disabilityblock","debuffsblock","nodebuffs","antidebuff","antidebuffs","nodebuff","noeffects","nobleed"};
        Description = "Removes debuffs as they're added.";
        Function = function(Enabling,Args)
            Toggles.AntiDebuff = Enabling
            local currenttext = ""
            if Enabling == true then
                if _G.EffectsTable == nil then
                    GrabEssentials()
                end
                for i,v in pairs(_G.EffectsTable) do
                    if not string.find(i, "Virus") and v.effects ~= nil and v.effects.currentduration ~= nil and v.effects.colour ~= nil and typeof(v.effects) ~= "Color3" then
                        if v.effects.colour == Color3.new(1,0.05,0.05) or v.effects.colour == false or i == "Burning" or i == "Exhaustion" then
                            v.effects.currentduration = 0
                        end
                    end
                end
                currenttext = "AntiDebuff is now ON!"
            else
                currenttext = "AntiDebuff is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    novirus = {
        Aliases = {"antivirus","infection","stopinfection","haltinfection","virus","novirus","blockvirus","stopvirus","haltvirus","uninfection","stopinfection","virusblock"};
        Description = "Blocks your virus from progressing.";
        Function = function(Enabling,Args)
            Toggles.VirusBlock = Enabling
            local currenttext = ""
            if Enabling == true then
                if _G.EffectsTable == nil then
                    GrabEssentials()
                end
                for i,v in pairs(_G.EffectsTable) do
                    if string.find(i, "Virus") then
                        _G.EffectsTable[i].effects.currentduration = tick()
                    end
                end
                currenttext = "VirusBlock is now ON!"
            else
                currenttext = "VirusBlock is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    resetvirus = {
        Aliases = {"resetvirus","pill","pills","resetinfection","restartvirus","restartinfection","virusprogress","infectionprogress"};
        Description = "Resets your virus's progression.";
        Function = function(Enabling,Args)
            if _G.EffectsTable == nil then
                GrabEssentials()
            end
            for i,v in pairs(_G.EffectsTable) do
                if string.find(i, "Virus") then
                    _G.EffectsTable[i].effects.currentduration = tick()
                end
            end
        end;
    };
    nocooldown = {
        Aliases = {"nocooldown","removecooldown","nocool","instantcharge","movespam","spammoves","spamspecial","cooldown"};
        Description = "Removes the cooldowns for most perk related specials.";
        Function = function(Enabling,Args)
            if Args.Command == "cooldown" then
                Enabling = false
            end
            Toggles.NoCooldown = Enabling
            if Player.Character == nil or not Player.Character:FindFirstChild("current_perk") then
                return
            end
            local CurrentPerk = Player.Character["current_perk"].Value
            local currenttext = ""
            if Enabling == true then
                if Tables.OriginalStats[CurrentPerk] == nil then
                    local NewTable = {}
                    for i,v in pairs(Tables.Stats.ClassStats[CurrentPerk].activestats) do
                        NewTable[i] = v
                    end
                    Tables.OriginalStats[CurrentPerk] = NewTable
                end
                local activestats = Tables.Stats.ClassStats[CurrentPerk].activestats
                for x,y in pairs(activestats) do
                    if string.find(tostring(x),"cooldown") then
                        if activestats["kiramaxdamage"] ~= nil then
                            if tostring(x) == "mincooldown" then
                                activestats[x] = 0.1
                            elseif tostring(x) == "cooldown" then
                                activestats[x] = 1
                            end
                        else
                            if activestats["inverse_cd"] == nil then
                                activestats[x] = 0
                            else
                                activestats[x] = math.huge
                            end
                        end
                    end
                    if x == "perk_mincd" or x == "vulka_ammo_usage" or string.find(tostring(x),"overheat") or x == "goggle_broken_cd" or x == "damage_taken_multi" then
                        activestats[x] = 0
                    end
                end
                currenttext = "NoCooldown is now ON!"
            else
                if Tables.OriginalStats[CurrentPerk] == nil then
                    return
                end
                for i,v in pairs(Tables.OriginalStats[CurrentPerk]) do
                    Tables.Stats.ClassStats[CurrentPerk].activestats[i] = v
                end
                currenttext = "NoCooldown is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    antirecoil = {
        Aliases = {"nocamerashake","norecoil","anticamerashake","norecoil","noshake","antishake"};
        Description = "Completely removes shaking and recoil when you shoot.";
        Function = function(Enabling,Args)
            Toggles.AntiRecoil = Enabling
            local currenttext = ""
            if Enabling == true then
                for i,v in pairs(Tables.Stats.WeaponStats) do
                    if v["weapontype"] ~= nil and v.weapontype == "Gun" and Tables.OriginalStats[i] ~= nil then
                        v["woundrating"] = 0
                    end
                end
                currenttext = "AntiRecoil is now ON!"
            else
                for i,v in pairs(Tables.Stats.WeaponStats) do
                    if v["weapontype"] ~= nil and v.weapontype == "Gun" and Tables.OriginalStats[i] ~= nil then
                        local ToSet = tonumber(Tables.OriginalStats[i].woundrating)
                        v["woundrating"] = ToSet
                    end
                end
                currenttext = "AntiRecoil is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    antispread = {
        Aliases = {"nospread","accuracy","infaccuracy","infiniteaccuracy","noinaccuracy","spread","nohipfirespread"};
        Description = "Removes spread when you shoot";
        Function = function(Enabling,Args)
            Toggles.AntiSpread = Enabling
            local currenttext = ""
            if Enabling == true then
                for i,v in pairs(Tables.Stats.WeaponStats) do
                    if v["sizerating"] ~= nil and v.weapontype == "Gun" and Tables.OriginalStats[i] ~= nil then
                        v["sizerating"] = 0.001
                    end
                end
                currenttext = "AntiSpread is now ON!"
            else
                for i,v in pairs(Tables.Stats.WeaponStats) do
                    if v["sizerating"] ~= nil and v.weapontype == "Gun" and Tables.OriginalStats[i] ~= nil then
                        local ToSet = tonumber(Tables.OriginalStats[i].sizerating)
                        v["sizerating"] = ToSet
                    end
                end
                currenttext = "AntiSpread is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    nofalldamage = {
        Aliases = {"nofall","nofalldamage","antifalldamage","antifall"};
        Description = "Blocks fall damage and broken legs.";
        Function = function(Enabling,Args)
            Toggles.AntiFallDamage = Enabling
            local currenttext = ""
            if Enabling == true then
                currenttext = "AntiFallDamage is now ON!"
            else
                currenttext = "AntiFallDamage is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    superrun = {
        Aliases = {"superrun","superspeed","fasterrun","speed","run","supersprint"};
        Description = "Makes your run super-speed";
        Function = function(Enabling,Args)
            Toggles.SuperRun = Enabling
            local currenttext = ""
            if Enabling == true then
                if Variables.RenderStepConnection == nil then
                    Variables.RenderStepConnection = game:GetService("RunService").Stepped:Connect(RenderStepped)
                end
                currenttext = "SuperRun is now ON!"
            else
                StopLoops()
                currenttext = "SuperRun is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    nohunger = {
        Aliases = {"nohunger","nodrink","noeat","nothirst","permfill"};
        Description = "Fills your both of your nutrition bars permanently.";
        Function = function(Enabling,Args)
            Toggles.NoHunger = Enabling
            local currenttext = ""
            if Enabling == true then
                _G.FoodTable.hunger = math.huge
                _G.FoodTable.thirst = math.huge
                currenttext = "NoHunger is now ON!"
            else
                _G.FoodTable.hunger = tick()
                _G.FoodTable.thirst = tick()
                currenttext = "NoHunger is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    fill = {
        Aliases = {"fill","eat","drink","satiate","fillhunger","fillstomach"};
        Description = "Fills your both of your nutrition bars to max.";
        Function = function(Enabling,Args)
            _G.FoodTable.hunger = tick()
            _G.FoodTable.thirst = tick()
            game.StarterGui:SetCore("SendNotification", {
                Title = "No longer hungry!";
                Text = "If only this command worked irl.";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    infstamina = {
        Aliases = {"stamina","noexhaust","noexhaustion","infrun","infstam","infinitestamina","infiniterun","infinitestam","stam"};
        Description = "Gives you infinite stamina";
        Function = function(Enabling,Args)
            Toggles.InfStamina = Enabling
            local currenttext = ""
            local TempEnv = getsenv(GrabMainScript())
            local StaminaFrame = Player.PlayerGui.mainHUD.StaminaFrame
            if TempEnv == nil or StaminaFrame == nil then
                return
            end
            local UpValues = getupvalues(TempEnv.afflictstatus)
            if Enabling == true then
                TempEnv["exhaustion_immunity"] = true
                for i,v in pairs(UpValues) do
                    if v == tonumber(StaminaFrame.TextLabel.Text) or v == tonumber(StaminaFrame.max.Text) then
                        setupvalue(TempEnv.afflictstatus,i,99999)
                    end
                end
                StaminaFrame.TextLabel.Text = 99999
                StaminaFrame.max.Text = 99999
                currenttext = "InfStamina is now ON!"
            else
                TempEnv["exhaustion_immunity"] = false
                local ToSet = 100
                if TempEnv.playerperks ~= nil and TempEnv.playerperks["lungs"] ~= nil then
                    ToSet = 150
                end
                for i,v in pairs(UpValues) do
                    if v == tonumber(StaminaFrame.TextLabel.Text) or v == tonumber(StaminaFrame.max.Text) then
                        setupvalue(TempEnv.afflictstatus,i,ToSet)
                    end
                end
                StaminaFrame.TextLabel.Text = ToSet
                StaminaFrame.max.Text = ToSet
                currenttext = "InfStamina is now OFF!"
            end
            TempEnv = nil
            UpValues = nil
            StaminaFrame = nil
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    autoparry = {
        Aliases = {"autoparry","antimelee","meleeblock","meleecuck","antihit","autoblock"};
        Description = "Automatically parries incoming melee attacks.";
        Function = function(Enabling,Args)
--[[
            Toggles.AutoParry = Enabling
            local currenttext = ""
            if Enabling == true then
                game.Workspace.ServerStuff.initiateblock:FireServer(_G.Code1, true)
                currenttext = "AutoParry is now ON!"
            else
                game.Workspace.ServerStuff.initiateblock:FireServer(_G.Code1, false)
                currenttext = "AutoParry is now OFF!"
            end
--]]
            game.StarterGui:SetCore("SendNotification", {
                Title = "ERROR";
                Text = "Autoparry now autoparries while holding the R key";
                Icon = "rbxassetid://2541869220";
                Duration = 7;
            })
        end;
    };
    killaura = {
        Aliases = {"killaura","murderaura","proximitykill","closekill","killclose"};
        Description = "Kills anyone stupid enough to get close to you. (Do :killaura NUMBER to set the killaura distance to NUMBER)";
        Function = function(Enabling,Args)
            local Amount = tonumber(Args[1]) or tonumber(Args[2])
            if Amount ~= nil then
                Variables.KillAuraDistance = Amount
                game.StarterGui:SetCore("SendNotification", {
                    Title = "notification";
                    Text = "KillAura distance is now "..tostring(Amount);
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                return
            end
            Toggles.KillAura = Enabling
            local currenttext = ""
            if Enabling == true then
                if Variables.RenderStepConnection == nil then
                    Variables.RenderStepConnection = game:GetService("RunService").Stepped:Connect(RenderStepped)
                end
                currenttext = "KillAura is now ON!"
            else
                StopLoops()
                currenttext = "KillAura is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    autokill = {
        Aliases = {"autokill","autokillenemies","automurder","moneyfarm","autoclearenemies","autothreatclear","autowin","autofarm"};
        Description = "Automatically kills any enemies that spawn.";
        Function = function(Enabling,Args)
            Toggles.AutoKill = Enabling
            local currenttext = ""
            if Enabling == true then
                for i,v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Torso") and v:FindFirstChild("Humanoid") then
                        if v.Parent.Name == "activeHostiles" or v.Parent.Name == "NoTarget" then
                            KnifeKill(v,true)
                        end
                    end
                end
                currenttext = "AutoKill is now ON!"
            else
                currenttext = "AutoKill is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    killenemies = {
        Aliases = {"killenemies","killall","removeenemies","killothers","enemykill","clearenemies","clearhazards","enemieskill"};
        Description = "Kills every enemy on the map. (Do :killenemies NUMBER to kill enemies withing NUMBER studs)";
        Function = function(Enabling,Args)
            local Amount = tonumber(Args[1]) or math.huge
            for i,v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Torso") and v:FindFirstChild("Humanoid") and Player:DistanceFromCharacter(v.Torso.Position) <= Amount then
                    if v.Parent.Name == "activeHostiles" or v.Parent.Name == "NoTarget" then
                        KnifeKill(v,true)
                    end
                end
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = "Killed all enemies!";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    backpack = {
        Aliases = {"equipbackpack","backpack","enablebackpack","expandinventory","addbackpack"};
        Description = "Gives you 2 more inventory slots.";
        Function = function(Enabling,Args)
            Player.PlayerGui.mainHUD.InventoryFrame.slot6.Visible = true;
            Player.PlayerGui.mainHUD.InventoryFrame.slot5.Visible = true;
            _G.InvTable[5] = { "Fist", false, nil }
            _G.InvTable[6] = { "Fist", false, nil }
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = "Equipped backpack.";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    weaponnames = {
        Aliases = {"spawn","give","giveitem","spawnitem","giveme","gunspawn","spawngun"};
        Description = "Prints a list of every weapon name to the dev console";
        Function = function(Enabling,Args)
            warn("====== WEAPON NAMES ======")
            for i,v in pairs(Tables.Lists.Weapons) do
                warn(i)
            end
            warn("==========================")
        end;
    };
    infaux = {
        Aliases = {"infaux","auxinf","infauxiliary","aux","auxiliary"};
        Description = "Gives you infinite aux equip uses.";
        Function = function(Enabling,Args)
            Toggles.InfAux = Enabling
            local currenttext = ""
            if Enabling == true then
                currenttext = "InfAux is now ON!"
            else
                local Env = getsenv(GrabMainScript())
                Env["aux_usage"] = 1
                currenttext = "InfAux is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    settrap = {
        Aliases = {"settrap","trapset","picktrap","setrap"};
        Description = "Sets the trap placed with the U key.";
        Function = function(Enabling,Args)
            if Args[1] == nil then
                return
            end
            for i,v in pairs(Tables.Lists.Traps) do
                if string.sub(string.lower(i),1,#Args[1]) == string.lower(Args[1]) then
                    Variables.CurrentTrap = v
                    break
                end
            end
            if not Player.Character.valids:FindFirstChild(Tables.Conversions.TrapToItemName[Variables.CurrentTrap]) then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "FAILED";
                    Text = "Spawn the thing you want to set at least once first";
                    Icon = "rbxassetid://2541869220";
                    Duration = 4;
                })
                return
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = "Trap type set to "..string.lower(Variables.CurrentTrap);
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    setthrowable = {
        Aliases = {"setthrowable","throwableset","pickthrowable","sethrowable","setthrow","throwset","pickthrow","sethrow","setykey","ykey"};
        Description = "Sets the item that's thrown when you press the Y key.";
        Function = function(Enabling,Args)
            if Args[1] == nil then
                return
            end
            Toggles.ThrowingKnives = false
            local TrapTitle = ""
            for i,v in pairs(Tables.Lists.Throwables) do
                if string.sub(string.lower(i),1,#Args[1]) == string.lower(Args[1]) then
                    Variables.CurrentThrowable = v
                    Variables.TrapTitle = i
                    break
                end
            end
            if Player.Character == nil or not Player.Character:FindFirstChild("valids") then
                return
            end
            if Variables.CurrentThrowable ~= "Nothing" and not Player.Character.valids:FindFirstChild(Variables.CurrentThrowable) then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "FAILED";
                    Text = "Spawn the thing you want to set at least once first";
                    Icon = "rbxassetid://2541869220";
                    Duration = 4;
                })
                return
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = "Throwable type set to "..string.lower(Variables.TrapTitle);
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    antivotekick = {
        Aliases = {"antivotekick","antivk","novk","vkblock","votekickblock","blockvotekick","novotekick","blockvk"};
        Description = "Spams votekicks on random players, so one can't be started on you.";
        Function = function(Enabling,Args)
            Toggles.AntiVoteKick = Enabling
            local currenttext = ""
            if Enabling == true then
                if Variables.RenderStepConnection == nil then
                    Variables.RenderStepConnection = game:GetService("RunService").Stepped:Connect(RenderStepped)
                end
                currenttext = "AntiVoteKick is now ON!"
            else
                StopLoops()
                currenttext = "AntiVoteKick is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    spawn = {
        Aliases = {"spawn","give","giveitem","spawnitem","giveme","gunspawn","spawngun"};
        Description = "Spawns an item.";
        Function = function(Enabling,Args)
            if Args[1] == nil then
                return
            end
            if Args[2] ~= nil then
                Args[1] = Args[1].." "..Args[2]
            end
            if Args[3] ~= nil then
                Args[1] = Args[1].." "..Args[3]
            end
            if Variables.Spawning == true then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Still spawning an item";
                    Text = "Wait for your first item to spawn before starting another";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                return
            end
            Variables.Spawning = true
            if game.Workspace.InteractablesNoDel:FindFirstChild("Personal Workbench") then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Holdout mode, eh?";
                    Text = "Initiating spawning for holdout mode.";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(game.Workspace.InteractablesNoDel:FindFirstChild("Personal Workbench"), "buybaseupgrade", _G.Code1)
                game.Workspace.InteractablesNoDel:WaitForChild("Workbench",10)
            end
            local Type = ""
            local Weapon = ""
            local WorkBench = workspace.Interactables:FindFirstChild("Workbench") or workspace.InteractablesNoDel:FindFirstChild("Workbench")
            for i,v in pairs(Tables.Lists.Weapons) do
                if string.sub(string.lower(i),1,#Args[1]) == string.lower(Args[1]) and Tables.Stats.WeaponStats[v] ~= nil or string.lower(i) == string.lower(Args[1]) and Tables.Stats.WeaponStats[v] ~= nil then
                    Weapon = v
                    Type = Tables.Stats.WeaponStats[v].weapontype
                end
            end
            if Tables.Lists.Weapons[string.lower(Args[1])] ~= nil and Tables.Stats.WeaponStats[Tables.Lists.Weapons[string.lower(Args[1])]] ~= nil then
                Weapon = Tables.Lists.Weapons[Args[1]]
                Type = Tables.Stats.WeaponStats[Tables.Lists.Weapons[string.lower(Args[1])]].weapontype
            end
            if Weapon == "" then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Failed";
                    Text = "Invalid weapon";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                Variables.Spawning = false
                return
            end
            if Type ~= "Gun" and Type ~= "Item" and Type ~= "Bow" and _G.InvTable[1][1] ~= "Fist" then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "notification";
                    Text = "You need to drop your current melee weapon before spawning another one!";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                Variables.Spawning = false
                return
            end
            local SlotFound = false
            for x,y in pairs(_G.InvTable) do
                if x ~= 1 and y[1] == "Fist" then
                    SlotFound = true
                end
            end
            if not SlotFound then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "notification";
                    Text = "NO AVAILABLE SLOTS (DROP SOMETHING)";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                Variables.Spawning = false
                return
            end
            if Player.Character == nil or not Player.Character:FindFirstChild("valids") then
                Variables.Spawning = false
                return
            end
            if Player.Character.valids:FindFirstChild(Weapon) then
                if Type == "Gun" or Type == "Item" or Type == "Bow" then
                    local MaxAmmo = 1
                    if game.ReplicatedStorage.Weapons:FindFirstChild(Weapon) and game.ReplicatedStorage.Weapons[Weapon]:FindFirstChild("ammo") then
                        MaxAmmo = game.ReplicatedStorage.Weapons[Weapon].ammo.Value
                    end
                    local SlotFound = false
                    for x,y in pairs(_G.InvTable) do
                        if x ~= 1 and y[1] == "Fist" then
                            _G.InvTable[x] = {Weapon, false, MaxAmmo}
                            SlotFound = true
                            break
                        end
                    end
                    if not SlotFound then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "notification";
                            Text = "NO AVAILABLE SLOTS (DROP SOMETHING)";
                            Icon = "rbxassetid://2541869220";
                            Duration = 3;
                        })
                        Variables.Spawning = false
                        return
                    end
                elseif Type ~= "Gun" and Type ~= "Item" and Type ~= "Bow" then
                    _G.InvTable[1] = {Weapon, false, nil}
                    local AnimSet = game:GetService("ReplicatedStorage").animationSets.TPanimSets:FindFirstChild(Tables.Stats.WeaponStats[Weapon].animset)
                    game.Workspace.ServerStuff.getTPWeapon:FireServer(Weapon, AnimSet, "Fist")
                    local NewModel = Player.Character:WaitForChild(Weapon,10)
                    if NewModel == nil then
                        Variables.Spawning = false
                        return
                    end
                    game.Workspace.ServerStuff.getTPWeapon:FireServer(Weapon, AnimSet, "Fist", NewModel, true)
                end
                Variables.Spawning = false
                return
            end
            if WorkBench == nil or Player.Character == nil or not Player.Character:FindFirstChild("HumanoidRootPart") then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "notification";
                    Text = "Wait until a round starts to spawn items.";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                Variables.Spawning = false
                return -- get fucked I guess LOL
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Started Spawning";
                Text = "Please wait for up to 15 seconds for your item to spawn.";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
            game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(WorkBench,("workbenchblueprint%s"):format(Weapon),_G.Code1)
            repeat task.wait() until WorkBench:FindFirstChild("fakeItem")
            game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(WorkBench,"workbench",_G.Code1) 
            local SpawnedItem = game.Workspace.WeaponDrops:WaitForChild(Weapon,20)
            if SpawnedItem == nil then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "wtf";
                    Text = "Something went wrong, and I have no clue what it was.";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                Variables.Spawning = false
                return -- god said no spawning
            end
            if WorkBench == nil or Player.Character == nil or not Player.Character:FindFirstChild("HumanoidRootPart") then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Error";
                    Text = "Something interrupted the spawning process";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                Variables.Spawning = false
                return -- get fucked I guess LOL
            end
            game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.p,game.Workspace.CurrentCamera.CFrame.p + Vector3.new(0,-100,0))
            Toggles.LockCamera = true
            local ReturnPosition = Player.Character.HumanoidRootPart.CFrame
            Player.Character.HumanoidRootPart.CFrame = SpawnedItem:FindFirstChildOfClass("Part").CFrame
            task.wait(0.3)
            local AnimSet = game:GetService("ReplicatedStorage").animationSets.TPanimSets:FindFirstChild(Tables.Stats.WeaponStats[Weapon].animset)
            ServerStuff.claimItem:InvokeServer(SpawnedItem)
            if Type == "Gun" or Type == "Item" or Type == "Bow" then
                ServerStuff.getTPWeapon:FireServer(Weapon, AnimSet, "Fist", SpawnedItem, false)
            elseif Type ~= "Gun" and Type ~= "Item" and Type ~= "Bow" then
                ServerStuff.getTPWeapon:FireServer(Weapon, AnimSet, "Fist", SpawnedItem, true)
            end
            ServerStuff.claimItem:InvokeServer(SpawnedItem)
            if Type == "Gun" or Type == "Item" or Type == "Bow" then
                local MaxAmmo = 1
                if game.ReplicatedStorage.Weapons:FindFirstChild(Weapon) and game.ReplicatedStorage.Weapons[Weapon]:FindFirstChild("ammo") then
                    MaxAmmo = game.ReplicatedStorage.Weapons[Weapon].ammo.Value
                end
                local SlotFound = false
                for x,y in pairs(_G.InvTable) do
                    if x ~= 1 and y[1] == "Fist" then
                        _G.InvTable[x] = {Weapon, false, MaxAmmo}
                        SlotFound = true
                        break
                    end
                end
                if not SlotFound then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "notification";
                        Text = "NO AVAILABLE SLOTS (DROP SOMETHING)";
                        Icon = "rbxassetid://2541869220";
                        Duration = 3;
                    })
                    Variables.Spawning = false
                    return
                end
            elseif Type ~= "Gun" and Type ~= "Item" and Type ~= "Bow" then
                _G.InvTable[1] = {Weapon, false, nil}
            end
            task.wait(0.1)
            SpawnedItem:Destroy()
            Player.Character.HumanoidRootPart.CFrame = ReturnPosition
            Toggles.LockCamera = false
            game.StarterGui:SetCore("SendNotification", {
                Title = "Item Spawned";
                Text = "Equip a different slot to see it in your inventory";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
            if Type ~= "Gun" then
                Variables.Spawning = false
                return
            end
            Variables.Spawning = false
        end;
    };
    loopdrop = {
        Aliases = {"loopdrop","loopspawn","droploop","keepdropping","spawnloop","rapiddrop","rapidspawn"};
        Description = "Loop drops the specified item";
        Function = function(Enabling,Args)
            if Enabling == true then
                if Args[1] == nil then
                    return
                end
                if Args[2] ~= nil then
                    Args[1] = Args[1].." "..Args[2]
                end
                if Args[3] ~= nil then
                    Args[1] = Args[1].." "..Args[3]
                end
                local FoundToDrop = false
                local ToDrop = ""
                for i,v in pairs(Tables.Lists.Weapons) do
                    if string.sub(string.lower(i),1,#Args[1]) == string.lower(Args[1]) then
                        ToDrop = v
                        FoundToDrop = true
                        break
                    end
                end
                if FoundToDrop == false then
                    return
                end
                if Player.Character == nil or not Player.Character:FindFirstChild("valids") then
                    return
                end
                if not Player.Character.valids:FindFirstChild(ToDrop) then
                    Players:Chat(":spawn "..Args[1]) -- LOL
                    repeat task.wait() until Player.Character == nil or Player.Character:FindFirstChild(ToDrop)
                end
                if Variables.RenderStepConnection == nil then
                    Variables.RenderStepConnection = game:GetService("RunService").Stepped:Connect(RenderStepped)
                end
                if Tables.OriginalStats[ToDrop] == nil then
                    local NewTable = {}
                    for i,v in pairs(Tables.Stats.WeaponStats[ToDrop]) do
                        NewTable[i] = v
                    end
                    Tables.OriginalStats[ToDrop] = NewTable
                end
                Variables.ToLoopDrop = ToDrop
                Toggles.LoopDrop = Enabling
                currenttext = "Now loopdropping "..Variables.ToLoopDrop
            else
                StopLoops()
                Variables.ToLoopDrop = ""
                currenttext = "LoopDrop is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    infammo = {
        Aliases = {"infammo","infiniteammo","infreserve","infinitereserve"};
        Description = "Gives you (almost) infinite of every ammo type";
        Function = function(Enabling,Args)
            Toggles.InfAmmo = Enabling
            local currenttext = ""
            if Enabling == true then
                for i,v in pairs(_G.AmmoTable) do
                    _G.AmmoTable[i] = math.huge
                end
                currenttext = "InfAmmo is now ON!"
            else
                for i,v in pairs(_G.AmmoTable) do
                    _G.AmmoTable[i] = 20
                end
                currenttext = "InfAmmo is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
   ammo = {
        Aliases = {"light","small","short","medium","heavy","long","shells"};
        Description = "Gives you NUMBER of AMMOTYPE (:AMMOTYPE NUMBER)";
        Function = function(Enabling,Args)
            local AmmoName = string.upper(string.sub(Args.Command,1,1))..string.sub(Args.Command,2,-1)
            if Player.Character == nil or not Player.Character:FindFirstChild("ammo_folder") then
                return
            end
        	if _G.AmmoTable[AmmoName] ~= nil and tonumber(Args[1]) ~= nil then 
                if Player.Character["ammo_folder"]:FindFirstChild(AmmoName.." Ammo") and Player.Character["ammo_folder"][AmmoName.." Ammo"].Value > 100000 then
                    _G.AmmoTable[AmmoName] = tonumber(Args[1])
                else
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "ERROR";
                        Text = "spawn a weapon that uses the type of ammo you want first";
                        Icon = "rbxassetid://2541869220";
                        Duration = 6;
                    })
                    return
                end
            end
        end;
    };
   food = {
        Aliases = {"mre","soda","beans","water","cola","bottle"};
        Description = "Gives you NUMBER of FOODTYPE (:FOODTYPE NUMBER)";
        Function = function(Enabling,Args)
            if tonumber(Args[1]) == nil then
                return
            end
            local FoodName = string.gsub(Args.Command, "water", "Bottle")
            FoodName = string.gsub(FoodName, "mre", "MRE")
            FoodName = string.gsub(FoodName, "cola", "Soda")
            FoodName = string.upper(string.sub(FoodName,1,1))..string.sub(FoodName,2,-1)
            _G.FoodTable[FoodName] = tonumber(Args[1])
        end;
    };
   scrap = {
        Aliases = {"scrap","junk"};
        Description = "Sets your scrap";
        Function = function(Enabling,Args)
            if tonumber(Args[1]) == nil then
                return
            end
            workspace.ServerStuff.dropAmmo:FireServer("scrap", tonumber(Args[1]))
        end;
    };
    infclip = {
        Aliases = {"infclip","infiniteclip","infmag","infinitemag","infshots","infiniteshots","infshoot","infiniteshoot","bottomlessmags"};
        Description = "Makes your clips bottomless";
        Function = function(Enabling,Args)
            Toggles.InfClip = Enabling
            local currenttext = ""
            if Enabling == true then
                local Pee = getsenv(GrabMainScript())
                local GetSex = getupvalues(Pee.unloadgun)
                for i,v in pairs(GetSex) do
                    if typeof(v) == "table"  then
                        for x,y in pairs(v) do
                            if typeof(y) == "table" then
                                for n,m in pairs(y) do
                                    if y[n] == tonumber(Variables.ClipLabel.Text) then
                                        y[n] = 999999999
                                    end
                                end
                            end
                        end
                    end
                end
                Pee = nil
                GetSex = nil
                Variables.ClipLabel.Text = "999999999"
                currenttext = "InfClip is now ON!"
            else
                if Player.Character == nil then
                    return
                end
                local MaxAmmo = 1
                local CurrentGun = Player.Character:FindFirstChildOfClass("Model")
                if CurrentGun == nil then
                    return
                end
                CurrentGun = CurrentGun.Name
                if game.ReplicatedStorage.Weapons:FindFirstChild(CurrentGun) and game.ReplicatedStorage.Weapons[CurrentGun]:FindFirstChild("ammo") then
                    MaxAmmo = game.ReplicatedStorage.Weapons[CurrentGun].ammo.Value
                end
                local Pee = getsenv(GrabMainScript())
                local GetSex = getupvalues(Pee.unloadgun)
                for i,v in pairs(GetSex) do
                    if typeof(v) == "table"  then
                        for x,y in pairs(v) do
                            if typeof(y) == "table" then
                                for n,m in pairs(y) do
                                    if y[n] == tonumber(Variables.ClipLabel.Text) then
                                        y[n] = MaxAmmo
                                    end
                                end
                            end
                        end
                    end
                end
                Pee = nil
                GetSex = nil
                Variables.ClipLabel.Text = tostring(MaxAmmo)
                currenttext = "InfClip is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    uses = {
        Aliases = {"setuse","setuses","uses","setammo","setmag","mag","arrows","arrow","ammo","clip","setclip"};
        Description = "Sets the magazine / uses of your currently held weapon to NUMBER. (:uses NUMBER)";
        Function = function(Enabling,Args)
            for i,v in pairs(_G.InvTable) do
                if v[3] == tonumber(Variables.ClipLabel.Text) then
                    v[3] = tonumber(Args[1])
                end
            end
            Variables.ClipLabel.Text = Args[1]
        end;
    };
    oneshot = {
        Aliases = {"oneshot","instantkill","instakill","onetap","infdamage"};
        Description = "Instantly kill any enemies you hit.";
        Function = function(Enabling,Args)
            Toggles.OneShot = Enabling
            local currenttext = ""
            if Enabling == true then
                currenttext = "OneShot is now ON!"
            else
                currenttext = "OneShot is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    silentaim = {
        Aliases = {"silentaim","alwayshit","nevermiss","aimbot"};
        Description = "Makes all your shots hit the target closest to your mouse.";
        Function = function(Enabling,Args)
            Toggles.SilentAim = Enabling
            local currenttext = ""
            if Enabling == true then
                currenttext = "SilentAim is now ON!"
            else
                currenttext = "SilentAim is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    autofarm = {
        Aliases = {"xpfarm","farm","afkfarm"};
        Description = "Automatically kills any enemies that spawn. Also automatically tries to prestige, and respawns you if you enter the main menu.";
        Function = function(Enabling,Args)
            Toggles.AutoFarm = Enabling
            local currenttext = ""
            if Enabling == true then
                Toggles.AutoKill = true
                for i,v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Torso") and v:FindFirstChild("Humanoid") then
                        if v.Parent.Name == "activeHostiles" or v.Parent.Name == "NoTarget" then
                            KnifeKill(v,true)
                        end
                    end
                end
                currenttext = "AutoFarm is now ON!"
            else
                Toggles.AutoKill = false
                currenttext = "AutoFarm is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    teamkill = {
        Aliases = {"killteam","teammatekill","friendlykill","friendlyfire","teamfire","friendlydamage","teamdamage"};
        Description = "Let's your do damage to your teammates";
        Function = function(Enabling,Args)
            Toggles.TeamKill = Enabling
            local currenttext = ""
            if Enabling == true then
                for i,v in pairs(game.Workspace.activePlayers:GetChildren()) do
                    if v ~= Player.Character then
                        v.Parent = game.Workspace
                    end
                end
                ServerStuff.changeStats:InvokeServer("changeclass", "revolver")
                currenttext = "TeamKill is now ON!"
            else
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v ~= Player and v.Character ~= nil and v.Character.Parent == game.Workspace then
                        v.Character.Parent = game.Workspace.activePlayers
                    end
                end
                ServerStuff.changeStats:InvokeServer("changeclass", Variables.PreviousClass)
                currenttext = "TeamKill is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    overheal = {
        Aliases = {"superheal","healmore","ultraheal","lazarusheal","bypassheal"};
        Description = "Heals NUMBER over your max health (:overheal NUMBER)";
        Function = function(Enabling,Args)
            if tonumber(Args[1]) == nil then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "wtf";
                    Text = "that wasn't a number";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                return
            end
            local Amount = math.floor(tonumber(Args[1])/8)
            local LeftOver = Args[1]%8
            for i = 1,Amount do
                coroutine.resume(coroutine.create(function()
                    ServerStuff.dealDamage:FireServer("lazarusheal", 8, _G.Code1, _G.Code2)
                end))
            end
            ServerStuff.dealDamage:FireServer("lazarusheal", LeftOver, _G.Code1, _G.Code2)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Success!";
                Text = "Overhealed "..Args[1].." health";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    sethealth = {
        Aliases = {"healto","healthset","setcurrenthealth","setheal"};
        Description = "Sets your health to NUMBER (:sethealth NUMBER)";
        Function = function(Enabling,Args)
            if tonumber(Args[1]) == nil then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "wtf";
                    Text = "that wasn't a number";
                    Icon = "rbxassetid://2541869220";
                    Duration = 3;
                })
                return
            end
            if Player.Character == nil or not Player.Character:FindFirstChild("Humanoid") then
                return
            end
            local CurrentHealth = Player.Character.Humanoid.Health
            local Difference = math.floor(tonumber(Args[1])) - CurrentHealth
            if Difference < 0 then
                ServerStuff.changeStats:InvokeServer("changeclass", "revolver")
                task.wait(0.1)
                Difference = Difference*-1
                local Amount = math.floor(Difference/150)
                local LeftOver = math.floor(Difference%150)
                for i = 1,Amount do
                    coroutine.resume(coroutine.create(function()
                        ServerStuff.dealDamage:FireServer("revolver_shot", {Player.Character,150}, _G.Code1, _G.Code2)
                    end))
                end
                if LeftOver >= 1 then
                    ServerStuff.dealDamage:FireServer("revolver_shot", {Player.Character,LeftOver}, _G.Code1, _G.Code2)
                end
                ServerStuff.changeStats:InvokeServer("changeclass", Variables.PreviousClass)
            else
                local Amount = math.floor(Difference/8)
                local LeftOver = math.floor(Difference%8)
                for i = 1,Amount do
                    coroutine.resume(coroutine.create(function()
                        ServerStuff.dealDamage:FireServer("lazarusheal", 8, _G.Code1, _G.Code2)
                    end))
                end
                if LeftOver >= 1 then
                    ServerStuff.dealDamage:FireServer("lazarusheal", LeftOver, _G.Code1, _G.Code2)
                end
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Success!";
                Text = "Brought your health to "..Args[1].." health";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    stealth = {
        Aliases = {"stealth","hide","hidden","scav","goinvis","invis","undetectable","antidetection","nodetection"};
        Description = "Completely hides you from NPCs";
        Function = function(Enabling,Args)
            Toggles.Stealth = Enabling
            if _G.EffectsTable == nil then
                GrabEssentials()
            end
            local currenttext = ""
            if Enabling == true then
                local ToSet = {}
                ToSet.mainstats = Tables.Stats.StatusStats["Stealth"]
                ToSet.effects = {
                	corename = "Stealth", 
                	currentloop = nil, 
                	currentduration = tick(), 
                	maxduration = math.huge, 
                	currentgui = nil, 
                	currentpos = 0, 
                	ticks = {}, 
                	colour = ToSet.mainstats.colour,
                }
                _G.EffectsTable["Cloaked"] = ToSet
                currenttext = "NoDetection is now ON!"
            else
                if _G.EffectsTable["Cloaked"] ~= nil then
                    _G.EffectsTable["Cloaked"] = nil
                end
                currenttext = "NoDetection is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
    controlmode = {
        Aliases = {"control","rts","strategy","strategymode","controlnpcs","chessmode","rtsmode"};
        Description = "Turn the game into a real time strategy game.";
        Function = function(Enabling,Args)
            local currenttext = ""
--[[
            if Enabling == true then
                StartRTS()
                if Player.PlayerGui:FindFirstChild("mainHUD") then
                    if _G.EffectsTable == nil then
                        GrabEssentials()
                    end
                    local ToSet = {}
                    ToSet.mainstats = Tables.Stats.StatusStats["Stealth"]
                    ToSet.effects = {
                    	corename = "Stealth", 
                    	currentloop = nil, 
                    	currentduration = tick(), 
                    	maxduration = math.huge, 
                    	currentgui = nil, 
                    	currentpos = 0, 
                    	ticks = {}, 
                    	colour = ToSet.mainstats.colour,
                    }
                    _G.EffectsTable["Cloaked"] = ToSet
                end
                if Variables.RenderStepConnection == nil then
                    Variables.RenderStepConnection = game:GetService("RunService").Stepped:Connect(RenderStepped)
                end
                currenttext = "ControlMode is now ON!"
            else
                if Player.PlayerGui:FindFirstChild("mainHUD") then
                    if _G.EffectsTable == nil then
                        GrabEssentials()
                    end
                    if _G.EffectsTable["Cloaked"] ~= nil then
                        _G.EffectsTable["Cloaked"] = nil
                    end
                end
                StopRTS()
                StopLoops()
                currenttext = "ControlMode is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
--]]
        end;
    };
    nofog = {
        Aliases = {"removefog","fogblock","blockfog","fog","antifog"};
        Description = "Instantly kill any enemies you hit.";
        Function = function(Enabling,Args)
            Toggles.NoFog = Enabling
            local currenttext = ""
            if Enabling == true then
                currenttext = "NoFog is now ON!"
            else
                currenttext = "NoFog is now OFF!"
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "notification";
                Text = currenttext;
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
        end;
    };
}

Player.Chatted:Connect(function(Message)
    local Args = GetArgs(Message)
    local Prefix = string.sub(Args.Command,1,2)
    local Enabling = true
    if Prefix == "un" then
        Args.Command = string.sub(Args.Command,3,-1)
        Enabling = false
    end
    if Commands[Args.Command] then
        Commands[Args.Command].Function(Enabling,Args)
    else
        for i,v in pairs(Commands) do
            if table.find(v.Aliases, Args.Command) then
                v.Function(Enabling,Args)
                break
            end
        end
    end
end)
if ActivePlayers:FindFirstChild(Player.Name) then
    CharacterLoaded(ActivePlayers:FindFirstChild(Player.Name))
end
for i,v in pairs(Player.PlayerGui:GetDescendants()) do
    StatusHandler(v)
end
ActivePlayers.ChildAdded:Connect(function(Character)
    if Character.Name ~= Player.Name then
        if Toggles.TeamKill then
            task.wait()
            Character.Parent = game.Workspace
        else
            return
        end
    end
    task.wait(0.1)
    if Character.Parent ~= ActivePlayers then
        return
    end
    CharacterLoaded(Character)
end)

--[[
Player.CharacterAdded:Connect(function()
    wait(1)
    if Toggles.ControlMode then
        StartRTS(true)
    end
end)
--]]

Players.ChildAdded:Connect(EnemyHandler)
Player.PlayerGui.DescendantAdded:Connect(StatusHandler)
game.Workspace.DescendantAdded:Connect(WorkspaceHandler)

UserInputService.InputBegan:Connect(function(inputobject, stuffhappening)
    if tostring(UserInputService:GetFocusedTextBox()) == "ChatBar" then
        return
    end
    local key = string.gsub(string.lower(tostring(inputobject.KeyCode)), "enum.keycode.", "")

    if key == "leftshift" then
        Tables.SuperRun.ShiftHeld = true
        return
    end
    if key == "w" then
        Tables.SuperRun.WHeld = true
        return
    end
    if key == "s" then
        Tables.SuperRun.SHeld = true
        return
    end
    if key == "a" then
        Tables.SuperRun.AHeld = true
        return
    end
    if key == "d" then
        Tables.SuperRun.DHeld = true
        return
    end
    if key == "l" then
        Toggles.SuperRun = not Toggles.SuperRun
        local currenttext = ""
        if Toggles.SuperRun == true then
            if Variables.RenderStepConnection == nil then
                Variables.RenderStepConnection = game:GetService("RunService").Stepped:Connect(RenderStepped)
            end
            currenttext = "SuperRun is now ON!"
        else
            StopLoops()
            currenttext = "SuperRun is now OFF!"
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "notification";
            Text = currenttext;
            Icon = "rbxassetid://2541869220";
            Duration = 3;
        })
        return
    end
    if key == "minus" then        
        Tables.SuperRun.RunSpeed = Tables.SuperRun.RunSpeed - 0.1
        game.StarterGui:SetCore("SendNotification", {
            Title = "notification";
            Text = "Your Super-Run speed is now "..tostring(Tables.SuperRun.RunSpeed).."!";
            Icon = "rbxassetid://2541869220";
            Duration = 3;
        })
        return
    end
    if key == "equals" then        
        Tables.SuperRun.RunSpeed = Tables.SuperRun.RunSpeed + 0.1
        game.StarterGui:SetCore("SendNotification", {
            Title = "notification";
            Text = "Your Super-Run speed is now "..tostring(Tables.SuperRun.RunSpeed).."!";
            Icon = "rbxassetid://2541869220";
            Duration = 3;
        })
        return
    end

    if key == "r" and _G.Code1 ~= nil then
        Toggles.AutoParry = true
        game.Workspace.ServerStuff.initiateblock:FireServer(_G.Code1, true)
    end

    if key == "v" and Player.Character ~= nil and Player.Character:FindFirstChildOfClass("Model") then
        local CurrentWeapon = Player.Character:FindFirstChildOfClass("Model").Name
        if Tables.OriginalStats[CurrentWeapon] == nil then
            return
        end
        local OriginalAnimset = Tables.OriginalStats[CurrentWeapon].animset
        if OriginalAnimset == "PST" or OriginalAnimset == "2HPST" or OriginalAnimset == "RV" or OriginalAnimset == "MRV" then
            return
        end
        if Tables.OriginalStats[CurrentWeapon].weapontype ~= "Gun" then
            game.StarterGui:SetCore("SendNotification", {
                Title = "ERROR";
                Text = "You can only dual wield guns!";
                Icon = "rbxassetid://2541869220";
                Duration = 3;
            })
            return
        end
        local TempEnv = getsenv(GrabMainScript())
        Tables.Stats.WeaponStats[CurrentWeapon].animset = "PST"
        TempEnv.start_dual_wield()
        task.wait()
        Tables.Stats.WeaponStats[CurrentWeapon].animset = OriginalAnimset
    end  

    if key == "y" and _G.Code1 ~= nil and _G.Code2 ~= nil then
        if Variables.CurrentThrowable == "TKnife" then
            Toggles.ThrowingKnives = true
            repeat
                local Data = Tables.Stats.WeaponStats["TKnife"]
                local CameraCFrame = game.Workspace.CurrentCamera.CFrame
                local Position = CFrame.new(CameraCFrame.p + Vector3.new(math.random(-12,12),math.random(-3,12),5),Mouse.Hit.p)
                coroutine.resume(coroutine.create(function()
                    workspace.ServerStuff.throwWeapon:FireServer("TKnife", 1000, Position, 0.19341856241226196, Data, 0, false, _G.Code1, nil, _G.Code2)
                end))
                task.wait(0.0000000000000000001)
            until Toggles.ThrowingKnives == false
        elseif Variables.CurrentThrowable ~= "Nothing" then
            if Debounces.Throwing then
                return
            end
            Debounces.Throwing = true
            local AnimSet = game.ReplicatedStorage.animationSets.TPanimSets.global
            repeat game.Workspace.ServerStuff.getTPWeapon:FireServer(Variables.CurrentThrowable, AnimSet, "Fist", nil, false) task.wait() until Player.Character:WaitForChild(Variables.CurrentThrowable,5)
            local Data = Tables.Stats.WeaponStats[Variables.CurrentThrowable]
            if Player.Character:FindFirstChild(Variables.CurrentThrowable) and Data ~= nil then
                workspace.ServerStuff.throwWeapon:FireServer(Variables.CurrentThrowable, 0, game.Workspace.CurrentCamera.CFrame, 0.19530236721038818, Data, 1, false, _G.Code1, nil, _G.Code2)
            end
            Debounces.Throwing = false
        end
        return
    end

    if key == "c" and Toggles.InfAux then
        local Env = getsenv(GrabMainScript())
        if Env["aux_usage"] ~= nil and Env["aux_usage"] <= 0 then
            if Env["use_aux"] ~= nil then
                Env["aux_usage"] = math.huge
                task.wait()
                Env["use_aux"]()
            end
        end
        Env = nil
        return
    end

    if key == "u" and _G.Code1 ~= nil and _G.Code2 ~= nil and Debounces.Trap == false then
        Debounces.Trap = true
        if not Player:FindFirstChild(Variables.CurrentTrap) then
            local TrapItemName = Tables.Conversions.TrapToItemName[Variables.CurrentTrap]
            local AnimSet = game:GetService("ReplicatedStorage").animationSets.TPanimSets.global
            game.Workspace.ServerStuff.getTPWeapon:FireServer(TrapItemName, AnimSet, "Fist", nil, false)
            repeat task.wait() until Player.Character:FindFirstChild(TrapItemName)
        end
        game.Workspace.ServerStuff.deployTrap:FireServer(Variables.CurrentTrap, _G.Code1, _G.Code2)
        task.wait(0.8)
        Debounces.Trap = false
        return
    end

    if key == "n" then
        if Player.Character == nil or not Player.Character:FindFirstChild("Humanoid") then
            return
        end
        Heal()
        if _G.EffectsTable == nil then
            GrabEssentials()
        end
        for i,v in pairs(_G.EffectsTable) do
            if not string.find(i, "Virus") and v.effects ~= nil and v.effects.currentduration ~= nil and v.effects.colour ~= nil then
                if v.effects.colour == Color3.new(1,0.05,0.05) or v.effects.colour == false or i == "Burning" or i == "Exhaustion" then
                    v.effects.currentduration = 0
                end
            end
        end
        return
    end

    if key == "m" then
        for i,v in pairs(_G.EffectsTable) do
            if not string.find(i, "Virus") and v.effects ~= nil and v.effects.currentduration ~= nil and v.effects.colour ~= nil then
                if v.effects.colour == Color3.new(1,0.05,0.05) or v.effects.colour == false or i == "Burning" or i == "Exhaustion" then
                    v.effects.currentduration = 0
                end
            end
        end
        return
    end

end)

UserInputService.InputEnded:Connect(function(inputobject, stuffhappening)
    if tostring(UserInputService:GetFocusedTextBox()) == "ChatBar" then
        return
    end
    local key = string.gsub(string.lower(tostring(inputobject.KeyCode)), "enum.keycode.", "")

    if key == "leftshift" then
        Tables.SuperRun.ShiftHeld = false
        return
    end
    if key == "w" then
        Tables.SuperRun.WHeld = false
        return
    end
    if key == "s" then
        Tables.SuperRun.SHeld = false
        return
    end
    if key == "a" then
        Tables.SuperRun.AHeld = false
        return
    end
    if key == "d" then
        Tables.SuperRun.DHeld = false
        return
    end
    if key == "y" then
        Toggles.ThrowingKnives = false
    end
    if key == "r" and _G.Code1 ~= nil then
        Toggles.AutoParry = false
        game.Workspace.ServerStuff.initiateblock:FireServer(_G.Code1, false)
    end
end)

repeat task.wait() until Tables.Stats.WeaponStats ~= nil

for i,v in pairs(Tables.Stats.WeaponStats) do
    if Tables.OriginalStats[i] == nil and typeof(v) == "table" and v["weapontype"] ~= nil then
        local NewTable = {}
        for x,y in pairs(v) do
            if x == "damagerating" then
                local NewDamageTable = {}
                for n,m in pairs(v["damagerating"]) do
                    NewDamageTable[n] = m
                end
                NewTable["damagerating"] = NewDamageTable
            else
                NewTable[x] = y
            end
        end
        Tables.OriginalStats[i] = NewTable
    end
end
Players.PlayerRemoving:Connect(function(plr)
    if plr == Player then
        ServerStuff.changeStats:InvokeServer("changeclass", Variables.PreviousClass)
    end
end)

for i,v in pairs(game.Workspace:GetDescendants()) do
    if v ~= nil and v.Parent ~= nil then
        EspHandle(v)
    end
    if v:IsA("Model") and v:FindFirstAncestor("FPArms") and v.Name ~= "LeftArm" and v.Name ~= "RightArm" then
        Variables.ShownWeapon = v.Name
    end
end

--[[
local CmdsMsg = "\n!!! ALL COMMANDS CAN BE DONE AS WITH /e IN FRONT OF THEM FOR SILENT COMMANDS !!!\n"
for i,v in pairs(Commands) do
    CmdsMsg = CmdsMsg.."\n:"..i.." - "..v["Description"].."\n:un"..i.." - Turns off "..i.."\n"
end
warn(CmdsMsg)
--]]
warn([[
COMMANDS CAN BE DONE AS /e command OR :command

:god - Regens you when you take damage. (Won't save you from dynamite)
:ungod -- Turns off semi godmode

:nodebuff - Blocks all status effects. Moral, burning, bleeding, broken limbs, etc
:unnodebuff - Turns off no-debuff

:nocooldown - Removes all ability cooldowns (F key, assuming you have a perk equipped) (Also gives you inf auxiliary, which is the C key)
:cooldown - Sets your cooldowns back to normal

:AMMOTYPE NUMBER - sets your stash of AMMOTYPE to NUMBER (:light 50) (shells 20)
:FOODTYPE NUMBER - sets your stash of FOODTYPE to NUMBER (:mre 20) (:water 5) (:beans 60) (:cola 200)

:heal - Heals you, and removes status effects.
:cleareffects - Clears all status effects and debuffs

:overheal NUMBER - Heals you by NUMBER (can bypass your max health)
:healto NUMBER - Heals your health up to NUMBER (can't go down)

:stopvirus - halts your virus progression
:resetvirus - resets your current virus progression (will not revert stages)

:oneshot - enemies you hit will die after one hit
:unoneshot - turns off oneshot

:silentaim - makes it so you always hit the enemy closest to your mouse
:unsilentaim - turns off silent aim

:infmag - makes your mags bottomless
:uninfmag - makes the weapon you're currently holding no longer have a bottomless mag
:infreserve - gives you (almost) infinite reserve ammo
:uninfreserve - disables infinite reserve ammo

:norecoil - stops your camera from shaking
:unnorecoil - turns off no recoil

:nospread - Removes spread when you shoot
:unnospread - Adds back spread

:nofalldamage - counters fall damage
:unnofalldamage - uncounters fall damage

:superrun - enables super run
:unsuperrun - disables super run

:infstam - Gives you infinite stamina
:uninfstam - Removes infinite stamina

:nohunger - makes your hunger and thirst bar last indefinitely
:unnohunger - removes no hunger
:fill - fills your hunger and thirst bar

:killaura - turns killaura on (kills all enemies within a certain distance)
:killaura NUMBER - sets the kill radius for killaura to NUMBER (default is 30)
:unkillaura - turns off killaura

:killenemies - kills every enemy that's currently alive
:killenemies NUMBER - kills every enemies within NUMBER studs of you

:backpack - Gives you a backpack (gives you 2 more inventory slots)

:spawn WEAPONNAME - gives you WEAPONNAME (cannot be dropped) (guns require an empty slot)
:weaponnames - prints all the available weapon names in the dev console

:teamkill - Let's your do damage to your teammates
:unteamkill - Turns off teamkill

:loopdrop ITEMNAME - rapidly drops ITEMNAME
:unloopdrop ITEMNAME

:infaux - Gives you infinite auxiliary equipment (Activated with C Key)
:uninfaux - Turns off infaux

:settrap TRAPNAME - sets the trap that gets placed when you press the U key

:setthrow THROWABLENAME - sets the throwable that's thrown when you press the Y key

:uses NUMBER - sets the uses / magazine of your current item to NUMBER

:stealth - makes you invisible to NPCs (Castle NPCs will still get angry if attacked, and the sledge queen and cultists can still see you)
:unstealth - unstealths you

:cig - makes you super cool
:uncig - frees you of your nicotine addiction

N Key: Heal and remove effects
M Key: Remove effects
U Key: Place set trap (use :settrap TRAPNAME to change the trap set with this key)
Y Key: Hold to spam throw throwing knives, which one shot enemies
V Key: Dual wield any weapon (not just one handeds) (this is probably the most cursed feature)
R Key: While holding the R key, incoming melee attacks are automatically parried
T Key: Access game & Goodwill GUI

L Key: Toggle super run
- Key: Lower super run speed
+ Key: Increase super run speed


!! HOLD T TO ACCESS THE GUI (FEATURES IN THE GOODWILL, ESP, AND WEAPONRY TABS) !!

- Toggle features in the GOODWILL tab
- Toggle ESP elements in the ESP tab
- Customize your held weapon's stats in the WEAPONRY tab
- Change your stats in the CHANGE STATS tab

]])

repeat task.wait() until _G.Code1 ~= nil and _G.Code2 ~= nil

game.StarterGui:SetCore("SendNotification", {
    Title = 'GOODWILL';
    Text = "SUCCESSFULLY INJECTED, F9 FOR CMDS                    (MADE BY AIDEZ)";
    Icon = "rbxassetid://2541869220";
    Duration = 7;
})
