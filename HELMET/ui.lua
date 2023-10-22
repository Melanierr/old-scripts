local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local result = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return obf_tableconcat(result);
end
local v0 = game.Players.LocalPlayer;
local v1 = v0.Backpack;
local v2 = v0.Character;
local v3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))();
local v4 = v3.CreateLib(LUAOBFUSACTOR_DECRYPT_STR_0("\249\230\247\8\195\143", "\126\177\163\187\69\134\219\167"), LUAOBFUSACTOR_DECRYPT_STR_0("\16\212\36\196\236\48\200", "\156\67\173\74\165"));
local v5 = v4:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\25\182\64\24", "\38\84\215\41\118\220\70"));
local v6 = v5:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\125\25\48\23\190\71\31\46\30\190\82\19\98\19\250\84\19\38\83", "\158\48\118\66\114"));
v6:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\130\42\22\118\82\168\246\164", "\155\203\68\112\86\19\197"), "", function()
	local v10 = 957 - (892 + 65);
	local v11;
	while true do
		if ((v10 == (2 - 1)) or (4593 <= 2672)) then
			v11:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\101\209\63\236\115\113\255\253", "\152\38\189\86\156\32\24\133"), math.huge);
			for v56, v57 in pairs(v1:GetChildren()) do
				v57:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\221\90\170\73", "\38\156\55\199"), math.huge);
				v57:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\139\113\117\56\32\125\224\70", "\35\200\29\28\72\115\20\154"), math.huge);
			end
			break;
		end
		if ((v10 == 0) or (1168 > 3156)) then
			v11 = v2:FindFirstChildWhichIsA(LUAOBFUSACTOR_DECRYPT_STR_0("\45\176\222\211", "\84\121\223\177\191\237\76"));
			v11:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\154\91\196\175", "\161\219\54\169\192\90\48\80"), math.huge);
			v10 = 1 - 0;
		end
	end
end);
v6:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\111\67\19\49\9\100\9\55\76\80\1\49\76", "\69\41\34\96"), "", function()
	local v12 = v2:FindFirstChildWhichIsA(LUAOBFUSACTOR_DECRYPT_STR_0("\136\204\216\6", "\75\220\163\183\106\98"));
	v12:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\36\179\153\50\203\3\174\142", "\185\98\218\235\87"), v12:GetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\237\53\53\227\204\171\223\57", "\202\171\92\71\134\190")) + (183 - 83));
	v12:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\13\192\33\137\46\196\8\141\42\211\41\137\58\196\13\140\45", "\232\73\161\76"), 350 - (87 + 263));
	for v34, v35 in pairs(v1:GetChildren()) do
		local v36 = 0;
		while true do
			if ((v36 == (180 - (67 + 113))) or (572 > 4486)) then
				v35:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\157\208\80\88\12\186\205\71", "\126\219\185\34\61"), v35:GetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\42\199\76\119\108\118\231\226", "\135\108\174\62\18\30\23\147")) + 74 + 26);
				v35:SetAttribute(LUAOBFUSACTOR_DECRYPT_STR_0("\146\232\39\202\31\171\23\194\181\251\47\202\11\171\18\195\178", "\167\214\137\74\171\120\206\83"), 0 - 0);
				break;
			end
		end
	end
end);
local v5 = v4:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\189\249\33\72\249\171", "\199\235\144\82\61\152"));
local v7 = v5:NewSection("");
v7:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\34\24\188\38\30\86\156\24\55", "\75\103\118\217"), "", function()
	local function v13(v37)
		if ((tostring(v37.Name) == LUAOBFUSACTOR_DECRYPT_STR_0("\239\91\99\0\176\18\194", "\126\167\52\16\116\217")) or (tostring(v37.Name) == LUAOBFUSACTOR_DECRYPT_STR_0("\252\47\51\139\146\22\238\203\43", "\156\168\78\64\224\212\121"))) then
			local v53 = 0 + 0;
			local v54;
			while true do
				if ((1404 == 1404) and (v53 == (7 - 5))) then
					v54.OutlineTransparency = 0.3;
					break;
				end
				if (v53 == (953 - (802 + 150))) then
					v54.FillTransparency = 2 - 1;
					v54.OutlineColor = Color3.fromRGB(251 - 112, 0, 0 + 0);
					v53 = 999 - (915 + 82);
				end
				if ((v53 == (0 - 0)) or (3748 < 2212)) then
					v54 = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\47\231\162\198\11\231\162\198\19", "\174\103\142\197"), v37);
					v54.FillColor = Color3.fromRGB(255, 149 + 106, 335 - 80);
					v53 = 1;
				end
			end
		elseif ((tostring(v37.Name) == LUAOBFUSACTOR_DECRYPT_STR_0("\117\33\73\49\41\87\249\88", "\152\54\72\63\88\69\62")) or (1180 == 2180)) then
			local v58 = 0;
			local v59;
			while true do
				if ((4090 < 4653) and (v58 == (1188 - (1069 + 118)))) then
					v59.FillTransparency = 2 - 1;
					v59.OutlineColor = Color3.fromRGB(255, 557 - 302, 45 + 210);
					v58 = 2;
				end
				if ((0 - 0) == v58) then
					v59 = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\252\205\233\84\216\205\233\84\192", "\60\180\164\142"), v37);
					v59.FillColor = Color3.fromRGB(253 + 2, 255, 1046 - (368 + 423));
					v58 = 1;
				end
				if (v58 == 2) then
					v59.OutlineTransparency = 0.3 - 0;
					break;
				end
			end
		end
	end
	for v38, v39 in pairs(game.Workspace:GetChildren()) do
		v13(v39);
	end
	game.Workspace.ChildAdded:Connect(function(v40)
		v13(v40);
	end);
end);
v7:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\119\92\15\44\36\249\27\78\91\69\12\20\221", "\114\56\62\101\73\71\141"), "", function()
	local v14 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\143\230\201\207\171\249\218\199\189", "\164\216\137\187")).Map.Objectives;
	for v41, v42 in pairs(v14:GetChildren()) do
		local v43 = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\250\239\54\186\170\247\12\218\242", "\107\178\134\81\210\198\158"), v42);
	end
	v14.ChildAdded:Connect(function(v44)
		local v45 = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\16\7\133\206\166\49\9\138\210", "\202\88\110\226\166"), v44);
	end);
end);
v7:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\240\4\139\231\138\232\10\155\244\203\209\11\194\211\197\204\29", "\170\163\111\226\151"), "", function()
	local v15 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\38\63\160\51\93\39\40\18\53", "\73\113\80\210\88\46\87")).Map.Objectives;
	local v16 = v15:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\170\41\212\17\230\147\40\233\29\232\147", "\135\225\76\173\114"));
	if (v16 or (2652 < 196)) then
		v16:Destroy();
	end
end);
v7:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\57\229\189\179\167\253\161\21\255\248\155\169\164\164\27\255\188", "\199\122\141\216\208\204\221"), "", function()
	local v17 = 0;
	local v18;
	while true do
		if ((4135 < 4817) and (v17 == (18 - (10 + 8)))) then
			v18 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\154\210\2\251\107\230\172\222\21", "\150\205\189\112\144\24")).Map.Geometry.CameraRoom.KeycardSpawns:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\14\129\166\79\5\154\21", "\112\69\228\223\44\100\232\113"));
			if v18 then
				local v60 = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\252\22\0\219\186\117\129\220\11", "\230\180\127\103\179\214\28"), v18);
			end
			break;
		end
	end
end);
local v8 = v4:NewTab(LUAOBFUSACTOR_DECRYPT_STR_0("\188\0\77\64\235\83\237\141\11\92\67", "\128\236\101\63\38\132\33"));
local v9 = v8:NewSection(LUAOBFUSACTOR_DECRYPT_STR_0("\131\185\5\77\187\226\213\169\233\21\69\246\236\206\161\172", "\175\204\201\113\36\214\139"));
v9:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\117\201\56\211\18\66\140\38\212\1\75\192\117\223\5\84\197\59\219", "\100\39\172\85\188"), "", function()
	for v46, v47 in pairs(game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\159\125\169\140\58\174\121\173\133\55\158\108\182\146\50\170\125", "\83\205\24\217\224")).Modules.Client.BulletShells:GetChildren()) do
		for v50, v51 in pairs(v47:GetChildren()) do
			v51.Transparency = 3 - 2;
		end
	end
end);
v9:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\212\192\192\50\240\192\141\46\229\215\200\56\232\133\200\59\224\192\206\41\245", "\93\134\165\173"), "", function()
	game.Players.LocalPlayer.PlayerGui.Effects.Enabled = false;
end);
v9:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\152\231\205\206\56\220\187\121\182\230", "\30\222\146\161\162\90\174\210"), "", function()
	local v20 = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\201\71\119\2\241\71\126\13", "\106\133\46\16"));
	v20.Brightness = 2;
	v20.ClockTime = 456 - (416 + 26);
	v20.FogEnd = 319291 - 219291;
	v20.GlobalShadows = false;
	v20.OutdoorAmbient = Color3.fromRGB(55 + 73, 226 - 98, 566 - (145 + 293));
end);
v9:NewButton(LUAOBFUSACTOR_DECRYPT_STR_0("\119\48\103\245\87\73\66\37\51\240\83\71\80\52\122\242\93", "\32\56\64\19\156\58"), "", function()
	local v26 = workspace:FindFirstChildOfClass(LUAOBFUSACTOR_DECRYPT_STR_0("\110\205\247\68\91\251\142", "\224\58\168\133\54\58\146"));
	local v27 = game.Lighting;
	v26.WaterWaveSize = 0;
	v26.WaterWaveSpeed = 430 - (44 + 386);
	v26.WaterReflectance = 1486 - (998 + 488);
	v26.WaterTransparency = 0 + 0;
	v27.GlobalShadows = false;
	v27.FogEnd = 8999999915 - (166 + 261);
	for v48, v49 in pairs(v27:GetDescendants()) do
		if ((272 == 272) and (v49:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\123\90\94\239\80\128\129\14\90\66", "\107\57\54\43\157\21\230\231")) or v49:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\232\158\31\199\184\197\220\254\141\23\240\186\200", "\175\187\235\113\149\217\188")) or v49:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\30\163\142\67\238\92\126\58\170\130\88", "\24\92\207\225\44\131\25")) or v49:IsA(LUAOBFUSACTOR_DECRYPT_STR_0("\111\214\168\88\19\82\77\245\177\73\23\121\110\213\190\73\24\105", "\29\43\179\216\44\123")))) then
			v49.Enabled = false;
		end
	end
end);
