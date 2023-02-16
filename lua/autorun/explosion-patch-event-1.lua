---@diagnostic disable: undefined-global, undefined-field

AddCSLuaFile()

if SERVER then
	local function CreateGrenadeExplosion(pos)
		return ParticleEffect("hl2mmod_explosion_grenade", pos, Angle(0, math.random(0, 360), 0))
	end

	local function CreateRPGExplosion(pos)
		return ParticleEffect("hl2mmod_explosion_rpg", pos, Angle(0, math.random(0, 360), 0))
	end

	timer.Simple(0, function()
		TRACKING_EXPLOSIVES_RPGS = {}
		TRACKING_EXPLOSIVES_AR2 = {}
		TRACKING_EXPLOSIVES_GRENADES = {}

		if not file.Exists("autorun/ac_particles_remade.lua", "LUA") then
			if type(CheckForDynamite) == "function" then
				hook.Add("Tick", "CheckForDynamite", CheckForDynamite)
			end
			hook.Add("Think", "MMODExplosion2", function()
				for k, v in pairs(TRACKING_EXPLOSIVES_AR2) do
					if not (k:IsValid()) then
						CreateGrenadeExplosion(v)
						TRACKING_EXPLOSIVES_AR2[k] = nil
					end
				end
				for k, v in pairs(TRACKING_EXPLOSIVES_RPGS) do
					if not (k:IsValid()) then
						CreateRPGExplosion(v)
						TRACKING_EXPLOSIVES_RPGS[k] = nil
					end
				end
				--[=[
				for k, v in pairs(TRACKING_EXPLOSIVES_GRENADES) do
					if not (k:IsValid()) then
						CreateGrenadeExplosion(v)
						TRACKING_EXPLOSIVES_GRENADES[k] = nil
					end
				end
				]=]
				for _, v in pairs(ents.FindByClass("grenade_ar2")) do
					TRACKING_EXPLOSIVES_AR2[v] = v:GetPos()
				end
				for _, v in pairs(ents.FindByClass("sent_grenade_ar2")) do
					TRACKING_EXPLOSIVES_AR2[v] = v:GetPos()
				end
				for _, v in pairs(ents.FindByClass("rpg_missile")) do
					TRACKING_EXPLOSIVES_RPGS[v] = v:GetPos()
				end
				--[=[
				for _, v in pairs(ents.FindByClass("npc_grenade_frag")) do
					TRACKING_EXPLOSIVES_RPGS[v] = v:GetPos()
				end
				]=]
			end)
		end

		if type(CheckForCB) == "function" then
			hook.Add("Tick", "CheckForCB", CheckForCB)
		end
	end)

	local m_tGrenades = {}

	hook.Add("OnEntityCreated", "entCreatedGrenadeMMod", function(m_pEntity)
		if m_pEntity:GetClass() ~= "npc_grenade_frag" then return end

		m_tGrenades[#m_tGrenades + 1] = m_pEntity
	end)

	hook.Add("Tick", "grenadeBoombaMMod", function()
		for i = #m_tGrenades, 1, -1 do
			local m_pGrenade = m_tGrenades[i]

			if m_pGrenade:IsValid() then
				if m_pGrenade:GetInternalVariable("m_flDetonateTime") <= 0.01 then
					local m_vecOrigin = m_pGrenade:GetPos()
					m_pGrenade:Remove()

					CreateGrenadeExplosion(m_vecOrigin)

					local m_pExplosion = ents.Create("env_explosion")
					m_pExplosion:SetPos(m_vecOrigin)
					m_pExplosion:SetKeyValue("iMagnitude", "100")
					m_pExplosion:Spawn()
					m_pExplosion:Fire("Explode", 0, 0)
					m_pExplosion:Remove()
				end
			else
				table.remove(m_tGrenades, i)
			end
		end
	end)
end
