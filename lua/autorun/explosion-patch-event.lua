---@diagnostic disable: undefined-global

AddCSLuaFile()

if SERVER then
	function CheckForENVExplosion()
		local env_explosion = ents.FindByClass("env_explosion")
		for _, v in pairs(env_explosion) do
			local pos = v:GetPos()
			ParticleEffect("hl2mmod_explosion_rpg", pos, Angle(0, math.random(0, 360), 0))
			sound.Play("hd/new_grenadeexplo.mp3", pos, math.random(80, 120), math.random(80, 120), 1)
			v:Remove()
		end
	end
	hook.Add("Think", "MMODExplosion1", CheckForENVExplosion)
end
