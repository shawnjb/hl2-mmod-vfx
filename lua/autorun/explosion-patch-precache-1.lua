---@diagnostic disable: undefined-global

AddCSLuaFile()

assert(
	CLIENT or SERVER,
	"Invalid execution context. This file should be executed on the server or the client."
)

game.AddParticles("particles/hl2mmod_explosions.pcf")
PrecacheParticleSystem("hl2mmod_explosion_grenade")
PrecacheParticleSystem("hl2mmod_explosion_rpg")

game.AddParticles("particles/grenade_fx.pcf")
